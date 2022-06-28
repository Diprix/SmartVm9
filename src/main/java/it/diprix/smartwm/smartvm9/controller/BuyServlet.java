package it.diprix.smartwm.smartvm9.controller;

import com.google.gson.Gson;
import it.diprix.smartwm.smartvm9.model.MachineProduct;
import it.diprix.smartwm.smartvm9.service.DBHelper;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.ResultSet;
import java.text.DecimalFormat;

@WebServlet(name = "BuyServlet", value = "/buy")
public class BuyServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.println("TEST BUY SERVLET");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        String idMachine =  request.getParameter("idMachine");
        String selection =  request.getParameter("selection");

        int userID;
        double machineCredit;


        try {

            ResultSet machineQueryRs = DBHelper.getMachineById(Integer.parseInt(idMachine));

            if(machineQueryRs.next()){
                userID = machineQueryRs.getInt("status");
                machineCredit = machineQueryRs.getDouble("credit");


                int rsStock = DBHelper.updateStockQuantity(Integer.parseInt(idMachine), selection);
                if(rsStock > 0) {

                ResultSet productQueryRs = DBHelper.getProduct(Integer.parseInt(idMachine), selection);

                if(productQueryRs.next()){

                        //Update success


                        int rsMachine = DBHelper.updateMachineCredit(Integer.parseInt(idMachine), productQueryRs.getDouble("price"), creditParse(machineCredit, productQueryRs.getDouble("price")));

                        if(rsMachine > 0) {
                            //Update success

                            // CREATE REPORT in Transaction

                            int fine = DBHelper.insertTransaction(productQueryRs.getInt("idstock"),  new Date(System.currentTimeMillis()), userID, Integer.parseInt(idMachine), (productQueryRs.getDouble("price")*-1));

                            if(fine >0){
                                System.out.println("Acquisto completato");

                                MachineProduct product = new MachineProduct();
                                product.setProductID(productQueryRs.getInt("idproduct"));
                                product.setSelection(productQueryRs.getString("selection"));

                                String productJSONString = new Gson().toJson(product);
                                request.setAttribute("product", productJSONString);
                                out.println(productJSONString);

                            }


                        } else {
                            //Update FAILED (credit error)
                            System.out.println("CREDIT ERROR");
                        }

                    } else {
                        //Update FAILED (qty error)
                        System.out.println("QTY ERROR");
                    }
                }
                // --------------



            }


        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    double creditParse(double machineCredit, double price) {
        double newCredit = machineCredit - price;

        String s = new DecimalFormat("#.##").format(newCredit);

        newCredit = Double.parseDouble(s.replace(",", "."));

        return newCredit;
    }

}
