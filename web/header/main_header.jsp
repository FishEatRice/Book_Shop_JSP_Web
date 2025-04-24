

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String CheckAcc = (String) session.getAttribute("account_status");
    if (CheckAcc == null) {
        CheckAcc = "guest";
        
        // guest = null
        // customer = customer
        // admin = admin
        // staff = staff
    }
    
    //Demo CheckAcc 
    CheckAcc = "customer";
%>

<nav>
    <ul>
        <!-- NULL / Guest -->
        <li><a href="/galaxy_bookshelf/index.jsp">Home</a></li>

        <li><a href="/galaxy_bookshelf/">Product</a></li>

        <% if ("guest".equals(CheckAcc)) { %>

        <!-- Not Yet Login -->
        <li><a href="/galaxy_bookshelf/">Login</a></li>

        <li><a href="/galaxy_bookshelf/">Register</a></li>

        <% } else { %>

        <% if ("customer".equals(CheckAcc)) { %>

        <!-- Customer -->
        <li><a href="/galaxy_bookshelf/web/customer/list_cart.jsp">Cart</a></li>

        <li><a href="/galaxy_bookshelf/web/payment/payment_list.jsp">Purchase</a></li>

        <% } else if ("admin".equals(CheckAcc)) { %>

        <!-- Admin -->
        <li><a href="/galaxy_bookshelf/">Staff Management</a></li>


        <% } %>

        <% if ("admin".equals(CheckAcc) || "staff".equals(CheckAcc)) { %>

        <!-- Staff / Admin -->
        <li><a href="/galaxy_bookshelf/">Shipping</a></li>

        <li><a href="/galaxy_bookshelf/web/product/product.jsp">Product Manager</a></li>

        <li><a href="/galaxy_bookshelf/">Review</a></li>

        <li><a href="/galaxy_bookshelf/web/discount/discount_manager.jsp">Discount</a></li>

        <li><a href="/galaxy_bookshelf/">Customer Password</a></li>

        <li><a href="/galaxy_bookshelf/">Report</a></li>

        <% } %>

        <!-- Already Login -->
        <li><a href="/galaxy_bookshelf/">Account</a></li>

        <li><a href="/galaxy_bookshelf/">Logout</a></li>

        <% } %>

    </ul>

</nav>
