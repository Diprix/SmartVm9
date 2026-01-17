package it.diprix.smartwm.smartvm9.controller;

import it.diprix.smartwm.smartvm9.model.MachineProduct;
import it.diprix.smartwm.smartvm9.model.User;
import it.diprix.smartwm.smartvm9.service.DBHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "TecnicalConnectionServlet", value = "/TecnicalConnectionServlet")
public class TecnicalConnectionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idMachine = request.getParameter("idMachine");
        /*
            Settare stato come SERVICE
            aprire schermata lista prodotto
        */

        // Recupero informazioni utente
        User user = (User) request.getSession().getAttribute("user");
        request.setAttribute("idMachine", idMachine);


        try{


            // Controllo se la macchinetta e' disponibile
            if(checkMachine(idMachine, user)){
                //MACCHINETTA LIBERA

                // Aggiorno lo stato della macchinetta
                int status = DBHelper.updateConnectionMachine(idMachine, "service", 0);



                //Recupero i prodotti
                if(status > 0){
                    System.out.println("Macchnetta connessa");
                    List<MachineProduct> machineProductLsit = new ArrayList<>();

                    ResultSet resultSet = DBHelper.getProductList(idMachine);

                    while (resultSet.next()){
                        MachineProduct machineProduct = new MachineProduct();
                        machineProduct.setProductID(resultSet.getInt("ID"));
                        machineProduct.setDescription(resultSet.getString("PRODUCT"));
                        machineProduct.setPrice(resultSet.getDouble("PRICE"));
                        machineProduct.setQty(resultSet.getInt("QTY"));
                        machineProduct.setSelection(resultSet.getString("SEL"));
                        machineProductLsit.add(machineProduct);
                    }

                    response.setContentType("text/html");

                    // Invio al client una lista di MachineProduct
                    request.setAttribute("tecnicalProductList", machineProductLsit);

                    request.getRequestDispatcher("/WEB-INF/view/technical/connected.jsp").forward(request, response);

                } else {
                    System.out.println("Errore Connessione");
                }
            } else {
                //MACCHINETTA OCCUPATA

                System.out.println("Macchnetta Occupata");
                PrintWriter out = response.getWriter();
                out.print("Macchinetta Occupata");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private boolean checkMachine(String idMachine, User user){
        try {


            ResultSet rs = DBHelper.checkMachine(idMachine, user);

            return rs.next();


        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }


    }

}
