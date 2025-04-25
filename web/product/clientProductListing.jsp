<%-- 
    Document   : clientProductListing
    Created on : 25 Apr 2025, 18:12:51
    Author     : JS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Listing</title>
<!--        <style>
            .container {
                display: flex;
                flex-direction: column;
                width: 80%;
                margin: auto;
            }
            .search-bar {
                display: flex;
                margin: 10px 0;
            }
            .filter {
                margin-left: 10px;
            }
            .product-grid {
                display: flex;
                gap: 20px;
                flex-wrap: wrap;
            }
            .product-card {
                border: 2px solid red;
                padding: 10px;
                width: 150px;
                text-align: center;
            }
            .product-image {
                border: 2px solid skyblue;
                height: 100px;
                background-color: #eee;
            }
            .product-name {
                font-weight: bold;
                color: orange;
            }
            .product-price {
                color: orange;
            }
            .check-button {
                margin-top: 10px;
            }
        </style>-->
    </head>
    <body>
        <h1>Product Listing</h1>
        <div class="container">
            <div class="search-bar">
                <form method="get" action="clientProductListing">
                    <input type="text" name="query" placeholder="Search..." value="${param.query}" />
                    <div class="filter">
                        <select name="genre">
                            <option value="all" ${param.genre == 'all' ? 'selected' : ''}>All Genres</option>
                            <option value="Honor Story" ${param.genre == 'Honor Story' ? 'selected' : ''}>Honor Story</option>
                            <option value="Love Story" ${param.genre == 'Love Story' ? 'selected' : ''}>Love Story</option>
                        </select>
                    </div>
                    <button type="submit">Search</button>
                </form>
            </div>

            <div class="product-grid">
                <!-- Dynamically display products -->
                <c:forEach var="product" items="${productData}">
                    <div class="product-card">
                        <div class="product-image">
                            <img src="${product.productPicture}" alt="Product Image" />
                        </div>
                        <div class="product-name">${product.productName}</div>
                        <div class="product-price">RM ${product.productPrice}</div>
                        <form method="get" action="${pageContext.request.contextPath}/web/product/clientProductDetails.jsp">
                            <input type="hidden" name="id" value="${product.productId}" />
                            <button class="check-button" type="submit">Check</button>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </div>
    </body>
</html>
