<%-- 
    Document   : customerLoginError
    Created on : Apr 11, 2025, 8:01:27 AM
    Author     : yq
--%>
<%@ include file="/header/main_header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login Error</title>
    </head>
    <body>
        <h2>Login Failed</h2>
        <p>Invalid staff ID or password. Please try again.</p>

        <a href="/galaxy_bookshelf/customer/customerLogin.jsp">Go back to customer login page</a>
        <a href="/galaxy_bookshelf/staff/staffLogin.jsp">Go back to staff login page</a> <br>
    </body>
</html>
