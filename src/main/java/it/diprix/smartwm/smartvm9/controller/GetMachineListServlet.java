package it.diprix.smartwm.smartvm9.controller;

import it.diprix.smartwm.smartvm9.model.Machine;
import it.diprix.smartwm.smartvm9.service.DBHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "GetMachineListServlet", value = "/GetMachineListServlet")
public class GetMachineListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Machine> machineList = new ArrayList<>();
        try {

            ResultSet rs = DBHelper.getMachineList();

            while (rs.next()){

                Machine machine = new Machine(
                        rs.getInt("idmachine"),
                        rs.getString("type"),
                        rs.getString("status"),
                        rs.getString("position")
                );
                machineList.add(machine);
            }

            request.setAttribute("machineList", machineList);
            request.getRequestDispatcher("admin/macchinette.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
