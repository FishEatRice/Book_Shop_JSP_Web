<%-- 
    Document   : clientProductDetails
    Created on : 25 Apr 2025, 18:18:18
    Author     : JS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="model.product.Product"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <title>Galaxy BookShelf | Product Details</title>
        <style>
            .container {
                width: 80%;
                margin: auto;
                font-family: sans-serif;
            }

            .back-link {
                color: blue;
                display: inline-block;
                margin: 10px 0;
                text-decoration: none;
            }

            .product-section {
                display: flex;
                gap: 30px;
                align-items: flex-start;
            }

            .product-image {
                border: 2px solid blue;
                width: 300px;
                height: 300px;
                background-color: #eee;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
            }

            .product-info {
                flex: 1;
            }

            .product-name {
                color: blue;
                font-size: 1.5em;
            }

            .product-price {
                font-size: 2em;
                font-weight: bold;
                color: orange;
                margin: 10px 0;
            }

            .stock, .quantity-box {
                margin: 10px 0;
            }

            .quantity-box {
                display: flex;
                gap: 5px;
                align-items: center;
            }

            .quantity-box input {
                width: 50px;
                text-align: center;
            }

            .add-to-cart {
                background-color: yellow;
                border: 2px solid #aaa;
                padding: 10px 25px;
                margin-top: 10px;
                font-weight: bold;
                cursor: pointer;
            }

            .details, .comment {
                margin-top: 30px;
                padding: 15px;
            }

            .details {
                border: 2px solid purple;
            }

            .comment {
                border: 2px solid orange;

            }

            input[type=number]::-webkit-inner-spin-button,
            input[type=number]::-webkit-outer-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }
        </style>
    </head>
    <body>

    <%@ include file="/header/main_header.jsp" %>

        <div class="container">
            <a href="clientProductListing.jsp" class="back-link">← Back</a>

            <div class="product-section">
                <!-- Left: Image -->
                <div class="product-image"><img src="${productData.productPicture}" alt="Product Image" width="300" height="300"/></div>

                <!-- Right: Info -->
                <div class="product-info">
                    <div class="product-name">${productData.productName}</div>

                    <c:choose>
                        <c:when test="${productData.discountPrice != 0.0}">
                            <div class="product-price">
                                <span style="color: red; font-weight: bold;">
                                    RM <fmt:formatNumber value="${productData.discountPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                </span>
                                <span style="text-decoration: line-through; color: gray; font-size: 15px;">
                                    RM <fmt:formatNumber value="${productData.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                </span>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="product-price">
                                RM <fmt:formatNumber value="${productData.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                            </div>
                        </c:otherwise>
                    </c:choose>


                    <form method="post" action="add-to-cart">
                        <input type="hidden" name="productId" value="1" />

                        <p>Genre: ${productData.genreId.genreName}</p>

                        <div class="stock">Stock Quantity: <strong>${productData.quantity}</strong></div>

                        <div class="quantity-box">
                            Quantity:
                            <button type="button" onclick="adjustQty(this)">-</button>
                            <input type="number" name="quantity" id="qtyInput" value="1" min="1" max="${productData.quantity}"/>
                            <button type="button" onclick="adjustQty(this)">+</button>
                        </div>

                        <button type="submit" class="add-to-cart">Add to Cart</button>
                    </form>
                </div>
            </div>

            <div class="details">
                <h3>Details</h3>
                <p>
                    ${productData.productInformation}
                </p>
            </div>

            <div class="comment">
                <h3>Comment</h3>
                <p>No comments yet. Be the first to leave a review!</p>
            </div>
        </div>

        <script>
            function adjustQty(button) {
                const input = document.getElementById('qtyInput');
                let current = parseInt(input.value);
                let min = parseInt(qtyInput.min);
                let max = parseInt(qtyInput.max);


                if (button.textContent === '-') {
                    if (current > min) {
                        input.value = current - 1;
                    }
                } else {
                    if (current < max) {
                        input.value = current + 1;
                    }
                }
            }
        </script>
    </body>
</html>
