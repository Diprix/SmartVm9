<%--
  Created by IntelliJ IDEA.
  User: diprix
  Date: 29/05/22
  Time: 18:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- ===== Iconscout CSS ===== -->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <link rel="icon" href="${pageContext.request.contextPath}/assets/icons/favicon.ico">

    <!-- ===== CSS ===== -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/auth/login.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.9/dist/sweetalert2.all.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>

    <title>SmartVM</title>
</head>
<body>

<input type="hidden" id="status" value="<%= request.getAttribute("status")%>">
<input type="hidden" id="msg" value="<%= request.getAttribute("msg")%>">

<div class="container">
    <div class="forms">

        <div class="form login">

            <span class="title">Login</span>

            <%--            <form action="${pageContext.request.contextPath}/login" method="post">--%>

            <div class="input-field">
                <input value="luigi.verdi@smartvm.it" id="email" type="email" placeholder="Enter your email" name="email" required>
                <i class="uil uil-envelope icon"></i>
            </div>
            <div class="input-field">
                <input value="password" type="password" id="psw" class="password" placeholder="Enter your password" name="password" required>
                <i class="uil uil-lock icon"></i>
                <i class="uil uil-eye-slash showHidePw"></i>
            </div>

            <div class="checkbox-text">
                <div class="checkbox-content">
                    <input type="checkbox" id="logCheck" name="remember">
                    <label for="logCheck" class="text">Remember me</label>
                </div>

                <a href="#" class="text">Forgot password?</a>
            </div>

            <%--                <div class="input-field button">--%>
            <%--                    <input type="submit" value="Login Now">--%>
            <%--    <button type="button" class="btn btn-primary" onclick="accedi()">Login Now </button>--%>
            <%--                </div>--%>

            <div class="input-field button">
                <input type="button" value="Login Now" onclick="accedi()">
            </div>
            <%--            </form>--%>

            <div class="login-signup">
                    <span class="text">Not a member?
                        <a href="#" class="text signup-link">Signup now</a>
                    </span>
            </div>
        </div>

        <!-- Registration Form -->
        <div class="form signup">
            <span class="title">Registration</span>



            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="input-field">
                    <input type="text" placeholder="Enter your name" name="name" required>
                    <i class="uil uil-user"></i>
                </div>

                <div class="input-field">
                    <input type="number" placeholder="Enter your phone number" name="phone" required>
                    <i class="uil uil-phone"></i>
                </div>

                <div class="input-field">
                    <input type="email" placeholder="Enter your email"  name="email" required>
                    <i class="uil uil-envelope icon"></i>
                </div>

                <div class="input-field">
                    <input type="password" class="password" placeholder="Create a password" name="password" required>
                    <i class="uil uil-lock icon"></i>
                </div>

                <div class="input-field">
                    <input type="password" class="password" placeholder="Confirm a password" name="cpsw" required>
                    <i class="uil uil-lock icon"></i>
                    <i class="uil uil-eye-slash showHidePw"></i>
                </div>

                <div class="checkbox-text">
                    <div class="checkbox-content">
                        <input type="checkbox" id="sigCheck">
                        <label for="sigCheck" class="text">Remember me</label>
                    </div>

                    <a href="#" class="text">Forgot password?</a>
                </div>

                <div class="input-field button">
                    <input type="submit" value="Register Now">
                </div>
            </form>

            <div class="login-signup">
                    <span class="text">Not a member?
                        <a href="#" class="text login-link">Signup now</a>
                    </span>
            </div>
        </div>
    </div>
</div>

<%--<script src="login.js"></script>--%>
<script src="${pageContext.request.contextPath}/auth/login.js"></script>

<%--<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>--%>
<link rel="stylesheet" href="alert/dist/sweetalert.css">
<script type="text/javascript">
    var status = document.getElementById("status").value;
    if(status == "success"){
        swal("Congratulazioni", document.getElementById("msg").value, status);
    } else if(status == "error"){
        swal("Attenzione", document.getElementById("msg").value, status);
    }


    function accedi(){
        $.ajax({
            type: "post",
            url: "login",
            contentType: "application/x-www-form-urlencoded",
            data: {
                email: $("#email").val(),
                password: $("#psw").val()
            }, beforeSend() {
                console.log("Waiiit waiit");
            },failure: function (xhr) {
                console.log(xhr.status);
            }, success: function (response) {
                console.log(response.status);
                $(location).attr('href','');
            }

        })
    }

</script>


</body>
</html>


<%--  action="${pageContext.request.contextPath}/login"  --%>