package it.diprix.smartwm.smartvm9.controller;

import it.diprix.smartwm.smartvm9.service.DBHelper;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;


import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.print("Working");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name, email, password, cpsw, phone;

        name = request.getParameter("name");
        email = request.getParameter("email");
        phone = request.getParameter("phone");
        password = request.getParameter("password");
        cpsw = request.getParameter("cpsw");

        RequestDispatcher dispatcher;


        if(name != null && email != null && password != null && cpsw != null && password.equals(cpsw) && phone != null){

            try {


                int checkResult = DBHelper.registerUser(name, phone, email, password);

                dispatcher = request.getRequestDispatcher("auth/login.jsp");

                if (checkResult > 0){
                    request.setAttribute("status", "success");
                    request.setAttribute("msg", "Account creato con successo");

                } else {
                    request.setAttribute("status", "error");
                    request.setAttribute("msg", "Registrazione fallita");

                }

                dispatcher.forward(request, response);


            } catch (Exception e) {
                request.setAttribute("msg", "Esiste gia un utente con questa email.");
                request.setAttribute("status", "error");
            }


        } else {
            request.setAttribute("error", "password");
            request.setAttribute("status", "error");

        }



    }
}