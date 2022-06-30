<%@ page import="it.diprix.smartwm.smartvm9.model.MachineProduct" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: diprix
  Date: 26/06/22
  Time: 16:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="tablebox">
<h3>Macchinetta connessa: ${idMachine}</h3>

<h4>Product List:</h4>
<%
  List<MachineProduct> result = (List<MachineProduct>) request.getAttribute("tecnicalProductList");
%>
<table border="1">
  <%
    int columnCount = result.size();
  %>
  <tr>
    <th>ID</th>
    <th>Posizione</th>
    <th>DESCRIZIONE</th>
    <th>QTY</th>
    <th></th>
  </tr>
  <%
    for (int i = 0; i < columnCount; i++) {
      out.print("<tr>");
      out.print("<td>" + result.get(i).getProductID() + "</td>");
      out.print("<td>" + result.get(i).getSelection() + "</td>");
      out.print("<td>" + result.get(i).getDescription() + "</td>");
      out.print("<td id=\"" + result.get(i).getProductID() + "\">" + result.get(i).getQty() + "</td>"); // contenteditable='true'
      out.print("<td>" +
              "<button id=\"refill\" onclick=\"refill("+ request.getParameter("idMachine") +", 10, "+ result.get(i).getProductID() +", '"+ result.get(i).getSelection() +"')\">REFILL</button>"
              + "</td>");
      out.print("</tr>");

    }
  %>



</table>

<button id="exit" onclick="closeConnection(${idMachine})">FINE</button>

</div>


<script>
  function refill(idMachine, qty, idProduct, selection){
    console.log(idMachine);
    console.log(qty);
    console.log(idProduct);

    $.post(
            "${pageContext.request.contextPath}/RefillServlet",
            {
              idMachine: idMachine,
              qty: qty,
              selection: selection
            },
            function(data, status){
              if(status == "success"){
                console.log("REFILL ESEGUITO")
                //alert("Hai caricato " + credit + "€ nel tuo conto")

                document.getElementById(idProduct).innerText = "10";

                // console.log(data)
              }
            }
    )
  }

  function closeConnection(idMachine){
   /* $.get(
            "${pageContext.request.contextPath}/RefillServlet?idMachine=" + idMachine,
            function(data, status){
              if(status == "success"){
                console.log("CHIUSURA MACCHINETTA")
                //alert("Hai caricato " + credit + "€ nel tuo conto")

                document.getElementById(idProduct).innerHTML =
                        "<p>Connetti macchinetta</p>" +
                        "<input id=\"idMachine\" type=\"text\" placeholder=\"ID MACCHINETTA\">"+
                        "<button id=\"execute\">Connetti</button>";

                // console.log(data)
              }
            }
    )
*/
    const xhttp = new XMLHttpRequest();
    xhttp.onload = function() {


      $("#machineproduct").load("${pageContext.request.contextPath}/technical/connectionForm.jsp");


    }
    xhttp.open("GET", "${pageContext.request.contextPath}/RefillServlet?idMachine=" + idMachine, true);
    xhttp.send();

  }
</script>