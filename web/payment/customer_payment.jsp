<%@ page import="model.payment.PaymentSummary" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat DateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Galaxy | Payment History</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f4f6f8;
                margin: 0;
                padding: 20px;
            }

            h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 30px;
            }

            .table-container {
                max-width: 1000px;
                margin: 0 auto;
                background: white;
                border-radius: 10px;
                overflow-x: auto;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.05);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                text-align: center;
            }

            th, td {
                padding: 14px 20px;
                border-bottom: 1px solid #e0e0e0;
            }

            th {
                background-color: #3498db;
                color: white;
            }

            tr:hover {
                background-color: #f1f9ff;
            }

            td a {
                color: #3498db;
                text-decoration: none;
                font-weight: 500;
            }

            td a:hover {
                text-decoration: underline;
            }

            .no-data {
                text-align: center;
                padding: 20px;
                color: #888;
            }

            @media (max-width: 768px) {
                table {
                    font-size: 14px;
                }

                th, td {
                    padding: 10px;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <h2>Your Payment History</h2>

        <div class="table-container">
            <table>
                <tr>
                    <th>Main Payment ID</th>
                    <th>Date & Time</th>
                    <th>Payment Method</th>
                    <th>Total Items</th>
                    <th>Total Price</th>
                    <th>Actions</th>
                </tr>

                <%
                    List<PaymentSummary> summaries = (List<PaymentSummary>) request.getAttribute("paymentSummaries");
                    if (summaries != null && !summaries.isEmpty()) {
                        for (PaymentSummary p : summaries) {
                %>
                <tr>
                    <td><%= p.getMainPaymentId() %></td>
                    <td><%= DateTimeFormat.format(p.getPayDatetime()) %></td>
                    <td><%= p.getPayTypeId() %></td>
                    <td><%= p.getTotalItems() - 1 %></td>
                    <td>RM <%= String.format("%.2f", p.getTotalAmount()) %></td>
                    <td>
                        <a href="payment_details.jsp?mainPaymentId=<%= p.getMainPaymentId() %>">View Details</a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr><td colspan="6" class="no-data">No payments found.</td></tr>
                <% } %>
            </table>
        </div>
    </body>
</html>
