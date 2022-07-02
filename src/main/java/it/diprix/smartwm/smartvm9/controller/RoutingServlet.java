package it.diprix.smartwm.smartvm9.controller;

import it.diprix.smartwm.smartvm9.model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "RoutingServlet", value = "/RoutingServlet")
public class RoutingServlet extends HttpServlet {

    RequestDispatcher dispatcher;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String isMobile = request.getParameter("isMobile");

        HttpSession currentSession = request.getSession();
        User user = (User) currentSession.getAttribute("user");

        if (user == null) {
            dispatcher = request.getRequestDispatcher("/WEB-INF/view/auth/login.jsp");
        } else {
            String user_type = user.getUser_type();

            if(isMobile.equals("true")){

                dispatcher = request.getRequestDispatcher("customer/mainpage.html");

            } else {
                switch (user_type){
                    case "CUSTOMER":
                        dispatcher = request.getRequestDispatcher("customer/mainpage.html");
                        break;
                    case "TECHNICAL":
                        dispatcher = request.getRequestDispatcher("technical/mainpage.jsp");
                        break;
                    case "ADMIN":
                        dispatcher = request.getRequestDispatcher("admin/mainpage.jsp");
                        break;

                }
            }
        }



        dispatcher.forward(request, response);
    }

}
