<%-- 
    Document   : customer_cart
    Created on : 13 Apr 2025, 7:02:34 PM
    Author     : ON YUEN SHERN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Set Title Icon -->
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <title>Galaxy | Cart</title>
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>
        
        <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

        <h2>Your Cart</h2>

        <table border="1">
            <tr>
                <th></th>
                <th>Product</th>
                <th>Unit Price</th>
                <th>Quantity</th>
                <th>Total Price</th>
                <th>Actions</th>
            </tr>

            <c:forEach var="item" items="${Cart_Item}">
                <tr>
                    <td></td>
                    <td><img src="${item.productPic}" alt="${item.productName}" width="100" /> ${item.productName}</td>
                    <td>RM <fmt:formatNumber value="${item.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
                    <td>${item.quantityInCart}</td>
                    <td>RM <fmt:formatNumber value="${item.productPrice * item.quantityInCart}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
                    <td></td>
                </tr>
            </c:forEach>

        </table>

    </body>
</html>