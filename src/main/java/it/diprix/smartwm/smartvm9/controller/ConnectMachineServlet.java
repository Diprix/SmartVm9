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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String idMachine = request.getParameter("idMachine");
        request.setAttribute("idMachine", idMachine);
        double userCredit = user.getCredit();

        response.setContentType("text/html");


        try{

            /*
            * CONTROLLO SE LA MACCHINETTA e' READY
            * CONTROLLO SE NON HO GIA OCCUPATO UNA MACCHINETTA
            * OCCUPO LA MACCHINETTA
            */

            if(checkMachine(idMachine, user)){
                //MACCHINETTA LIBERA

                //Occupo la macchinetta
                int status = DBHelper.updateConnectionMachine(idMachine, user.userIdToString(), userCredit);


                if(status == 1){
                    //MACCHINETTA LIBERA
                    System.out.println("Macchnetta connessa");


                    request.getRequestDispatcher("/WEB-INF/view/customer/connected.jsp").forward(request, response);

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

            /*
             * CONTROLLO SE LA MACCHINETTA e' READY
             * CONTROLLO SE NON HO GIA OCCUPATO UNA MACCHINETTA
             * OCCUPO LA MACCHINETTA
             */

            ResultSet rs = DBHelper.checkMachine(idMachine, user);

            return rs.next();


        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }


    }


}

