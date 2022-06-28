<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="${pageContext.request.contextPath}/assets/icons/favicon.ico">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/customer/navbar.css">

    <link rel="icon" href="${pageContext.request.contextPath}/assets/icons/favicon.ico">


    <title>SmartVM</title>
</head>
<body id="main">



</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script>


    idUser = <%= (Integer) session.getAttribute("idUser")%>;
    if(idUser == null)
        $("#main").load("auth/login.jsp");
    else
        routing();


    function routing(){
        var user_type = "<%= (String) session.getAttribute("user_type")%>";

        switch (user_type){
            case "CUSTOMER":
                $("#main").load("${pageContext.request.contextPath}/customer/mainpage.jsp");
                break;
            case "TECHNICAL":
                $("#main").load("${pageContext.request.contextPath}/technical/mainpage.jsp");
                break;
            case "ADMIN":
                $("#main").load("${pageContext.request.contextPath}/admin/mainpage.jsp");
                break;

        }
    }

</script>

</html>