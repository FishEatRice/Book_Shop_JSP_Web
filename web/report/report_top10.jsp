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

        <style>
            h1 {
                text-align: center;
                color: #2c3e50;
                margin-top: 30px;
            }

            table {
                width: 90%;
                max-width: 1000px;
                margin: 0 auto 50px;
                border-collapse: collapse;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            }

            th, td {
                padding: 15px;
                text-align: center;
                border: 1px solid #ddd;
            }

            /* Color classes for rows */
            .row-1 {
                background-color: #ffe6e6;
            }
            .row-2 {
                background-color: #ffeedd;
            }
            .row-3 {
                background-color: #fff7cc;
            }
            .row-4 {
                background-color: #e6ffcc;
            }
            .row-5 {
                background-color: #ccffea;
            }
            .row-6 {
                background-color: #ccf2ff;
            }
            .row-7 {
                background-color: #d9ccff;
            }
            .row-8 {
                background-color: #f4ccff;
            }
            .row-9 {
                background-color: #ffccf9;
            }
            .row-10 {
                background-color: #fdd;
            }

            tr:hover td {
                background-color: white !important;
            }
        </style>

    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <a href="/galaxy_bookshelf/report/report_main.jsp">Back to Report Main Page</a>

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
                    <tr class="row-<%= i %>">
                        <td><%= i %></td>
                        <td>${entry.value.productName}</td>
                        <td>${entry.value.quantity}</td>
                        <td>RM <fmt:formatNumber value="${entry.value.sale}" type="number" minFractionDigits="2" /></td>
                    </tr>
                    <% i++; %>
                </c:forEach>

            </tbody>
        </table>
    </body>
</html>
