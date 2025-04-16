<%-- 
    Document   : SessionLogout
    Created on : Apr 16, 2025, 9:46:11 AM
    Author     : yq
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% 
    session.invalidate(); // 销毁 Session
    response.sendRedirect("../staff/staffLogin.jsp"); 
        %>

    </body>
</html>
