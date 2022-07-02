package it.diprix.smartwm.smartvm9.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "GetPageServlet", value = "/GetPageServlet")
public class GetPageServlet extends HttpServlet {

    RequestDispatcher dispatcher;


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = Integer.parseInt(request.getParameter("page"));

        String route = "WEB-INF/view/customer/home.jsp";

        switch (page){
            case 1:
                route = "WEB-INF/view/customer/home.jsp";
                break;

            case 0:
                route = "WEB-INF/view/customer/payment.jsp";

                break;

            case 2:
                route = "WEB-INF/view/customer/other.jsp";

                break;

//            default:
//                route =" WEB-INF/view/customer/home.jsp";
//                break;

        }

        dispatcher = request.getRequestDispatcher(route);
        dispatcher.forward(request, response);

    }
}
