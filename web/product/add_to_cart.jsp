<%-- 
    Document   : add_to_cart
    Created on : 12 Apr 2025, 11:47:16 PM
    Author     : ON YUEN SHERN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Set Title Icon -->
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <title>Galaxy BookShelf | Demo Cart</title>
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <!-- Cart Responds -->
        <%@ include file="/cart/cart_responds.jsp" %>

        <h1>Add To Cart Demo</h1>
        <!-- C1 = customer -->
        <form method="post" action="<%= request.getContextPath() %>/add_to_cart_process" >

            <p>，
                <label>Ali Peter</label>
                <label> | </label>
                <label>Max Quantity : <%= request.getAttribute("quantity") %></label>
                <label> | </label>
                <input type="hidden" name="product_id" value="P1" />
                <input type="number" name="quantity" value="1" min="1" max=<%= request.getAttribute("quantity") %> />
                <input type="submit" value="Add To Cart" />
            </p>
        </form>

        <form method="post" action="<%= request.getContextPath() %>/add_to_cart_process" >

            <p>，
                <label>The Golden End</label>
                <label> | </label>
                <label>Max Quantity : <%= request.getAttribute("quantity") %></label>
                <label> | </label>
                <input type="hidden" name="product_id" value="P2" />
                <input type="number" name="quantity" value="1" min="1" max=<%= request.getAttribute("quantity") %> />
                <input type="submit" value="Add To Cart" />
            </p>
        </form>

    </body>
</html>
