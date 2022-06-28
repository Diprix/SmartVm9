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
<input id="idMachine" type="text" placeholder="  ID MACCHINETTA">
<button id="execute">Connetti</button>

</div>
<script>

    $(document).ready(function() {
        $("#execute").click(function() {
            const idMachine = $("#idMachine").val();
            console.log(idMachine);

            $.get("${pageContext.request.contextPath}/TecnicalConnectionServlet?idMachine=" + idMachine,
                function(data, status) {
                    if (status == "success")
                        $("#machineproduct").html(data);
                });

        });
    });
</script>