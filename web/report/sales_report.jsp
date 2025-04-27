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

        <a href="/galaxy_bookshelf/report/report_main.jsp">Back to Report Main Page</a>

        <h2>Sales Records - <c:out value="${reportType}" /> View</h2>

        <form action="/galaxy_bookshelf/web/report/sales_records.jsp">
            <input type="hidden" name="type" value="${param.type}">
            <input id="dateInput" name="date" required>
            <button type="button" onclick="resetDate()">Today</button>
            <input type="submit" value="search">
        </form>

        <p>Total Sales : RM <fmt:formatNumber value="${total_price}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>

        <p>Total Shipping : RM <fmt:formatNumber value="${total_shipping}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>

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
                <c:choose>
                    <c:when test="${not empty reportList}">
                        <c:forEach var="report" items="${reportList}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${report.productName}</td>
                                <td>${report.quantity}</td>
                                <td>RM <fmt:formatNumber value="${report.sale}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
                                <td><fmt:formatDate value="${report.datetime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" style="text-align: center;">No product</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const params = new URLSearchParams(window.location.search);
                const type = params.get('type');
                const dateInput = document.getElementById("dateInput");

                var today = new Date();
                var yyyy = today.getFullYear();

                if (type === "monthly") {
                    dateInput.setAttribute("type", "month");
                } else if (type === "yearly") {
                    dateInput.setAttribute("type", "number");
                    dateInput.setAttribute("max", yyyy);
                    dateInput.setAttribute("min", "2024");
                } else if (type === "daily") {
                    dateInput.setAttribute("type", "date");

                    var today = new Date();
                    var yyyy = today.getFullYear();
                    var mm = today.getMonth() + 1;
                    var dd = today.getDate();
                    if (mm < 10)
                        mm = '0' + mm;
                    if (dd < 10)
                        dd = '0' + dd;
                    var todayString = yyyy + '-' + mm + '-' + dd;

                    // Limit date selection to today or earlier
                    dateInput.setAttribute("max", todayString);
                }
            });

            function resetDate() {
                const params = new URLSearchParams(window.location.search);
                const type = params.get('type');
                const dateInput = document.getElementById("dateInput");

                var today = new Date();
                var yyyy = today.getFullYear();
                var mm = today.getMonth() + 1;
                if (mm < 10)
                    mm = '0' + mm;

                if (type === "monthly") {
                    dateInput.value = yyyy + '-' + mm; // YYYY-MM for month picker
                } else if (type === "daily") {
                    var dd = today.getDate();
                    if (dd < 10)
                        dd = '0' + dd;
                    dateInput.value = yyyy + '-' + mm + '-' + dd; // YYYY-MM-DD for date picker
                } else if (type === "yearly") {
                    dateInput.value = yyyy; // YYYY only
                }
            }
        </script>
    </body>
</html>
