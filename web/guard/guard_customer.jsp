<%-- 
    Document   : guard_customer
    Created on : 12 Apr 2025, 11:21:05 PM
    Author     : ON YUEN SHERN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String AccountType = (String) session.getAttribute("CheckAcc");
    
    if (!"customer".equals(AccountType)) {
%>

<script>
    alert("Low in permission. You do not have access to this page.");
    
    // Back To Index
    window.location.href = "/galaxy_bookshelf/index.jsp";
</script>

<%        
    }
%>