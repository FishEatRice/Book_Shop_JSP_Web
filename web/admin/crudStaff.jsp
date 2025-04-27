<%-- 
    Document   : crudStaff
    Created on : Apr 12, 2025, 1:21:01 AM
    Author     : yq
--%>
<%@ include file="/header/main_header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form method="post" action="../crudStaff">
            <input type="hidden" name="action" value="create"> 
            <input type="hidden" name="firstName" value="New" />
            <input type="hidden" name="lastName" value="Staff" />
            <input type="submit" value="Create New Staff" />
        </form>
        <br>
        <a href="/galaxy_bookshelf/admin/controlStaff.jsp"> Control staff</a><br>
        <a href="/galaxy_bookshelf/admin/adminDashboard.jsp">back to admin Dashboard</a>

    </body>
</html>
