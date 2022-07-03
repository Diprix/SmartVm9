<%--
  Created by IntelliJ IDEA.
  User: diprix
  Date: 27/06/22
  Time: 15:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container">
    <p>Connetti macchinetta</p>
    <input id="idMachine" type="text" placeholder="Id macchinetta">
    <button id="execute">Connetti</button>

    <button id="logout" onclick="logout()">Esci</button>

</div>
<script>

    $(document).ready(function () {
        $("#execute").click(function () {
            const idMachine = $("#idMachine").val();
            if (idMachine != "") {
                $.get("${pageContext.request.contextPath}/TecnicalConnectionServlet?idMachine=" + idMachine,
                    function (data, status) {
                        if (status == "success")
                            if (data == 'Macchinetta Occupata') {
                                alert(data)
                            } else {
                                $("#machineproduct").html(data);

                            }
                    });
            }
        });
    });

    function logout() {

        const xhttp = new XMLHttpRequest();
        xhttp.onload = function () {


            // $("#includedContent").load("${pageContext.request.contextPath}/customer/transaction.jsp");

            // $("#main").load("auth/login.jsp");


        }
        xhttp.open("GET", "${pageContext.request.contextPath}/logout", false);
        xhttp.send();
    }

</script>