package it.diprix.smartwm.smartvm9.controller;

import it.diprix.smartwm.smartvm9.model.User;
import it.diprix.smartwm.smartvm9.service.DBHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;

@WebServlet(name = "CreditServlet", value = "/CreditServlet")
public class CreditServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        double credit = Double.parseDouble(request.getParameter("credit")); // Valore della ricarica


        try(Connection con = DBHelper.conn()){


            // Incremento il credito dell'utente
            double newCredit = user.increaseCredit(credit);

            //Aggiorno il DB
            PreparedStatement statement = con.prepareStatement("UPDATE user SET credit = ? WHERE iduser = ?");

            statement.setString(2, user.userIdToString());
            statement.setDouble(1, newCredit);

            int status = DBHelper.updateCreditByIdUser(user.userIdToString(), newCredit);

            if(status > 0){

               // Aggiorno il credito anche nella sessione
               user.setCredit(newCredit);
               request.getSession().setAttribute("user", user);

               // Registro la transazione
               DBHelper.insertTransaction(0,  new Date(System.currentTimeMillis()), user.getIduser(), 0, credit);

            }


            // Ritorno il credito per aggiornare la grafica
            PrintWriter out = response.getWriter();
            out.print(user.parseCredit());

            

        } catch (Exception e) {

            e.printStackTrace();

        }
    }
}
