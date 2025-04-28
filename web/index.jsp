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
        <style>
            body {
                background-color: #f4f6f8;
                margin: 0;
                font-family: Arial, sans-serif;
            }
            .center-img-container {
                text-align: center;
                padding: 30px 0;
            }
            .center-img-container img {
                width: 25%;
                display: block;
                margin: auto;
            }
            .discount-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 20px;
                padding: 20px;
                max-width: 1200px;
                margin: auto;
            }
            .discount-card {
                border: 1px solid #ccc;
                border-radius: 10px;
                padding: 15px;
                text-align: center;
                background-color: #fafafa;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                transition: transform 0.3s, box-shadow 0.3s;
            }
            .discount-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            }
            .discount-card img {
                max-width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 10px;
            }
            .discount-name {
                font-size: 18px;
                font-weight: bold;
                margin: 10px 0;
            }
            .discount-original-price {
                text-decoration: line-through;
                color: #888;
            }
            .discount-price {
                color: #d9534f;
                font-size: 20px;
                font-weight: bold;
            }
            .discount-details {
                margin: 10px 0;
                color: #555;
            }
            .discount-expired {
                font-size: 12px;
                color: #999;
            }
            .no-discount {
                text-align: center;
                padding: 50px;
                font-size: 20px;
                color: #777;
            }
        </style>
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
