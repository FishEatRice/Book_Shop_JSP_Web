<%-- 
    Document   : main_header
    Created on : 12 Apr 2025, 3:12:26 PM
    Author     : ON YUEN SHERN
--%>

<style>
    body {
        margin: 0;
        padding: 0;
        padding-top: 80px;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        background-color: #f2efed;
        color: #333;
    }

    .header_area {
        position: fixed;
        top: 0;
        width: 100%;
        z-index: 999;
        background: linear-gradient(90deg, #0f2027, #203a43, #2c5364);
        padding: 15px 15px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    .header_area nav {
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .header_area nav ul {
        list-style: none;
        margin: 0;
        padding: 0;
        display: flex;
        align-items: center;
        flex-wrap: wrap;
    }

    .header_area nav ul li {
        margin: 0 6px;
    }

    .header_area nav ul li a {
        font-size: 15px;
        padding: 6px 10px;
        border-radius: 4px;
        color: #fff;
        font-weight: 500;
        text-decoration: none;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
    }

    .header_area nav ul li a:hover {
        transform: scale(1.05);
        box-shadow: 0 0 10px rgba(255, 255, 255, 0.3);
        background-color: rgba(255, 255, 255, 0.1);
    }

    .header_pic {
        width: 35px;
        height: 35px;
        object-fit: cover;
        border-radius: 50%;
        transition: all 0.3s ease;
    }

    .header_area nav ul li a:hover img.header_pic {
        transform: scale(1.1);
        box-shadow: 0 0 10px rgba(255, 255, 255, 0.3);
    }
</style>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header class="header_area">

    <%
        String CheckAcc = (String) session.getAttribute("userRole");
        if (CheckAcc == null) {
            CheckAcc = "guest";
        
            // guest = null
            // customer = customer
            // admin = admin
            // staff = staff
        }
    
        //Demo CheckAcc 
        //CheckAcc = "staff";
    %>

    <nav>
        <ul>
            <!-- NULL / Guest -->
            <li><a href="/galaxy_bookshelf/web/index.jsp"><img class="header_pic" src="/galaxy_bookshelf/picture/Galaxy_Brain_Logo.jpg" alt="header_logo"/></a></li>

            <li><a href="/galaxy_bookshelf/web/index.jsp">Home</a></li>

            <li><a href="/galaxy_bookshelf/web/product/clientProductListing.jsp">Product</a></li>

            <% if ("guest".equals(CheckAcc)) { %>

            <!-- Not Yet Login -->
            <li><a href="/galaxy_bookshelf/guard/loginChoose.jsp">Login</a></li>

            <li><a href="/galaxy_bookshelf/customer/registerMember.jsp">Register</a></li>

            <% } else { %>

            <% if ("admin".equals(CheckAcc) || "staff".equals(CheckAcc)) { %>

            <!-- Staff / Admin -->
            <li><a href="/galaxy_bookshelf/web/product/product.jsp">Product Manager</a></li>

            <li><a href="/galaxy_bookshelf/web/genre/list_genre.jsp">Genre Manager</a></li>

            <li><a href="/galaxy_bookshelf/web/staff/comment_list.jsp">Comments Manager</a></li>

            <li><a href="/galaxy_bookshelf/web/discount/discount_manager.jsp">Discount Manager</a></li>

            <li><a href="/galaxy_bookshelf/report/report_main.jsp">Report Manager</a></li>

            <% } %>

            <% if ("customer".equals(CheckAcc)) { %>

            <!-- Customer -->
            <li><a href="/galaxy_bookshelf/web/customer/list_cart.jsp">Cart</a></li>

            <li><a href="/galaxy_bookshelf/web/payment/payment_list.jsp">Purchase History</a></li>

            <li><a href="/galaxy_bookshelf/customer/customerProfileDetails.jsp">Account</a></li>

            <% } else if ("admin".equals(CheckAcc)) { %>

            <!-- Admin -->
            <li><a href="/galaxy_bookshelf/staff/customerManagementList.jsp">Customer Manager</a></li>

            <li><a href="/galaxy_bookshelf/admin/controlStaff.jsp">Staff Manager</a></li>

            <li><a href="/galaxy_bookshelf/admin/adminProfileDetails.jsp">Account</a></li>

            <% } else if ("staff".equals(CheckAcc)) { %>

            <li><a href="/galaxy_bookshelf/staff/staffProfileDetails.jsp">Account</a></li>

            <% } %>

            <!-- Already Login -->
            <li><a href="/galaxy_bookshelf/guard/SessionLogout.jsp">Logout</a></li>

            <% } %>

        </ul>

    </nav>

</header>