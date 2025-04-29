<%-- 
    Document   : clientProductListing
    Created on : 25 Apr 2025, 18:12:51
    Author     : JS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.product.Product" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Galaxy BookShelf | Product Listing</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />
        <style>
            h1 {
                text-align: center;
                margin: 30px 0 20px;
                color: #2c3e50;
            }

            .container {
                max-width: 1200px;
                margin: auto;
                padding: 0 20px;
            }

            .search-bar {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                justify-content: center;
                margin-bottom: 30px;
            }

            .search-bar input[type="text"],
            .search-bar select {
                padding: 8px 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
                width: 200px;
            }

            .search-bar button {
                padding: 8px 16px;
                background-color: #3498db;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
            }

            .product-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
                gap: 20px;
            }

            .product-card {
                background-color: white;
                border-radius: 10px;
                padding: 15px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                display: flex;
                flex-direction: column;
                align-items: center;
                text-align: center;
                transition: transform 0.2s ease;
            }

            .product-card:hover {
                transform: scale(1.02);
            }

            .product-image img {
                width: 100%;
                height: 180px;
                object-fit: cover;
                border-radius: 8px;
            }

            .product-name {
                font-size: 18px;
                font-weight: bold;
                margin: 10px 0 5px;
                color: #333;
            }

            .product-genre {
                color: #666;
                font-size: 14px;
                margin-bottom: 10px;
            }

            .product-price {
                margin-bottom: 10px;
            }

            .product-price .original {
                text-decoration: line-through;
                color: #aaa;
                margin-right: 5px;
            }

            .product-price .discount {
                color: red;
                font-weight: bold;
            }

            .check-button {
                padding: 8px 14px;
                background-color: #27ae60;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .check-button:hover {
                background-color: #219150;
            }

            p {
                text-align: center;
                font-style: italic;
                color: #888;
            }
        </style>
    </head>
    <body>

        <%@ include file="/header/main_header.jsp" %>

        <h1>Product Listing</h1>

        <div class="container">

            <!-- Search and Filter -->
            <div class="search-bar">
                <form method="get" action="<%= request.getContextPath() %>/web/product/clientProductSearch">
                    <input type="text" name="query" value="<%= request.getParameter("query") == null ? "" : request.getParameter("query") %>" placeholder="Search by name" />
                    <select name="genreId" id="genreId">
                        <option value="">Select Genre</option>
                        <c:forEach var="genre" items="${genreList}">
                            <option value="${genre.genreId}" 
                                    <c:if test="${genre.genreId == param.genreId}">selected</c:if>>
                                ${genre.genreName}
                            </option>
                        </c:forEach>
                    </select>
                    <button type="submit"><i class="fas fa-search"></i> Search</button>
                    <button type="button" onclick="window.location.href = '/galaxy_bookshelf/web/product/clientProductListing.jsp'">
                        <i class="fa-solid fa-rotate-right"></i> Reset
                    </button>
                </form>
            </div>

            <!-- Product Grid -->
            <div class="product-grid">
                <c:if test="${not empty productData}">
                    <c:forEach var="product" items="${productData}">
                        <div class="product-card">
                            <div class="product-image">
                                <img src="${product.productPicture}" alt="${product.productName}" />
                            </div>
                            <div class="product-name">${product.productName}</div>
                            <div class="product-genre">${product.genreId.genreName}</div>
                            <div class="product-price">
                                <c:choose>
                                    <c:when test="${product.discountPrice != 0.0}">
                                        <span class="original">RM <fmt:formatNumber value="${product.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></span>
                                        <span class="discount">RM <fmt:formatNumber value="${product.discountPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="discount">RM <fmt:formatNumber value="${product.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <form method="get" action="${pageContext.request.contextPath}/web/product/clientProductDetails.jsp">
                                <input type="hidden" name="id" value="${product.productId}" />
                                <button class="check-button" type="submit">Check Details</button>
                            </form>
                        </div>
                    </c:forEach>
                </c:if>

                <!-- Empty message -->
                <c:if test="${empty productData}">
                    <p>No product found.</p>
                </c:if>
            </div>
        </div>

    </body>
</html>
