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

    <style>
        .center-img-container {
            text-align: center;
            padding: 15px;
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin: 20px;
            border-radius: 30px;
        }

        .center-img-container img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
        }

        .discount-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            padding: 40px 20px;
            max-width: 1200px;
            margin: auto;
        }

        .discount-card {
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            padding: 15px;
            transition: transform 0.3s ease;
            display: flex;
            flex-direction: column;
            height: 500px;
            overflow: hidden;
        }

        .discount-card:hover {
            transform: translateY(-5px);
        }

        .discount-card img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: 10px;
        }

        .discount-name {
            font-size: 1.1em;
            font-weight: bold;
            margin: 10px 0 5px;
            color: #444;
        }

        .discount-original-price {
            text-decoration: line-through;
            color: #888;
            font-size: 0.9em;
        }

        .discount-price {
            font-size: 1.2em;
            font-weight: bold;
            color: #e53935;
            margin: 5px 0;
        }

        .discount-details {
            font-size: 0.9em;
            color: #555;
            overflow-y: auto;
            flex-grow: 1;
        }

        .discount-expired {
            font-size: 0.8em;
            color: #888;
            margin-top: 10px;
        }

        .no-discount {
            text-align: center;
            font-size: 1.2em;
            padding: 50px;
            color: #666;
            grid-column: 1 / -1;
        }

        @media (max-width: 992px) {
            .discount-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 600px) {
            .discount-grid {
                grid-template-columns: 1fr;
            }
            .discount-card {
                height: auto;
            }
        }
    </style>

    <body>
        <%@ include file="/header/main_header.jsp" %>

        <div class="center-img-container">
            <img src="/galaxy_bookshelf/picture/Galaxy_Banner.png" alt="Galaxy Banner">
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
                <div class="discount-details">
                    <%= (d.getDetails() != null && !d.getDetails().isEmpty() && !d.getDetails().equals("<p><br></p>")) ? d.getDetails() : "Special Discount" %>
                </div>
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
