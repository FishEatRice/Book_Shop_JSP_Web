<%-- 
    Document   : checkSession
    Created on : Apr 27, 2025, 12:38:40 AM
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
    String accountStatus = (String) session.getAttribute("account_status");

    if (accountStatus != null) {
        switch (accountStatus) {
            case "customer":
                response.sendRedirect(request.getContextPath() + "/galaxy_bookshelf/customer/customerDashboard.jsp");
                return;
            case "staff":
                response.sendRedirect(request.getContextPath() + "/staff/staffDashboard.jsp");
                return;
            case "A1":
                response.sendRedirect(request.getContextPath() + "/admin/adminDashboard.jsp");
                return;
        }
    }

    // 如果没有登录，跳转登录页面（或主页）
    response.sendRedirect(request.getContextPath() + "/index.jsp");
%>

    </body>
</html>
