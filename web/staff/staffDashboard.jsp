<%-- 
    Document   : staffDashboard
    Created on : Apr 12, 2025, 12:46:58 AM
    Author     : yq
--%>

<%
    String staffId = (String) session.getAttribute("staffId");
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        
        <title>JSP Page</title>
    </head>
    <body>
        <p>Welcome, Staff ID: <%= staffId %></p>
        <h3>Welcome</h3>
        <a href="../header/SessionLogout.jsp">Logout</a> <br>
        <a href="../staff/customerManagementList.jsp"> Customer Management</a><br>
        <a href="../staff/accountDetails.jsp">Account Details</a><br>
    </body>
</html>
