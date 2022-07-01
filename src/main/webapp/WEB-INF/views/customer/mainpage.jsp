<%@ page import="it.diprix.smartwm.smartvm9.model.User" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<link rel="stylesheet" href="${pageContext.request.contextPath}/WEB-INF/views/customer/home.css">

<section id="includedContent"></section>

<nav class="nav">

    <a href="#ricarica" class="nav__link" id="1">
        <i class="material-icons nav__icon">euro</i>
        <span class="nav__text">Ricarica</span>
    </a>

    <a href="#home" class="nav__link nav__link--active" id="2">
        <img class="home-image" src="${pageContext.request.contextPath}/WEB-INF/assets/images/coffee-cup.png" alt="home">
    </a>

    <a href="#altro" class="nav__link" id="3">
        <i class="material-icons nav__icon">more_horiz</i>
        <span class="nav__text">Altro</span>
    </a>

</nav>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script>
    $("#includedContent").load("${pageContext.request.contextPath}/WEB-INF/views/customer/home.jsp");
    $(document).ready(function(){
        $("a").click(function(){
            $("a").removeClass("nav__link--active");
            $(this).addClass("nav__link--active");

            console.log($(this).index());

            switch ($(this).index()){
                case 0:
                    $("#includedContent").load("${pageContext.request.contextPath}/WEB-INF/views/customer/pagamenti.jsp");

                    break;
                case 1:
                    $("#includedContent").load("${pageContext.request.contextPath}/WEB-INF/views/customer/home.jsp");

                    break;
                case 2:
                    $("#includedContent").load("${pageContext.request.contextPath}/WEB-INF/views/customer/altro.jsp");

                    break;

                default:
                    $("#includedContent").load("${pageContext.request.contextPath}/WEB-INF/views/customer/home.jsp");
            }

        })
    })

</script>
