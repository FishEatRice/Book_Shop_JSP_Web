<%-- 
    Document   : customer_cart
    Created on : 13 Apr 2025, 7:02:34 PM
    Author     : ON YUEN SHERN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.cart.CustomerCart" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Set Title Icon -->
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <title>Galaxy | Cart List</title>
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <form action="" method="post">
            <table border="1" cellpadding="8">
                <tr>
                    <th>No.</th>
                    <th>Select</th>
                    <th>Product Name</th>
                    <th>Quantity in Cart</th>
                    <th>Quantity in Stock</th>
                    <th>Action</th>
                </tr>
                <%
                    List<CustomerCart> CustomerCarts = (List<CustomerCart>) request.getAttribute("Cart_Item");
                    int no = 1;
                    
                    // If Having Items
                    if (CustomerCarts != null && !CustomerCarts.isEmpty()) {
                    
                        for (CustomerCart item : CustomerCarts) {
                %>
                <tr>
                    <td><%= no++ %></td>
                    <td><input type="checkbox" name="selectedProducts" value="<%= item.getProductId() %>" /></td>
                    <td><%= item.getProductName() %></td>
                    <td><%= item.getQuantityInCart() %></td>
                    <td><%= item.getQuantityInStock() %></td>
                    <td>
                        <a href="#">Edit</a> |
                        <a href="#">Remove</a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                        // No Items
                %>
                <tr>
                    <td colspan="6" style="text-align:center;">No products in the cart.</td>
                </tr>
                <%
                    }
                %>
            </table>
            <br />
            <input type="submit" value="Proceed with Selected Items">
        </form>
    </body>
</html>