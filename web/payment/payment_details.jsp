<%@ page import="model.payment.PaymentDetail" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    List<PaymentDetail> paymentList = (List<PaymentDetail>) request.getAttribute("paymentList");
    String payType = "";
    String datetime = "";
    String address = "";
    boolean showReplyColumn = false; // Flag to check if the "Reply" column should be shown

    if (paymentList != null && !paymentList.isEmpty()) {
        for (PaymentDetail temp : paymentList) {
            if (!"Shipping Fee".equalsIgnoreCase(temp.getProductName())) {
                payType = temp.getPayTypeName();
                datetime = temp.getPayDatetime().substring(0, 19);
                address = temp.getAddress();
                
                // Check if any product has a valid reply
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
        <!-- Font Awesome CDN for icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <a href="/galaxy_bookshelf/web/payment/payment_list.jsp">Back to Payment History</a>

        <h1>Payment Details</h1>

        <p>Payment Method: <%= payType %></p>
        <p>Payment Datetime: <%= datetime %></p>
        <h2>Address:</h2> 
        <p><%= address %></p>

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

        <!-- Comment Section -->
        <h2>Comments</h2>

        <table border="1">
            <tr>
                <th>No</th>
                <th>Product Name</th>
                <th>Rating</th>
                <th>Comment</th>
                <%-- Conditionally render the Reply column header --%>
                <%
                    if (showReplyColumn) {
                %>
                <th>Reply</th>
                <%
                    }
                %>
                <th>Action</th>
            </tr>
            <%
                no = 1;
                for (PaymentDetail p : paymentList) {
                    // Skip Shipping Fee rows
                    if ("Shipping Fee".equalsIgnoreCase(p.getProductName())) {
                        continue;
                    }

                    int ratingStar = p.getRatingStar();
                    String reply = p.getReply(); // Get the reply

                    // Check if there is a valid reply (not "Ignore" or "not yet reply")
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
                <td colspan="4"><a href='/galaxy_bookshelf/web/comment/comment.jsp?id=<%= p.getPaymentId() %>'>Add Comment</a></td>
                <%
                    } else {
                %>
                <td>
                    <%-- Display rating stars --%>
                    <%
                    for (int i = 1; i <= 5; i++) {
                        if (i <= ratingStar) {
                    %>
                    <i class="fa-solid fa-star" style="color: orange;"></i>
                    <%
                        } else {
                    %>
                    <i class="fa-solid fa-star" style="color: gray;"></i>
                    <%
                        }
                    }
                    %>
                </td>
                <td><%= p.getComment() %></td>

                <%-- Conditionally render the Reply column content --%>
                <%
                    if (hasValidReply) {
                %>
                <td><%= p.getReply() %></td>
                <%
                    } 
                %>

                <td>
                    <a href='/galaxy_bookshelf/web/comment/comment.jsp?id=<%= p.getPaymentId() %>'>Edit Comment</a>
                </td>
                <%
                    }
                %>
            </tr>
            <%
                }
            %>
        </table>
    </body>
</html>
