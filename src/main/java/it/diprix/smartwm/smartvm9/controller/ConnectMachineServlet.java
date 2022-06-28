package it.diprix.smartwm.smartvm9.controller;
import it.diprix.smartwm.smartvm9.model.User;
import it.diprix.smartwm.smartvm9.service.DBHelper;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

@WebServlet(name = "ConnectMachineServlet", value = "/connect")
public class ConnectMachineServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.print("Working: ");
        out.println(request.getParameter("idMachine"));

        User user = (User) request.getSession().getAttribute("user");
        out.println(user.getEmail());

        request.getRequestDispatcher("customer/connected.jsp").forward(request, response);


        //Settare machine.status con id cliente
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String idMachine = request.getParameter("idMachine");
        request.setAttribute("idMachine", idMachine);
        double userCredit = user.getCredit();

        try{

            /*
            * CONTROLLO SE LA MACCHINETTA è READY
            * CONTROLLO SE NON HO GIA OCCUPATO UNA MACCHINETTA
            * OCCUPO LA MACCHINETTA
            */

            if(checkMachine(idMachine, user)){
                //MACCHINETTA LIBERA
                int status = DBHelper.updateConnectionMachine(idMachine, user.userIdToString(), userCredit);


                if(status == 1){
                    //MACCHINETTA LIBERA
                    //out.print("Macchnetta connessa");
                    System.out.println("Macchnetta connessa");

                    // response.sendRedirect("customer/connected.jsp");

                    request.getRequestDispatcher("customer/connected.jsp").forward(request, response);

                } else {
                    //out.print("Errore Connessione");
                    System.out.println("Errore Connessione");
                }
            } else {
                //MACCHINETTA OCCUPATA

                //out.print("Macchinetta Occupata");
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

            /*
             * CONTROLLO SE LA MACCHINETTA è READY
             * CONTROLLO SE NON HO GIA OCCUPATO UNA MACCHINETTA
             * OCCUPO LA MACCHINETTA
             */

            ResultSet rs = DBHelper.chackMachine(idMachine, user);

            return rs.next();


        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }


    }


}

