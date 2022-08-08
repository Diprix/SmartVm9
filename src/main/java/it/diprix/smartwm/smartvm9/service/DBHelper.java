package it.diprix.smartwm.smartvm9.service;


import it.diprix.smartwm.smartvm9.model.User;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;

public class DBHelper {

    public static Connection conn() throws NamingException, SQLException {
        Context ctx = new InitialContext();
        DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/smartvm");
        Connection connection = ds.getConnection();
        return connection;
    }


    public static ResultSet loginUser(String email, String password){
        try(Connection con = conn()){
            PreparedStatement preparedStatement = con.prepareStatement("SELECT * from user WHERE email = ? AND password = ?");

            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            ResultSet rs = preparedStatement.executeQuery();

            return rs;

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static int registerUser(String name, String phone, String email, String password){
        try(Connection con = conn()){

            PreparedStatement preparedStatement = con.prepareStatement("INSERT INTO user (name, phone, email, user_type, password) value (?,?,?,?,?);");
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, phone);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, "CUSTOMER");
            preparedStatement.setString(5, password);

            return preparedStatement.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public static ResultSet getTransactionsByIdUser(int id){
        try(Connection con = conn()){
            PreparedStatement statement = con.prepareStatement("SELECT * FROM transaction WHERE cod_user = ? ORDER BY date_transaction DESC, idtransaction DESC LIMIT 4 ");
            statement.setInt(1, id);

            return  statement.executeQuery();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static ResultSet getMachineById(int id){
        try(Connection con = conn()){
            PreparedStatement preparedStatement = con.prepareStatement("SELECT * FROM machine WHERE idmachine = ?");
            preparedStatement.setInt(1, id);

            return preparedStatement.executeQuery();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static int updateCreditByIdUser(String id, double credit){
        try(Connection con = conn()){

            PreparedStatement preparedStatement = con.prepareStatement("UPDATE user SET credit = ? WHERE iduser = ?");
            preparedStatement.setDouble(1, credit);
            preparedStatement.setString(2, id);

            return preparedStatement.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public static int updateConnectionMachine(String id, String status, double credit){
        try(Connection con = conn()){

            PreparedStatement preparedStatement = con.prepareStatement("UPDATE machine SET status = ?, credit = ? WHERE idMachine = ?");

            preparedStatement.setString(1, status);
            preparedStatement.setDouble(2, credit);
            preparedStatement.setString(3, id);

            return preparedStatement.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public static ResultSet checkMachine(String id, User user) {
        try(Connection con = conn()){

            PreparedStatement statement = con.prepareStatement("" +
                    "select m1.idMachine " +
                    "from machine as m1 " +
                    "where m1.status = ? " +
                    "and idmachine = ? " +
                    "and m1.idMachine " +
                    "NOT IN (SELECT m2.idMachine FROM machine AS m2 WHERE m2.status = ?);");

            statement.setString(1, "ready");
            statement.setString(2, id);
            statement.setString(3, user.userIdToString());

            return statement.executeQuery();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static ResultSet getProductList(String id) {
        try(Connection con = conn()){

            PreparedStatement statement = con.prepareStatement(
                    "SELECT \n" +
                            "    p.idproduct as ID,\n" +
                            "    p.description as PRODUCT,\n" +
                            "    p.price as PRICE,\n" +
                            "    s.quantity as QTY,\n" +
                            "    s.selection as SEL\n" +
                            "FROM\n" +
                            "    product p,\n" +
                            "    machine m,\n" +
                            "    stock s\n" +
                            "WHERE\n" +
                            "    m.idmachine = s.ref_machine\n" +
                            "        AND s.ref_product = p.idproduct\n" +
                            "        AND idmachine = ? " +
                            "ORDER BY s.selection ASC"
            );

            statement.setString(1, id);

            con.close();
            return statement.executeQuery();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static int updateStockQuantity(int id, String selection){
        try(Connection con = conn()){

            PreparedStatement preparedStatement = con.prepareStatement(
                    "UPDATE stock SET quantity = CASE WHEN quantity > 0 THEN quantity - 1 ELSE 0 END " + //doppio controllo quantita' magiiore di 0
                            "WHERE ref_machine = ? AND selection = ? AND quantity > 0"
            );

            preparedStatement.setInt(1, id);
            preparedStatement.setString(2, selection);

            return preparedStatement.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public static ResultSet getProduct(int id, String selection) {
        try(Connection con = conn()){

            PreparedStatement statement = con.prepareStatement(
                    "SELECT * FROM product p, stock s, machine m WHERE p.idproduct = s.ref_product AND m.idmachine = s.ref_machine AND s.selection = ? AND m.idmachine = ?"
            );

            statement.setString(1, selection);
            statement.setInt(2, id);

            con.close();
            return statement.executeQuery();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static int updateMachineCredit(int id, double price, double newCredit){
        try(Connection con = conn()){

            PreparedStatement preparedStatement = con.prepareStatement(
                    "UPDATE machine SET credit = CASE WHEN credit > "+ price +" THEN "+ newCredit +" ELSE 0 END " + //doppio controllo quantita' magiiore di 0
                            "WHERE idmachine = ? AND credit >= " + price
            );

            preparedStatement.setInt(1, id);
            return preparedStatement.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public static int insertTransaction(int idstock, Date date, int userID, int machineID, double price){
        try(Connection con = conn()){

            PreparedStatement preparedStatement = con.prepareStatement(
                    "insert into transaction(ref_selection, date_transaction, cod_user, cod_machine, amount) values (?, ?, ?, ?, ?)"
            );


            preparedStatement.setInt(1, idstock);
            preparedStatement.setDate(2, date);
            preparedStatement.setInt(3, userID);
            preparedStatement.setInt(4, machineID);
            preparedStatement.setDouble(5, price);

            return preparedStatement.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public static int updateStockQuantityRefill(int id, String selection, int qty){
        try(Connection con = conn()){

            PreparedStatement preparedStatement = con.prepareStatement(
                    "UPDATE stock SET quantity = ? WHERE ref_machine = ? AND selection = ?"
            );

            preparedStatement.setInt(1, qty);
            preparedStatement.setInt(2, id);
            preparedStatement.setString(3, selection);

            return preparedStatement.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public static ResultSet getMachineList(){
        try(Connection con = conn()){
            PreparedStatement statement = con.prepareStatement("SELECT * FROM machine WHERE idmachine <> 0");

            return  statement.executeQuery();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return null;
    }

}