<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.discount.Discount"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Set Title Icon -->
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <title>Galaxy | Main</title>
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <div class="center-img-container">
            <img src="/galaxy_bookshelf/picture/Galaxy_Brain_Logo.jpg" alt="Galaxy Brain Logo">
        </div>

        <div class="discount-grid">
            <%
                List<Discount> discountList = (List<Discount>) request.getAttribute("Discount");
                if (discountList != null && !discountList.isEmpty()) {
                    for (Discount d : discountList) {
            %>
            <div class="discount-card">
                <img src="<%= d.getProductPic() %>" alt="Product Image">
                <div class="discount-name"><%= d.getProductName() %></div>
                <div class="discount-original-price">RM <%= String.format("%.2f", d.getproductPrice()) %></div>
                <div class="discount-price">Now: RM <%= String.format("%.2f", d.getDiscountPrice()) %></div>
                <div class="discount-details"><%= d.getDetails() %></div>
                <div class="discount-expired">Ends on: <%= d.getExpiredDatetime() %></div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="no-discount">
                🚀 No discounts available at the moment! Stay tuned!
            </div>
            <%
                }
            %>
        </div>

    </body>
</html>
