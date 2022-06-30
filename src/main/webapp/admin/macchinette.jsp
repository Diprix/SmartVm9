<%@ page import="it.diprix.smartwm.smartvm9.model.Machine" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: diprix
  Date: 30/06/22
  Time: 20:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>--%>
<%
    List<Machine> machineList = (List<Machine>) request.getAttribute("machineList");
%>
<%
    int machineListCount = machineList.size();
%>
<ol>
<%--<c:forEach items="${machineList}" var="machine">--%>
<%--    <li>${machine.idmachine}</li>--%>
<%--</c:forEach>--%>

    <%
        for (int i = 0; i < machineListCount; i++) {
            out.print("<p>");
            out.print(machineList.get(i).getIdMachine());
            out.print("</p>");


        }

    %>
</ol>