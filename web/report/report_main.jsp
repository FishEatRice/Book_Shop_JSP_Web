<%-- 
    Document   : report_main
    Created on : 27 Apr 2025, 3:05:00 PM
    Author     : ON YUEN SHERN
--%>

<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Galaxy | Payment History</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
    </head>
    <body>
        <h2>Product Sales Report</h2>

        <table>
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Quantity Sold</th>
                    <th>Total Sales</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="entry" items="${ReportData}">
                <tr>
                    <td>${entry.value.productName}</td>
                    <td>${entry.value.quantity}</td>
                    <td>${entry.value.sale}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>