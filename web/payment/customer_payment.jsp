<%-- 
    Document   : customer_payment
    Created on : 22 Apr 2025, 4:45:53 AM
    Author     : ON YUEN SHERN
--%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Galaxy | Payment History</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <h2>Your Payment History</h2>

        <table border="1" cellpadding="10">
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
                <td><%= p.getTotalItems() - 1 %> </td>
                <td>RM <%= String.format("%.2f", p.getTotalAmount()) %></td>
                <td>
                    <a href="payment_details.jsp?mainPaymentId=<%= p.getMainPaymentId() %>">View Details</a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr><td colspan="6">No payments found.</td></tr>
            <% } %>
        </table>
    </body>
</html>
