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
    // role
    String userRole = (String) session.getAttribute("userRole");

    // 
    session.invalidate();

    // what role jum where
    if ("admin".equals(userRole)) {
        response.sendRedirect(request.getContextPath() + "/staff/staffLogin.jsp");
    } else if ("staff".equals(userRole)) {
        response.sendRedirect(request.getContextPath() + "/staff/staffLogin.jsp");
    } else if ("customer".equals(userRole)) {
        response.sendRedirect(request.getContextPath() + "/customer/customerLogin.jsp");
    } else {
        // 
        response.sendRedirect(request.getContextPath() + "/web/index.jsp");
    }
%>


    </body>
</html>
