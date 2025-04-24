<%@ page import="controller.customer.CustomerLoginFunction" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/header/main_header.jsp" %>
<%
String accountStatus = (String) session.getAttribute("account_status");
String role = (String) session.getAttribute("userRole");
String customerId = (String) session.getAttribute("customer_id");

// 检查是否其他身份已登录
if (accountStatus != null && !"customer".equals(role)) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
}

// 检查是否 customer 已登录
if (customerId == null || !"customer".equals(role)) {
    response.sendRedirect(request.getContextPath() + "/customer/customerLogin.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Dashboard</title>
    </head>
    <body>
        <p>Welcome, customer ID: <%= customerId %></p>
        <h1>Hello World!</h1>
        <a href="/galaxy_bookshelf/header/SessionLogout.jsp">Logout</a> <br>
        <a href="/galaxy_bookshelf/customer/customerProfileDetails.jsp">MyProfile</a> <br>
    </body>
</html>
