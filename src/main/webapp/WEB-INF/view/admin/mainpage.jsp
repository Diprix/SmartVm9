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
    <title>SmartVM</title>
    <style>
        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: #333;
        }

        li {
            float: left;
        }

        li a {
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        li a:hover {
            background-color: #111;
        }
    </style>
</head>
<body>

    <nav>
        <ul>
            <li><a class="active" href="#dashboard">Dashboard</a></li>
            <li><a href="#machine">Macchinette</a></li>
            <li><a href="#contact">Tecnici</a></li>
            <li><a href="#about">Utenti</a></li>
            <li><a href="#about">Prodotti</a></li>
        </ul>


    </nav>

    <div id="container">

    </div>

</body>

</html>
