<%--
  Created by IntelliJ IDEA.
  User: diprix
  Date: 29/05/22
  Time: 18:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/login.css">

<input type="hidden" id="status" value="<%= request.getAttribute("status") %>">
<input type="hidden" id="msg" value="<%= request.getAttribute("msg") %>">

<div class="container" id="containerLoginForm">
    <div class="forms">
        <!-- Login Form -->

        <div class="form login">

            <span class="title">Login</span>

            <form action="${pageContext.request.contextPath}/login" method="post" id="signinForm">

                <div class="input-field">
                    <input id="email" type="email" placeholder="Enter your email"
                           name="email" required>
                    <i class="uil uil-envelope icon"></i>
                </div>
                <div class="input-field">
                    <input type="password" id="psw" class="password" placeholder="Enter your password"
                           name="password" required>
                    <i class="uil uil-lock icon" onclick="shoPsw()"></i>
                    <i class="uil uil-eye-slash showHidePw" onclick="shoPsw()"></i>
                </div>

                <div class="checkbox-text">
                    <div class="checkbox-content">
                        <input type="checkbox" id="logCheck" name="remember">
                        <label for="logCheck" class="text">Remember me</label>
                    </div>

                    <a href="#" class="text">Forgot password?</a>
                </div>

                <div class="input-field button">
                    <input type="submit" value="Login Now">
                </div>


            </form>


            <div class="login-signup">
                    <span class="text">Not a member?
                        <a href="javascript:goToSignup()" class="text signup-link">Signup now</a>
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
                    <input type="email" placeholder="Enter your email" name="email" required>
                    <i class="uil uil-envelope icon"></i>
                </div>

                <div class="input-field">
                    <input type="password" class="password" placeholder="Create a password" name="password" required>
                    <i class="uil uil-lock icon" onclick="shoPsw()"></i>
                </div>

                <div class="input-field">
                    <input type="password" class="password" placeholder="Confirm a password" name="cpsw" required>
                    <i class="uil uil-lock icon" onclick="shoPsw()"></i>
                    <i class="uil uil-eye-slash showHidePw" onclick="shoPsw()"></i>
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
                        <a href="javascript:goToLogin()" class="text login-link">Signup now</a>
                    </span>
            </div>
        </div>
    </div>
</div>









