<%@ page import="model.payment.PaymentDetail" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    List<PaymentDetail> paymentList = (List<PaymentDetail>) request.getAttribute("paymentList");
    String shippingStatus = "";
    String payType = "";
    String datetime = "";
    if (paymentList != null && !paymentList.isEmpty()) {
        for (PaymentDetail temp : paymentList) {
            if (!"Shipping Fee".equalsIgnoreCase(temp.getProductName())) {
                shippingStatus = temp.getShippingStatusName();
                payType = temp.getPayTypeName();
                datetime = temp.getPayDatetime().substring(0, 19);
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
        <p>Payment Datetime: <%= datetime %></p>

        <h2>Order Summary</h2>
        <table border="1">
            <tr>
                <th>No.</th>
                <th>Product Name</th>
                <th>Unit Price</th>
                <th>Quantity</th>
                <th>Total</th>
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
                            subtotal += p.getPayPrice() * p.getQuantity();
            %>
            <tr>
                <td><%= no++ %></td>
                <td><%= p.getProductName() %></td>
                <td>RM <%= String.format("%.2f", p.getPayPrice()) %></td>
                <td><%= p.getQuantity() %></td>
                <td>RM <%= String.format("%.2f", p.getPayPrice() * p.getQuantity()) %></td>
            </tr>
            <%
                        }
                    }
                }

                double total = subtotal + shippingFee;
            %>
            <tr>
                <td colspan="3"></td>
                <td>Merchandise Subtotal</td>
                <td>RM <%= String.format("%.2f", subtotal) %></td>
            </tr>
            <tr>
                <td colspan="3"></td>
                <td>Shipping Fee</td>
                <td>RM <%= String.format("%.2f", shippingFee) %></td>
            </tr>
            <tr>
                <td colspan="3"></td>
                <td>Total</td>
                <td><strong>RM <%= String.format("%.2f", total) %></strong></td>
            </tr>
        </table>
    </body>
</html>
