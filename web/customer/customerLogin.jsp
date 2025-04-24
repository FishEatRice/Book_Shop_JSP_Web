<%-- 
    Document   : CustomerLogin
    Created on : Apr 11, 2025, 8:02:18 AM
    Author     : yq
--%>
<%@ include file="/header/main_header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
// 获取 staffId 的值（需强制转换为 String）
String customer_email = (String) session.getAttribute("customer_email");
 System.out.println("customer_email = " + customer_email);
 session.setAttribute("user_type", "customer");


if (customer_email != null) {
    // 先检查是否是管理员（假设 A1 是管理员标识）
    response.sendRedirect("/galaxy_bookshelf/customer/customerDashboard.jsp");
}

String CheckAcc = (String) session.getAttribute("account_status");
if (CheckAcc != null) {
    // 先检查是否是管理员（假设 A1 是管理员标识）
    response.sendRedirect("/galaxy_bookshelf/index.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>Member Login</title>
</head>
<body>
    <h2>Login</h2>
    <form action="/CustomerLoginFunction" method="POST">
        <label for="customer_id">Member Email:</label>
        <input type="text" id="customer_email" name="customer_email" required/><br><br>

        <label for="customer_password">Password:</label>
        <input type="password" id="customer_password" name="customer_password" required/><br><br>

        <button type="submit">Login</button>
    </form>
    <a href="#"> Forget Password</a> <br>
    <a href="/galaxy_bookshelf/customer/registerMember.jsp"> Register</a> <br>

</body>
</html>