<%--
  Created by IntelliJ IDEA.
  User: diprix
  Date: 28/05/22
  Time: 22:46
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Pagamenti</title>
    <style>

        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body{
            margin: 20px;
        }

        .container {
            display: block;
            padding: 15px 20px 20px 20px;
        }


        .card{
            background: white;
            border-radius: 20px;
            padding-top: 20px;
        }


        .button{
            margin-top: 35px;
        }

        .button input:hover{
            background-color: rgb(255, 148, 47);
        }

        .button input{
            border: none;
            color: #fff;
            font-size: 17px;
            font-weight: 500;
            letter-spacing: 1px;
            border-radius: 6px;
            background-color: rgb(255, 148, 47);

        }

        .input-field{
            position: relative;
            height: 50px;
            width: 100%;
            margin-top: 30px;
        }

        .input-field input{
            position: absolute;
            height: 100%;
            width: 100%;
            padding: 0 35px;
            border: none;
            outline: none;
            font-size: 16px;
            border-bottom: 2px solid #e7a100;
            border-top: 2px solid transparent;
        }



    </style>
</head>
<body>

<div class="card">
    <h1>Altro</h1>



    <div class="container">
<%--        <a class="input-field button" href="${pageContext.request.contextPath}/logout">Logout</a>--%>

        <div class="input-field button">
            <input type="button" value="Logout" onclick="logout()">
        </div>

        <div class="input-field button">
            <input id="execute" type="button" value="Ultime transazioni">
        </div>

    </div>
</div>



</body>
<script>

    function logout(){

        const xhttp = new XMLHttpRequest();
        xhttp.onload = function() {


           // $("#includedContent").load("${pageContext.request.contextPath}/customer/transaction.jsp");

            $("#main").load("auth/login.jsp");

        }
        xhttp.open("GET", "${pageContext.request.contextPath}/logout", false);
        xhttp.send();
    }

    $(document).ready(function() {
        $("#execute").click(function() {
                $.post("${pageContext.request.contextPath}/TransactionServlet",
                    function(data, status) {
                    if (status == "success")
                        $("#includedContent").html(data);
                });

        });
    });
</script>
</html>







