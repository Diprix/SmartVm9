package it.diprix.smartwm.smartvm9.controller;

import it.diprix.smartwm.smartvm9.service.DBHelper;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name, email, password, cpsw, phone;

        name = request.getParameter("name");
        email = request.getParameter("email");
        phone = request.getParameter("phone");
        password = request.getParameter("password");
        cpsw = request.getParameter("cpsw");

        RequestDispatcher dispatcher;

        System.out.println(name);

        dispatcher = request.getRequestDispatcher("WEB-INF/views/auth/login.jsp");

        if(name != "" && email != "" && password != "" && cpsw != "" && password.equals(cpsw) && phone != ""){

            try {


                int checkResult = DBHelper.registerUser(name, phone, email, password);


                if (checkResult > 0){
                    request.setAttribute("status", "success");
                    request.setAttribute("msg", "Account creato con successo");

                } else {
                    request.setAttribute("status", "error");
                    request.setAttribute("msg", "Registrazione fallita");

                }



//                response.sendRedirect("index.jsp");


            } catch (Exception e) {
                request.setAttribute("msg", "Esiste gia un utente con questa email.");
                request.setAttribute("status", "error");
            }


        } else {
            request.setAttribute("error", "password");
            request.setAttribute("status", "error");

        }

        dispatcher.forward(request, response);

    }
}