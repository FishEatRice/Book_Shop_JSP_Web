<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <title>Galaxy | Sales Records</title>
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <button onclick="window.history.back();">Back to Report Main Page</button>

        <h2>Sales Records - <c:out value="${reportType}"/> View</h2>

        <!-- Table to display sales records -->
        <table border="1">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Product Name</th>
                    <th>Quantity Sold</th>
                    <th>Total Sales</th>
                    <th>Payment Date</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="report" items="${reportList}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>  <!-- Display record number -->
                        <td>${report.productName}</td>  <!-- Display product name -->
                        <td>${report.quantity}</td>  <!-- Display quantity sold -->
                        <td>RM <fmt:formatNumber value="${report.sale}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>  <!-- Display total sales -->
                        <td><fmt:formatDate value="${report.datetime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
