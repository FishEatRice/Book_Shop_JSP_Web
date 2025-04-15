<%-- 
    Document   : failStaff
    Created on : Apr 14, 2025, 10:40:13 PM
    Author     : yq
--%>
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
        <h2>注册失败！以下是您尝试提交的资料：</h2>
        <p>Staff ID: <%= failedStaff.getStaffId() %></p>
        <p>First Name: <%= failedStaff.getFirstName() %></p>
        <p>Last Name: <%= failedStaff.getLastName() %></p>
        <p>Password: <%= failedStaff.getStaffPassword() %></p>
<%
    } else {
%>
        <p>没有接收到 Staff 资料。</p>
<%
    }
%>

    </body>
</html>
