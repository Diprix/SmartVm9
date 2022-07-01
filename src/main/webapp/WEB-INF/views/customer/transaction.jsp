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


<link rel="stylesheet" href="${pageContext.request.contextPath}/WEB-INF/views/customer/transaction.css">

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
    <div class="container">

        <%
            for (int i = 0; i < transactionCount; i++) {
                out.print(
                        "<div class=\"card row white\"> " +
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
            public String parseCredit(double amount) {
                String amountString = ""+amount;
                amountString = amountString.replace(".", ",");
                amountString = amountString + "0";
                return amountString;
            }
        %>


        <%--<div class="card row white">
            <section class="sx">
                <h4>1234</h4>
                <p>15/05/25 - Acquisto</p>
            </section>
            <section class="dx">
                <h4>0,5 €</h4>
            </section>
        </div>
--%>

    </div>

</div>