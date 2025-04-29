<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Galaxy | Cart</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <style>

            h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 30px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            th, td {
                padding: 15px;
                text-align: center;
                border-bottom: 1px solid #ddd;
                vertical-align: middle;
            }

            th {
                background-color: #3498db;
                color: white;
            }

            img {
                width: 80px;
                border-radius: 4px;
            }

            form {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 5px;
            }

            input[type="number"] {
                width: 60px;
                padding: 5px;
                border-radius: 4px;
                border: 1px solid #ccc;
            }

            button {
                padding: 8px 14px;
                background-color: #3498db;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            button:hover {
                background-color: #2980b9;
            }

            .price-old {
                text-decoration: line-through;
                color: gray;
                font-size: 0.9em;
            }

            .price-new {
                color: red;
                font-weight: bold;
            }

            .action-buttons {
                text-align: left;
                margin-top: 20px;
            }

            .empty-cart {
                text-align: center;
                margin-top: 50px;
            }

            .empty-cart button {
                margin-top: 15px;
            }

            @media screen and (max-width: 768px) {
                table, thead, tbody, th, td, tr {
                    display: block;
                }

                th {
                    display: none;
                }

                td {
                    padding: 10px;
                    border: none;
                    border-bottom: 1px solid #ccc;
                    text-align: left;
                }

                td:before {
                    content: attr(data-label);
                    font-weight: bold;
                    display: block;
                    margin-bottom: 5px;
                }
            }
        </style>
    </head>
    <body>
        <c:if test="${not empty sessionScope.stockError}">
            <script>
                alert("${sessionScope.stockError}");
            </script>
            <c:remove var="stockError" scope="session" />
        </c:if>
            
        <%@ include file="/header/main_header.jsp" %>

        <h2>Cart List</h2>

        <c:choose>
            <c:when test="${not empty Cart_Item}">
                <table>
                    <tr>
                        <th><input type="checkbox" id="selectAll" onclick="SelectAllCart(this)" /></th>
                        <th colspan="2">Product</th>
                        <th>Unit Price</th>
                        <th>Quantity</th>
                        <th>Total Price</th>
                        <th>Action</th>
                    </tr>

                    <c:forEach var="item" items="${Cart_Item}">
                        <tr>
                            <td>
                                <input type="checkbox" name="selectedItems" value="${item.cartId}" class="itemCheckbox" />
                            </td>
                            <td><img src="${item.productPic}" alt="${item.productName}" /></td>
                            <td>${item.productName}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${item.discountPrice != 0.0}">
                                        <div class="price-old">
                                            RM <fmt:formatNumber value="${item.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                        </div>
                                        <div class="price-new">
                                            RM <fmt:formatNumber value="${item.discountPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        RM <fmt:formatNumber value="${item.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>
                                <small>Stock: ${item.quantityInStock}</small><br>
                                <form action="/galaxy_bookshelf/CartQuantityChangeProcess" method="get">
                                    <input type="hidden" name="cart_id" value="${item.cartId}">
                                    <input type="number" name="quantity" value="${item.quantityInCart}" max="${item.quantityInStock}" min="1" required>
                                    <button type="submit">Update</button>
                                </form>
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${item.discountPrice > 0}">
                                        RM <fmt:formatNumber value="${item.discountPrice * item.quantityInCart}" type="number" minFractionDigits="2" />
                                    </c:when>
                                    <c:otherwise>
                                        RM <fmt:formatNumber value="${item.productPrice * item.quantityInCart}" type="number" minFractionDigits="2" />
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>
                                <button type="button" onclick="DeleteCart('${item.cartId}')">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>

                <div class="action-buttons">
                    <button type="button" onclick="document.getElementById('selectAll').click()">Select All</button>
                    <button type="button" onclick="PaySelected()">Pay Selected</button>
                </div>
            </c:when>

            <c:otherwise>
                <div class="empty-cart">
                    <p>Your cart is currently empty.</p>
                    <a href="/galaxy_bookshelf/web/product/clientProductListing.jsp">
                        <button>Browse Products</button>
                    </a>
                </div>
            </c:otherwise>
        </c:choose>

        <script>
            function SelectAllCart(source) {
                const checkboxes = document.querySelectorAll('.itemCheckbox');
                checkboxes.forEach(cb => cb.checked = source.checked);
            }

            function DeleteCart(cartId) {
                if (confirm("Are you sure you want to delete this item?")) {
                    window.location.href = '/galaxy_bookshelf/delete_cart?cart_id=' + cartId;
                }
            }

            function PaySelected() {
                const selected = Array.from(document.querySelectorAll('.itemCheckbox'))
                        .filter(cb => cb.checked)
                        .map(cb => cb.value);

                if (selected.length === 0) {
                    alert("Please select at least one item.");
                    return;
                }

                window.location.href = '/galaxy_bookshelf/web/payment/confirm_payment.jsp?cart_ids=' + encodeURIComponent(selected.join(','));
            }

            document.addEventListener('DOMContentLoaded', () => {
                const selectAllCheckbox = document.getElementById('selectAll');
                const itemCheckboxes = document.querySelectorAll('.itemCheckbox');

                itemCheckboxes.forEach(cb => {
                    cb.addEventListener('change', () => {
                        selectAllCheckbox.checked = Array.from(itemCheckboxes).every(box => box.checked);
                    });
                });
            });
        </script>

    </body>
</html>
