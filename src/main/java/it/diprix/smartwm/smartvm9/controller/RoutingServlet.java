package it.diprix.smartwm.smartvm9.controller;

import it.diprix.smartwm.smartvm9.model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "RoutingServlet", value = "/RoutingServlet")
public class RoutingServlet extends HttpServlet {

    RequestDispatcher dispatcher;

    /*
    Servlet che mi gestisce il routing dell'index
    Questa classe inoltrera l'utente:
     - al login se non ha effettuato l'accesso
     - Alla Mainpage di riferimento in base alla tipologia di utente

     - inoltre mandera tutti i tipi di utenti nella mainpage di CUSTOMER se accederanno da mobile per consentire loro di fare acquisti.
     */

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String isMobile = request.getParameter("isMobile");

        HttpSession currentSession = request.getSession();
        User user = (User) currentSession.getAttribute("user");

        response.setContentType("text/html");


        if (user == null) {
            dispatcher = request.getRequestDispatcher("/WEB-INF/view/auth/login.jsp");
        } else {
            String user_type = user.getUser_type();

            if(isMobile.equals("true")){

                dispatcher = request.getRequestDispatcher("/WEB-INF/view/customer/mainpage.jsp");

            } else {
                switch (user_type){
                    case "CUSTOMER":
                        dispatcher = request.getRequestDispatcher("/WEB-INF/view/customer/mainpage.jsp");
                        break;
                    case "TECHNICAL":
                        dispatcher = request.getRequestDispatcher("/WEB-INF/view/technical/mainpage.jsp");
                        break;
                    case "ADMIN":
                        dispatcher = request.getRequestDispatcher("/WEB-INF/view/admin/mainpage.jsp");
                        break;

                }
            }
        }



        dispatcher.forward(request, response);
    }

}
