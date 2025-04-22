<%@ page import="model.payment.PaymentDetail" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    List<PaymentDetail> paymentList = (List<PaymentDetail>) request.getAttribute("paymentList");
    String shippingStatus = "";
    String payType = "";
    if (paymentList != null && !paymentList.isEmpty()) {
        for (PaymentDetail temp : paymentList) {
            if (!"Shipping Fee".equalsIgnoreCase(temp.getProductName())) {
                shippingStatus = temp.getShippingStatusName();
                payType = temp.getPayTypeName();
                break;
            }
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Galaxy | Payment Details</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <a href="/galaxy_bookshelf/web/payment/payment_list.jsp">Back to Payment History</a>

        <h1>Payment Details</h1>

        <p>Shipping status: <%= shippingStatus %></p>
        <p>Payment Method: <%= payType %></p>

        <table border="1">
            <tr>
                <th>Product Name</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Date</th>
            </tr>
            <%
                if (paymentList != null) {
                    for (PaymentDetail p : paymentList) {
                        if ("Shipping Fee".equalsIgnoreCase(p.getProductName())) continue;
            %>
            <tr>
                <td><%= p.getProductName() %></td>
                <td>RM <%= String.format("%.2f", p.getPayPrice()) %></td>
                <td><%= p.getQuantity() %></td>
                <td><%= p.getPayDatetime().substring(0, 19) %></td>
            </tr>
            <%
                    }
                }
            %>
        </table>

        <br><br>

        <h2>Order Summary</h2>
        <table border="1">
            <tr>
                <th>No.</th>
                <th>Item</th>
                <th>Price</th>
            </tr>
            <%
                int no = 1;
                double subtotal = 0;
                double shippingFee = 0;

                if (paymentList != null) {
                    for (PaymentDetail p : paymentList) {
                        if ("Shipping Fee".equalsIgnoreCase(p.getProductName())) {
                            shippingFee = p.getPayPrice();
                        } else {
                            subtotal += p.getPayPrice();
            %>
            <tr>
                <td><%= no++ %></td>
                <td><%= p.getProductName() %></td>
                <td>RM <%= String.format("%.2f", p.getPayPrice()) %></td>
            </tr>
            <%
                        }
                    }
                }

                double total = subtotal + shippingFee;
            %>
            <tr>
                <td colspan="2">Shipping Fee</td>
                <td>RM <%= String.format("%.2f", shippingFee) %></td>
            </tr>
            <tr>
                <td colspan="2"><strong>Total</strong></td>
                <td><strong>RM <%= String.format("%.2f", total) %></strong></td>
            </tr>
        </table>
    </body>
</html>
