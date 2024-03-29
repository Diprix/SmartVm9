package it.diprix.smartwm.smartvm9.controller;

import com.google.gson.Gson;
import it.diprix.smartwm.smartvm9.model.Transaction;
import it.diprix.smartwm.smartvm9.model.User;
import it.diprix.smartwm.smartvm9.service.DBHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "TransactionServlet", value = "/TransactionServlet")
public class TransactionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        List<Transaction> transactionList = new ArrayList<>();

        try{

            // Recupero le transazioni dell'utente
            ResultSet rs = DBHelper.getTransactionsByIdUser(user.getIduser());


            // Creo una lista di transazioni
            while(rs.next()){
                Transaction transaction = new Transaction();
                transaction.setAmount(rs.getDouble("amount"));
                transaction.setDate(rs.getDate("date_transaction"));
                transaction.setIdMachine(rs.getInt("cod_machine"));
                transaction.setIdUser(rs.getInt("cod_user"));
                transaction.setIdProduct(rs.getInt("ref_selection"));

                transactionList.add(transaction);
            }

            // Creo un JSON partendo dall'oggetto creato
            String transactionJSONString = new Gson().toJson(transactionList);
            System.out.println(transactionJSONString);

            // Invio il json al client
            response.setContentType("application/json");
            request.setAttribute("transactionList", transactionList);

            request.getRequestDispatcher("WEB-INF/view/customer/transaction.jsp").forward(request, response);



        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
