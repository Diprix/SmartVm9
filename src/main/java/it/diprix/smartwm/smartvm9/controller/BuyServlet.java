package it.diprix.smartwm.smartvm9.controller;

import com.google.gson.Gson;
import it.diprix.smartwm.smartvm9.model.MachineProduct;
import it.diprix.smartwm.smartvm9.service.DBHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.ResultSet;
import java.text.DecimalFormat;

@WebServlet(name = "BuyServlet", value = "/buy")
public class BuyServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.println("TEST BUY SERVLET");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        String idMachine =  request.getParameter("idMachine"); // ID macchinetta utilizzata
        String selection =  request.getParameter("selection"); // Codice inserito dall'utente

        int userID;
        double machineCredit;


        try {

            // Recupero le informazione della macchinetta dal DB
            ResultSet machineQueryRs = DBHelper.getMachineById(Integer.parseInt(idMachine));

            if(machineQueryRs.next()){
                // Recupero lo stato che conterra' l'id dell'utente che sta acquistando
                userID = machineQueryRs.getInt("status");

                // Recupero il credito della macchinetta
                // dopo la connessione il credito della macchinetta e' uguale al credito dell'utente
                machineCredit = machineQueryRs.getDouble("credit");

                // Aggiorno la quantita' del prodotto selezionato, (quantity - 1)
                // le operazione vengono fatte diretttamente nella query
                int rsStock = DBHelper.updateStockQuantity(Integer.parseInt(idMachine), selection);
                if(rsStock > 0) {

                // Recupero il prezzo del prodotto
                ResultSet productQueryRs = DBHelper.getProduct(Integer.parseInt(idMachine), selection);

                if(productQueryRs.next()){
                        //Update success

                        // Aggiorno il credito della macchinetta sottraendone il prezzo del prodotto
                        int rsMachine = DBHelper.updateMachineCredit(Integer.parseInt(idMachine), productQueryRs.getDouble("price"), creditParse(machineCredit, productQueryRs.getDouble("price")));

                        if(rsMachine > 0) {
                            //Update success

                            // Registro l'acquisto effettuato dall'utente
                            int fine = DBHelper.insertTransaction(productQueryRs.getInt("idstock"),  new Date(System.currentTimeMillis()), userID, Integer.parseInt(idMachine), (productQueryRs.getDouble("price")*-1));

                            if(fine >0){
                                // Insert success
                                System.out.println("Acquisto completato");

                                //Ritorno il prodotto acquistato per l'animazione finale
                                MachineProduct product = new MachineProduct();
                                product.setProductID(productQueryRs.getInt("idproduct"));
                                product.setSelection(productQueryRs.getString("selection"));

                                String productJSONString = new Gson().toJson(product);

                                request.setAttribute("product", productJSONString);
                                out.println(productJSONString);

                            }


                        } else {
                            //Update FAILED (credit error)
                            //Credito non sufficente per completare l'acquisto

                            System.out.println("CREDIT ERROR");
                        }

                    } else {
                        //Update FAILED (qty error)
                        System.out.println("QTY ERROR");
                    }
                }
                // --------------



            }


        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    double creditParse(double machineCredit, double price) {
        double newCredit = machineCredit - price;

        String s = new DecimalFormat("#.##").format(newCredit);

        newCredit = Double.parseDouble(s.replace(",", "."));

        return newCredit;
    }

}
