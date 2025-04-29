<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.product.Product" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Galaxy BookShelf | Product Details</title>

        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />

        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f4f6f9;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 1000px;
                margin: auto;
                padding: 40px 20px;
                background-color: white;
                border-radius: 12px;
                box-shadow: 0 0 10px rgba(0,0,0,0.05);
            }

            .back-link {
                display: inline-block;
                margin-bottom: 20px;
                text-decoration: none;
                color: #3498db;
                font-weight: bold;
            }

            .product-section {
                display: flex;
                flex-wrap: wrap;
                gap: 40px;
            }

            .product-image img {
                width: 300px;
                height: 300px;
                object-fit: cover;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .product-info {
                flex: 1;
            }

            .product-name {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 10px;
                color: #2c3e50;
            }

            .product-price {
                font-size: 20px;
                margin-bottom: 10px;
            }

            .product-price span {
                margin-right: 10px;
            }

            .product-price .original {
                text-decoration: line-through;
                color: gray;
            }

            .product-price .discount {
                color: red;
                font-weight: bold;
            }

            .stock {
                margin-bottom: 15px;
                font-size: 16px;
            }

            .quantity-box {
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .quantity-box button {
                padding: 6px 12px;
                font-size: 16px;
                background-color: #ccc;
                border: none;
                border-radius: 6px;
                cursor: pointer;
            }

            .quantity-box input {
                width: 60px;
                padding: 6px;
                text-align: center;
                border: 1px solid #ccc;
                border-radius: 6px;
            }

            .add-to-cart {
                padding: 10px 18px;
                background-color: #27ae60;
                color: white;
                font-size: 16px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
            }

            .add-to-cart:hover {
                background-color: #219150;
            }

            .details, .comment {
                margin-top: 40px;
            }

            .details h3,
            .comment h3 {
                margin-bottom: 10px;
                font-size: 20px;
                color: #2c3e50;
            }

            .details p {
                line-height: 1.6;
                color: #555;
            }

            .comment-item {
                background-color: #f9f9f9;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 15px;
                box-shadow: 0 1px 4px rgba(0,0,0,0.05);
            }

            .reply-text {
                margin-top: 8px;
                color: #555;
                font-style: italic;
            }

            p.no-comments {
                font-style: italic;
                color: #888;
            }

            input::-webkit-outer-spin-button,
            input::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }

            /* Firefox */
            input[type=number] {
                -moz-appearance: textfield;
            }
        </style>
    </head>
    <body>

        <%@ include file="/header/main_header.jsp" %>

        <div class="container">
            <a href="clientProductListing.jsp" class="back-link">← Back to Products</a>

            <div class="product-section">
                <div class="product-image">
                    <img src="${productData.productPicture}" alt="${productData.productName}" />
                </div>

                <div class="product-info">
                    <div class="product-name">${productData.productName}</div>

                    <c:choose>
                        <c:when test="${productData.discountPrice != 0.0}">
                            <div class="product-price">
                                <span class="discount">
                                    RM <fmt:formatNumber value="${productData.discountPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                </span>
                                <span class="original">
                                    RM <fmt:formatNumber value="${productData.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                </span>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="product-price">
                                <span class="discount">
                                    RM <fmt:formatNumber value="${productData.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                </span>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <form method="post" action="<%= request.getContextPath() %>/add_to_cart_process">
                        <input type="hidden" name="product_id" value="${productData.productId}" />
                        <p>Genre: <strong>${productData.genreId.genreName}</strong></p>

                        <div class="stock">Stock Quantity: <strong>${productData.quantity}</strong></div>

                        <div class="quantity-box">
                            Quantity:
                            <button type="button" onclick="adjustQty(this)">-</button>
                            <input type="number" name="quantity" id="qtyInput" value="1" min="1" max="${productData.quantity}" />
                            <button type="button" onclick="adjustQty(this)">+</button>
                        </div>

                        <button type="submit" class="add-to-cart">Add to Cart</button>
                    </form>
                </div>
            </div>

            <div class="details">
                <h3>Details</h3>
                <p>${productData.productInformation}</p>
            </div>

            <div class="comment">
                <h3>Comments</h3>

                <c:choose>
                    <c:when test="${not empty comments}">
                        <c:forEach var="comment" items="${comments}">
                            <div class="comment-item">
                                <div class="rating">
                                    <c:forEach var="i" begin="1" end="5">
                                        <c:choose>
                                            <c:when test="${i <= comment.ratingStar}">
                                                <i class="fa-solid fa-star" style="color: orange;"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fa-solid fa-star" style="color: #ccc;"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    (${comment.ratingStar} Stars)
                                </div>
                                <c:if test="${not empty comment.comment and comment.comment != '<p><br></p>'}">
                                    <div>${comment.comment}</div>
                                </c:if>
                                <c:if test="${not empty comment.reply and comment.reply != 'ignore'}">
                                    <div class="reply-text">${comment.reply} [Reply by Staff]</div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="no-comments">No comments yet. Be the first to leave a review!</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <script>
            function adjustQty(button) {
                const input = document.getElementById('qtyInput');
                let current = parseInt(input.value);
                let min = parseInt(input.min);
                let max = parseInt(input.max);

                if (button.textContent === '-') {
                    if (current > min)
                        input.value = current - 1;
                } else {
                    if (current < max)
                        input.value = current + 1;
                }
            }
        </script>

    </body>
</html>
