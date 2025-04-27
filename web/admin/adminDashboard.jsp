<%
String staffId = (String) session.getAttribute("account_status");
String role = (String) session.getAttribute("userRole");

if (staffId == null || !"admin".equals(role)) {
    response.sendRedirect(request.getContextPath() + "/staff/staffLogin.jsp");
}
session.setAttribute("userRole", "admin");
%>

<%@ include file="/header/main_header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <a href="/galaxy_bookshelf/header/SessionLogout.jsp">Logout</a>

        <h3>admin</h3>
        <h3>Welcome</h3>
       <a href="/galaxy_bookshelf/admin/crudStaff.jsp"> Staff Management</a>
       <a href="/galaxy_bookshelf/staff/customerManagementList.jsp"> Customer Management</a>
    </body>
</html>
