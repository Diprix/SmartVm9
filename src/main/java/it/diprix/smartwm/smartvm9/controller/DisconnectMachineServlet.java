package it.diprix.smartwm.smartvm9.controller;

import it.diprix.smartwm.smartvm9.model.User;
import it.diprix.smartwm.smartvm9.service.DBHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;

@WebServlet(name = "DisconnectMachineServlet", value = "/disconnect")
public class DisconnectMachineServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String idMachine = request.getParameter("idMachine");

        System.out.println("Disconnetto la macchinetta: " + idMachine);

        try{

            //Recuper le info della macchinetta
            ResultSet CreditMachineRs = DBHelper.getMachineById(Integer.parseInt(idMachine));

            if(CreditMachineRs.next()){


                // Aggiorno il credito dell'utente
                if(user != null) {
                    user.setCredit(CreditMachineRs.getDouble("credit"));
                    request.setAttribute("user", user);
                }

                int userResult = DBHelper.updateCreditByIdUser(CreditMachineRs.getString("status"), CreditMachineRs.getDouble("credit"));

                if(userResult > 0) {

                    // Libero la macchinetta e riporto il suo credito a 0
                    int result = DBHelper.updateConnectionMachine(idMachine, "ready", 0.0);

                    if(result > 0){
                        System.out.println("Disconnessione eseguita");


                        request.getRequestDispatcher("/WEB-INF/view/customer/mainpage.jsp").forward(request, response);
                    } else {
                        System.out.println("Errore disconnessione");

                    }

                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
