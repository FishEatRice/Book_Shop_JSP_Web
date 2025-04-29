<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <title>Galaxy | Sales Records</title>

        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f6f8;
                margin: 0;
                padding: 20px;
                color: #333;
            }

            h2 {
                text-align: center;
                margin: 30px 0;
                font-size: 26px;
                color: #2c3e50;
            }

            form {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 15px;
                margin-bottom: 30px;
                flex-wrap: wrap;
            }

            form input[type="date"],
            form input[type="month"],
            form input[type="number"] {
                padding: 8px 12px;
                font-size: 16px;
                border-radius: 6px;
                border: 1px solid #ccc;
            }

            form button,
            form input[type="submit"] {
                padding: 8px 16px;
                font-size: 16px;
                background-color: #3498db;
                color: #fff;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            form button:hover,
            form input[type="submit"]:hover {
                background-color: #2c80b4;
            }

            p {
                text-align: center;
                font-size: 18px;
                margin-bottom: 10px;
            }

            table {
                width: 95%;
                max-width: 1000px;
                margin: 0 auto;
                border-collapse: collapse;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                background-color: #fff;
                border-radius: 8px;
                overflow: hidden;
            }

            th, td {
                padding: 14px;
                text-align: center;
                border: 1px solid #ddd;
            }

            thead {
                background-color: #2c3e50;
                color: #fff;
            }

            tbody tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            tbody tr:hover {
                background-color: #e8f6ff;
            }

            td[colspan="5"] {
                font-style: italic;
                color: #888;
            }
        </style>


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
