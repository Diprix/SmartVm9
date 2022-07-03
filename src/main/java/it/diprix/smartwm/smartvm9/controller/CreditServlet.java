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
        double credit = Double.parseDouble(request.getParameter("credit"));


        try(Connection con = DBHelper.conn()){


            double newCredit = user.increaseCredit(credit);

            PreparedStatement statement = con.prepareStatement("UPDATE user SET credit = ? WHERE iduser = ?");

            statement.setString(2, user.userIdToString());
            statement.setDouble(1, newCredit);

            int status = DBHelper.updateCreditByIdUser(user.userIdToString(), newCredit);

            if(status > 0){
               user.setCredit(newCredit);
               request.getSession().setAttribute("user", user);

               DBHelper.insertTransaction(0,  new Date(System.currentTimeMillis()), user.getIduser(), 0, credit);

            }

            // request.getRequestDispatcher("WEB-INF/view/customer/mainpage.jsp").forward(request, response);

            PrintWriter out = response.getWriter();
            out.print(user.parseCredit());

            

        } catch (Exception e) {

            e.printStackTrace();

        }
    }
}
