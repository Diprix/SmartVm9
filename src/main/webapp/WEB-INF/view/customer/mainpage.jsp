<!--
<%@ page import="it.diprix.smartwm.smartvm9.model.User" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
-->


<link rel="stylesheet" href="${pageContext.request.contextPath}/customer/home.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/customer/navbar.css">
<section id="includedContent"></section>

<nav class="nav">

    <a href="#ricarica" class="nav__link" id="1">
        <i class="material-icons nav__icon">euro</i>
        <span class="nav__text">Ricarica</span>
    </a>

    <a href="#home" class="nav__link nav__link--active" id="2">
        <img class="home-image" src="assets/images/coffee-cup.png" alt="home">
    </a>

    <a href="#altro" class="nav__link" id="3">
        <i class="material-icons nav__icon">more_horiz</i>
        <span class="nav__text">Altro</span>
    </a>

</nav>

