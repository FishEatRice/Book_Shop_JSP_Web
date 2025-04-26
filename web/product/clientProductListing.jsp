<%-- 
    Document   : clientProductListing
    Created on : 25 Apr 2025, 18:12:51
    Author     : JS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="model.product.Product"%>

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
                <form method="get" action="<%= request.getContextPath() %>/web/product/clientProductSearch">
                    <input type="text" name="query" value="<%= request.getParameter("query") == null ? "" : request.getParameter("query") %>" />

            <div class="filter">
                  <select name="genreId" id="genreId">
                      <option value="">Select Genre</option>
                      <c:forEach var="genre" items="${genreList}">
                          <option value="${genre.genreId}" 
                                  <c:if test="${genre.genreId == param.genreId}">selected</c:if>>
                              ${genre.genreName}
                          </option>
                      </c:forEach>
                  </select>
            </div>
                    
                    <button type="submit">Search</button>
                </form>
            </div>

            <div class="product-grid">
                
            <!-- Dynamically display products -->
            <c:if test="${not empty productData}">
                <c:forEach var="product" items="${productData}">
                    <div class="product-card">
                        <div class="product-image">
                            <img src="${product.productPicture}" alt="Product Image" />
                        </div>
                        <div class="product-name">${product.productName}</div>
                        <div class="product-price">RM ${product.productPrice}</div>
                        <form method="get" action="${pageContext.request.contextPath}/web/product/clientProductDetails.jsp">
                            <input type="hidden" name="id" value="${product.productId}" />
                            <button class="check-button" type="submit">Check Details</button>
                        </form>
                    </div>
                </c:forEach>
            </c:if>

            <!-- If product is empty or result not found -->
            <c:if test="${empty productData}">
                <p>No product found.</p>
            </c:if>

            </div>
        </div>
    </body>
</html>
