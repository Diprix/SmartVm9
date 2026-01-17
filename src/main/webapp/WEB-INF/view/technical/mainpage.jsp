<%--
  Created by IntelliJ IDEA.
  User: diprix
  Date: 24/06/22
  Time: 21:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SmartVM</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/technical.css">


</head>
<body id="tecnical_mainpage" class="tecnical_mainpage">


    <!-- Scharmata form connessione -->
    <section id="connectionForm">

        <div class="container">
            <p>Connetti macchinetta</p>
            <input id="idMachine" type="text" placeholder="Id macchinetta">
            <button id="execute" onclick="connectMachine($('#idMachine').val())">Connetti</button>

            <button id="logout" onclick="logout()">Esci</button>

        </div>

    </section>

    <!-- Scharmata tabella prodotti -->
    <section id="connectionTable" class="hide">


    </section>


</body>
</html>
