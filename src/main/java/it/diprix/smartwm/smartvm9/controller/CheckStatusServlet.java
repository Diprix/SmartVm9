package it.diprix.smartwm.smartvm9.controller;

import com.google.gson.Gson;
import it.diprix.smartwm.smartvm9.model.Machine;
import it.diprix.smartwm.smartvm9.model.MachineProduct;
import it.diprix.smartwm.smartvm9.service.DBHelper;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;


import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


@WebServlet(name = "CheckStatusServlet", value = "/checkstatus")
public class CheckStatusServlet extends HttpServlet {




    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("idMachine", request.getParameter("idMachine"));


        // Recupero id macchinetta
        String idMachine  = request.getParameter("idMachine");

        List<MachineProduct> machineProductLsit = new ArrayList<>();
        Machine machine = new Machine();


        try {
            // Ricavo le informazioni della macchinetta
            ResultSet rs1 = DBHelper.getMachineById(Integer.parseInt(idMachine));

            if(rs1.next()){

                // Ricavo la lista dei prodotti della macchinetta selezionata
                ResultSet rs2 = DBHelper.getProductList(idMachine);



                // Creo l'oggetto Machine con le info della macchinetta e una lista di oggetti MachineProduct
                while (rs2.next()){
                    MachineProduct machineProduct = new MachineProduct();
                    machineProduct.setProductID(rs2.getInt("ID"));
                    machineProduct.setDescription(rs2.getString("PRODUCT"));
                    machineProduct.setPrice(rs2.getDouble("PRICE"));
                    machineProduct.setQty(rs2.getInt("QTY"));
                    machineProduct.setSelection(rs2.getString("SEL"));
                    machineProductLsit.add(machineProduct);

                }

                machine.setIdMachine(rs1.getInt("idMachine"));
                machine.setType(rs1.getString("type"));
                machine.setStatus(rs1.getString("status"));
                machine.setCredit(rs1.getDouble("credit"));
                machine.setProducts(machineProductLsit);



            }

            // Creo un json partendo dal mio oggetto
            String machineJSONString = new Gson().toJson(machine);

            // System.out.println(machineJSONString);


            response.setContentType("application/json");
            request.setAttribute("machine", machineJSONString);


            // Lo invio al client
            PrintWriter out = response.getWriter();
            out.println(machineJSONString);

        } catch (Exception e) {

            e.printStackTrace();
        }

    }




}
