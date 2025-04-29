<%-- 
    Document   : failStaff
    Created on : Apr 14, 2025, 10:40:13 PM
    Author     : yq
--%>
<%@ include file="/header/main_header.jsp" %>
<%@ page import="model.staff.Staff" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       
<%
    Staff failedStaff = (Staff) request.getAttribute("failedStaff");
    if (failedStaff != null) {
%>
        <h2>Register Error：</h2>
        <p>Staff ID: <%= failedStaff.getStaffId() %></p>
        <p>First Name: <%= failedStaff.getFirstName() %></p>
        <p>Last Name: <%= failedStaff.getLastName() %></p>
        <p>Password: <%= failedStaff.getStaffPassword() %></p>
<%
    } else {
%>
        <p>no staff data include.</p>
<%
    }
%>

    </body>
</html>
