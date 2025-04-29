<%@ page import="model.payment.PaymentDetail" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    List<PaymentDetail> paymentList = (List<PaymentDetail>) request.getAttribute("paymentList");
    String payType = "", datetime = "", address = "";
    boolean showReplyColumn = false;

    if (paymentList != null && !paymentList.isEmpty()) {
        for (PaymentDetail temp : paymentList) {
            if (!"Shipping Fee".equalsIgnoreCase(temp.getProductName())) {
                payType = temp.getPayTypeName();
                datetime = temp.getPayDatetime().substring(0, 19);
                address = temp.getAddress();
                if (temp.getReply() != null && !temp.getReply().trim().isEmpty() &&
                    !temp.getReply().equalsIgnoreCase("Ignore") &&
                    !temp.getReply().equalsIgnoreCase("not yet reply")) {
                    showReplyColumn = true;
                }
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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 20px;
            }

            h1, h2 {
                text-align: left;
                color: #2c3e50;
            }

            p {
                text-align: left;
                color: #555;
            }

            .content-wrapper {
                max-width: 1100px;
                margin: 0 auto;
                background: #fff;
                border-radius: 10px;
                padding: 30px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.05);
            }

            .back-link {
                display: inline-block;
                margin-bottom: 20px;
                color: #3498db;
                text-decoration: none;
                font-weight: bold;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin: 25px 0;
                text-align: center;
            }

            th, td {
                padding: 12px;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #3498db;
                color: white;
            }

            tr:hover {
                background-color: #f1f9ff;
            }

            .total-row td {
                font-weight: bold;
                background-color: #f9f9f9;
            }

            a.button-link {
                padding: 8px 16px;
                background-color: #2980b9;
                color: white;
                text-decoration: none;
                border-radius: 6px;
            }

            a.button-link:hover {
                background-color: #1c5980;
            }

            .stars i {
                margin: 0 1px;
            }

            @media (max-width: 768px) {
                table, th, td {
                    font-size: 14px;
                }

                .content-wrapper {
                    padding: 15px;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <div class="content-wrapper">
            <a class="back-link" href="/galaxy_bookshelf/web/payment/payment_list.jsp"><i class="fas fa-arrow-left"></i> Back to Payment History</a>

            <h1>Payment Details</h1>

            <p><strong>Payment Method:</strong> <%= payType %></p>
            <p><strong>Payment Datetime:</strong> <%= datetime %></p>

            <h2>Address</h2>
            <p><%= address %></p>

            <h2>Order Summary</h2>
            <table>
                <tr>
                    <th>No.</th>
                    <th>Product Name</th>
                    <th>Unit Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                </tr>
                <%
                    int no = 1;
                    double subtotal = 0, shippingFee = 0;

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
                <tr class="total-row">
                    <td colspan="3"></td>
                    <td>Merchandise Subtotal</td>
                    <td>RM <%= String.format("%.2f", subtotal) %></td>
                </tr>
                <tr class="total-row">
                    <td colspan="3"></td>
                    <td>Shipping Fee</td>
                    <td>RM <%= String.format("%.2f", shippingFee) %></td>
                </tr>
                <tr class="total-row">
                    <td colspan="3"></td>
                    <td>Total</td>
                    <td>RM <strong><%= String.format("%.2f", total) %></strong></td>
                </tr>
            </table>

            <h2>Comments</h2>
            <table>
                <tr>
                    <th>No.</th>
                    <th>Product Name</th>
                    <th>Rating</th>
                    <th>Comment</th>
                    <% if (showReplyColumn) { %><th>Reply</th><% } %>
                    <th>Action</th>
                </tr>
                <%
                    no = 1;
                    for (PaymentDetail p : paymentList) {
                        if ("Shipping Fee".equalsIgnoreCase(p.getProductName())) continue;

                        int ratingStar = p.getRatingStar();
                        String reply = p.getReply();
                        boolean hasValidReply = reply != null && !reply.trim().isEmpty() &&
                                                !reply.equalsIgnoreCase("Ignore") &&
                                                !reply.equalsIgnoreCase("not yet reply");
                %>
                <tr>
                    <td><%= no++ %></td>
                    <td><%= p.getProductName() %></td>
                    <%
                        if (ratingStar == 0) {
                    %>
                    <td colspan="<%= showReplyColumn ? 4 : 3 %>">
                        <a class="button-link" href='/galaxy_bookshelf/web/comment/comment.jsp?id=<%= p.getPaymentId() %>'>Add Comment</a>
                    </td>
                    <%
                        } else {
                    %>
                    <td class="stars">
                        <% for (int i = 1; i <= 5; i++) { %>
                        <i class="fa-solid fa-star" style="color: <%= i <= ratingStar ? "orange" : "gray" %>;"></i>
                        <% } %>
                    </td>
                    <td><%= p.getComment() %></td>
                    <% if (showReplyColumn) { %>
                    <td><%= hasValidReply ? p.getReply() : "-" %></td>
                    <% } %>
                    <td>
                        <a class="button-link" href='/galaxy_bookshelf/web/comment/comment.jsp?id=<%= p.getPaymentId() %>'>Edit Comment</a>
                    </td>
                    <% } %>
                </tr>
                <% } %>
            </table>
        </div>
    </body>
</html>
