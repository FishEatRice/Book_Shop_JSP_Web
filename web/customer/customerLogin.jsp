<%-- 
    Document   : CustomerLogin
    Created on : Apr 11, 2025, 8:02:18 AM
    Author     : yq
--%>
<%@ include file="/header/main_header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    String role = (String) session.getAttribute("userRole");

    if (role != null) {
        if ("customer".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        } else if ("staff".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        } else if ("admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
    }
%>



<!DOCTYPE html>
<html>
<head>
    <title>Member Login</title>
</head>
<body>
    <h2>Login</h2>
    <form action="../CustomerLoginFunction" method="POST">
        <label for="customer_id">Member Email:</label>
        <input type="text" id="customer_email" name="customer_email" required/><br><br>

        <label for="customer_password">Password:</label>
        <input type="password" id="customer_password" name="customer_password" required/><br><br>

        <button type="submit">Login</button>
    </form>
    <a href="/galaxy_bookshelf/customer/customerForgetPassword.jsp"> Forget Password</a> <br>
    <a href="/galaxy_bookshelf/customer/registerMember.jsp"> Register</a> <br>

</body>
</html>