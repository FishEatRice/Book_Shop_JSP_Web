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
    // 获取用户角色
    String userRole = (String) session.getAttribute("userRole");

    // 清除 Session 中所有资料
    session.invalidate();

    // 根据用户角色跳转到对应的 Login 页面
    if ("admin".equals(userRole)) {
        response.sendRedirect(request.getContextPath() + "/staff/staffLogin.jsp");
    } else if ("staff".equals(userRole)) {
        response.sendRedirect(request.getContextPath() + "/staff/staffLogin.jsp");
    } else if ("customer".equals(userRole)) {
        response.sendRedirect(request.getContextPath() + "/customer/customerLogin.jsp");
    } else {
        // 如果什么都不是，就跳去首页或默认登录页
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
%>


    </body>
</html>
