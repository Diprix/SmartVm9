<%@ page import="it.diprix.smartwm.smartvm9.model.Transaction" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: diprix
  Date: 25/06/22
  Time: 01:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>


<link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/transaction.css">

<div class="transactionBody">
    <h1>Transazioni</h1>
<p style="font-size: 10px">(Ultime 4 transazioni)</p>
<div class="sizedbox"></div>

<%
    List<Transaction> result = (List<Transaction>) request.getAttribute("transactionList");
%>

<%
    int transactionCount = result.size();
%>

<div class="scrollable">
    <div class="transactionContainer">

        <%
            for (int i = 0; i < transactionCount; i++) {
                out.print(
                        "<div class=\"transactionCard row white\"> " +
                                "<section class=\"sx\"> " +
                                "<h4>");

                if(result.get(i).getIdMachine() != 0){
                    out.print(result.get(i).getIdMachine());
                } else {
                    out.print("Ricarica borsellino");
                }
                out.println(" </h4> " +
                                "<p>" + result.get(i).getDate() + "  - ");
                if(result.get(i).getAmount() < 0){
                    out.print("Acquisto");
                } else {
                    out.print("Ricarica");
                }
                out.print("</p> " +
                                "</section> " +

                                "<section class=\"dx\"> " +

                                "<h4 class=");

                //Assegno colore al valore della transazione
                if(result.get(i).getAmount() < 0){
                    out.print("red");
                } else {
                    out.print("green");
                }

                out.print(">");

                out.print(parseCredit(result.get(i).getAmount()));


                out.print(" €</h4> " +
                                "</section> " +

                        "</div>" +

                "<div class=\"sizedbox\"></div>");
            }

        %>

        <%!

            //Metodo che mi formatta il credito
            public String parseCredit(double amount) {
                String amountString = ""+amount;
                amountString = amountString.replace(".", ",");
                amountString = amountString + "0";
                return amountString;
            }
        %>


    </div>

</div>

</div>