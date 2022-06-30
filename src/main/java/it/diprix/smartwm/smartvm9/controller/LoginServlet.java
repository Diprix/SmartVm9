package it.diprix.smartwm.smartvm9.controller;


import it.diprix.smartwm.smartvm9.model.User;
import it.diprix.smartwm.smartvm9.service.DBHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email  = request.getParameter("email");
        String password  = request.getParameter("password");

        HttpSession oldSession = request.getSession(false);
        if(oldSession != null){
            oldSession.invalidate(); //invalida vecchia sessione
        }

        try {


            ResultSet rs = DBHelper.loginUser(email, password);


            if (rs.next()){

                HttpSession currentSession = request.getSession(); //crea nuova sessione
                currentSession.setMaxInactiveInterval(15*60); //15 min di inattivita massima

                currentSession.setAttribute("userId", rs.getString("email"));
                currentSession.setAttribute("userType", rs.getString("user_type"));


                User user = (User) currentSession.getAttribute("user");
                if (user == null) {
                    user = new User();
                }


                user.setEmail(rs.getString("email"));
                user.setCredit(rs.getDouble("credit"));
                user.setIduser(rs.getInt("idUser"));
                user.setName(rs.getString("name"));
                user.setPhone(rs.getString("phone"));
                user.setUser_type(rs.getString("user_type"));

                currentSession.setAttribute("user", user);
                currentSession.setAttribute("credit", rs.getDouble("credit"));
                currentSession.setAttribute("idUser", rs.getInt("idUser"));
                currentSession.setAttribute("user_type", rs.getString("user_type"));

                request.setAttribute("status", "success");
                request.setAttribute("msg", "Login");
//                request.getRequestDispatcher("auth/login.jsp").forward(request, response);

            } else {
                request.setAttribute("status", "error");
                request.setAttribute("msg", "Email o Password errati");
//                request.getRequestDispatcher("auth/login.jsp").forward(request, response);

            }


            request.getRequestDispatcher("auth/login.jsp").forward(request, response);


        } catch (Exception e) {
            request.setAttribute("msg", "Generic login error");
            request.setAttribute("status", "error");
            e.printStackTrace();
        }

    }

}

