package it.diprix.smartwm.smartvm9.controller;

import it.diprix.smartwm.smartvm9.model.User;
import it.diprix.smartwm.smartvm9.service.DBHelper;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

@WebServlet(name = "DisconnectMachineServlet", value = "/disconnect")
public class DisconnectMachineServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String idMachine = request.getParameter("idMachine");

        System.out.println("Disconnetto la macchinetta: " + idMachine);

        try{

            ResultSet CreditMachineRs = DBHelper.getMachineById(Integer.parseInt(idMachine));

            if(CreditMachineRs.next()){


                if(user != null) {
                    user.setCredit(CreditMachineRs.getDouble("credit"));
                    request.setAttribute("user", user);
                }

                int userResult = DBHelper.updateCreditByIdUser(CreditMachineRs.getString("status"), CreditMachineRs.getDouble("credit"));

                if(userResult > 0) {


                    int result = DBHelper.updateConnectionMachine(idMachine, "ready", 0.0);

                    if(result > 0){
                        System.out.println("Disconnessione eseguita");

                        PrintWriter out = response.getWriter();
                        out.print("disconnected");

                        //request.getRequestDispatcher("customer/mainpage.jsp").forward(request, response);
                    } else {
                        System.out.println("Errore disconnessione");

                    }

                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
//        String idMachine = request.getParameter("idMachine");
//
//        System.out.println("Disconnetto la macchinetta: " + idMachine);
//
//        try{
//
//
//            ResultSet CreditMachineRs = DBHelper.getMachineById(Integer.parseInt(idMachine));
//
//            if(CreditMachineRs.next()){
//
//                int userResult = DBHelper.updateCreditByIdUser(CreditMachineRs.getString("status"), CreditMachineRs.getDouble("credit"));
//
//
//                if(userResult > 0) {
//
//                    int result = DBHelper.disconnectionMachine(idMachine);
//
//
//                    if(result > 0){
//                        System.out.println("Disconnessione eseguita");
//
//                        PrintWriter out = response.getWriter();
//                        out.print("Borsellino");
//                    } else {
//                        System.out.println("Errore disconnessione");
//
//                    }
//
//                }
//
//            }
//
//            // ----------------
//
//
//
//            // ----------------
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }

}
