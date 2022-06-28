<%--
  Created by IntelliJ IDEA.
  User: diprix
  Date: 30/05/22
  Time: 17:13
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/customer/connected.css">

    <div class="container" >

        <p id="etichetta">Distributore ${idMachine}</p>
        <div class="sizedbox_cento"></div>
        <div class="card blue">
            <p>Collegamento stabilito</p>
        </div>
        <div class="sizedbox"></div>

        <div class="card white row">
            <img class="image" src="${pageContext.request.contextPath}/assets/images/keypad.png">

            <p>Usa il tastierino del distributore per acquistare</p>
        </div>

        <div class="spacer"></div>


        <div class="input-field button">
            <input type="button" value="Disconnetti" onclick="disconnect()">
        </div>

    </div>

