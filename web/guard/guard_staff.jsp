<%-- 
    Document   : guard_staff
    Created on : 12 Apr 2025, 11:20:48 PM
    Author     : ON YUEN SHERN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String AccountType = (String) session.getAttribute("CheckAcc");
    
    if (!"staff".equals(AccountType)) {
%>

<script>
    alert("Low in permission. You do not have access to this page.");
        
    // Back To Index
    window.location.href = "/galaxy_bookshelf/web/index.jsp";
</script>

<%        
    }
%>