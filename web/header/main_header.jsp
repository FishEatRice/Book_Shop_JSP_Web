<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // 从 session 中获取 account_status
    String CheckAcc = (String) session.getAttribute("account_status");

    // 如果没有登录，默认是 guest
    if (CheckAcc == null) {
        CheckAcc = "guest";
    }
%>

<nav>
    <ul>
        
        <li><a href="/galaxy_bookshelf/index.jsp">Home</a></li>
        <li><a href="/galaxy_bookshelf/">Product</a></li>

        <% if ("guest".equals(CheckAcc)) { %>
           
            <li><a href="/galaxy_bookshelf/loginChoose.jsp">Login</a></li>
            <li><a href="/galaxy_bookshelf/register.jsp">Register</a></li>
        <% } else { %>

            <% if ("customer".equals(CheckAcc)) { %>
                
                <li><a href="/galaxy_bookshelf/web/customer/list_cart.jsp">Cart</a></li>
                <li><a href="/galaxy_bookshelf/web/payment/payment_list.jsp">Purchase</a></li>

            <% } else if ("admin".equals(CheckAcc)) { %>
                
                <li><a href="/galaxy_bookshelf/">Staff Management</a></li>
            <% } %>

            <% if ("admin".equals(CheckAcc) || "staff".equals(CheckAcc)) { %>
                
                <li><a href="/galaxy_bookshelf/">Shipping</a></li>
                <li><a href="/galaxy_bookshelf/web/product/product.jsp">Product Manager</a></li>
                <li><a href="/galaxy_bookshelf/">Review</a></li>
                <li><a href="/galaxy_bookshelf/web/discount/discount_manager.jsp">Discount</a></li>
                <li><a href="/galaxy_bookshelf/">Customer Password</a></li>
                <li><a href="/galaxy_bookshelf/">Report</a></li>
            <% } %>

          
            <li><a href="/galaxy_bookshelf/">Account</a></li>
            <li><a href="/galaxy_bookshelf/logout.jsp">Logout</a></li>

        <% } %>
    </ul>
</nav>
