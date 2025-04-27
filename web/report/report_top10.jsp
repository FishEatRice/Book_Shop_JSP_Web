<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Set Title Icon -->
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <title>Galaxy | Product Sales Report</title>
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

                window.history.back();

        <h1>Top 10 Products of the Year</h1>

        <table border=""1>
            <thead>
                <tr>
                    <th>No</th>
                    <th>Product Name</th>
                    <th>Quantity Sold</th>
                    <th>Total Sales</th>
                </tr>
            </thead>
            <tbody>
                <% int i = 1; %>

                <c:forEach var="entry" items="${ReportData}">
                    <tr>
                        <td><%= i++ %></td>
                        <td>${entry.value.productName}</td>
                        <td>${entry.value.quantity}</td>
                        <td>RM <fmt:formatNumber value="${entry.value.sale}" type="number" minFractionDigits="2" /></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
