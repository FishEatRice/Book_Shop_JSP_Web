<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Galaxy | Cart</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <h2>Confirm Your Items</h2>

        <table border="1">
            <tr>
                <th>No.</th>
                <th colspan="2">Product</th>
                <th>Unit Price</th>
                <th>Quantity</th>
                <th>Total</th>
            </tr>
            <% int no = 1; %>
            <c:forEach var="item" items="${SelectedItems}">
                <tr>
                    <td><%= no++ %></td>
                    <td>
                        <img src="${item.productPic}" width="100" />
                    </td>
                    <td>${item.productName}</td>
                    <td>RM <fmt:formatNumber value="${item.productPrice}" type="number" minFractionDigits="2"/></td>
                    <td>${item.quantityInCart}</td>
                    <td>RM <fmt:formatNumber value="${item.productPrice * item.quantityInCart}" type="number" minFractionDigits="2"/></td>
                </tr>
            </c:forEach>
            <tr>
                <td colspan="4"></td>
                <td>Merchandise Subtotal</td>
                <td>RM <fmt:formatNumber value="${Subtotal}" type="number" minFractionDigits="2" /></td>
            </tr>
            <tr>
                <td colspan="4"></td>
                <td>Shipping Fee</td>
                <td>RM <fmt:formatNumber value="${ShippingFee}" type="number" minFractionDigits="2" /></td>
            </tr>
            <tr>
                <td colspan="4"></td>
                <td>Total Payment</td>
                <td>RM <fmt:formatNumber value="${Total}" type="number" minFractionDigits="2" /></td>
            </tr>

        </table>

        <br>

        <form action="/galaxy_bookshelf/web/payment/process.jsp" method="get">
            <input type="hidden" name="cart_ids" value="${CartIDs}" />
            <p>Select Payment Method:</p>
            <c:forEach var="pay" items="${PayTypes}">
                <label>
                    <input type="radio" name="pay_type" value="${pay.id}" required />
                    ${pay.name}
                    <br>
                </label>
            </c:forEach>

            <br>

            <button type="submit">Confirm & Pay</button>
        </form>
    </body>
</html>