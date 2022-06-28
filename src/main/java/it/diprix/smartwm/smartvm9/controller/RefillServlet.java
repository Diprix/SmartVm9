package it.diprix.smartwm.smartvm9.controller;

import it.diprix.smartwm.smartvm9.service.DBHelper;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;


import java.io.IOException;

@WebServlet(name = "RefillServlet", value = "/RefillServlet")
public class RefillServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idMachine = request.getParameter("idMachine");
        System.out.println("Disconnessione macchinetta: " + idMachine);
        DBHelper.updateConnectionMachine(idMachine, "ready", 0);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idMachine = request.getParameter("idMachine");
        String selection = request.getParameter("selection");
        String qty = request.getParameter("qty");

        try{

            int result = DBHelper.updateStockQuantityRefill(Integer.parseInt(idMachine), selection, Integer.parseInt(qty));

            if(result > 0){
                System.out.println("AGGIORNATO");
            }

        }catch (Exception e){
            e.printStackTrace();
        }

    }
}
