<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Galaxy | Payment</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <style>
            h2 {
                text-align: center;
                margin-bottom: 30px;
            }

            a {
                color: #3498db;
                text-decoration: none;
                margin-bottom: 20px;
                display: inline-block;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                margin-top: 20px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            }

            th, td {
                padding: 12px 16px;
                border-bottom: 1px solid #e0e0e0;
                text-align: center;
            }

            th {
                background-color: #3498db;
                color: #fff;
            }

            td img {
                width: 80px;
                border-radius: 4px;
            }

            del {
                color: gray;
                font-size: 0.9em;
            }

            .info-section {
                margin-top: 20px;
                background-color: #ffffff;
                padding: 15px 20px;
                border-left: 4px solid #3498db;
                box-shadow: 0 1px 4px rgba(0,0,0,0.1);
            }

            .info-section p {
                margin: 4px 0;
            }

            .info-section a {
                margin-top: 10px;
                display: inline-block;
            }

            .total-row td {
                font-weight: bold;
                background-color: #f2f2f2;
            }

            .payment-methods {
                margin-top: 30px;
            }

            .payment-methods label {
                display: block;
                margin: 10px 0;
            }

            button {
                display: block;
                margin: 30px auto 0;
                padding: 12px 25px;
                background-color: #3498db;
                color: #fff;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: #2980b9;
            }

            @media screen and (max-width: 768px) {
                table, thead, tbody, th, td, tr {
                    display: block;
                }

                th {
                    display: none;
                }

                td {
                    text-align: left;
                    padding: 10px;
                    border: none;
                    border-bottom: 1px solid #ccc;
                }

                td:before {
                    content: attr(data-label);
                    font-weight: bold;
                    display: block;
                }

                td img {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <a href="/galaxy_bookshelf/web/customer/list_cart.jsp">← Back to Cart</a>

        <h2>Confirm Your Items</h2>

        <%
            String Customer_id = (String) session.getAttribute("customer_id");
        %>

        <form action="/galaxy_bookshelf/web/payment/process.jsp" method="get">

            <input type="hidden" name="customer_id" value="<%= Customer_id %>">

            <div class="info-section">
                <p><strong>${FullName}</strong> | (+60) ${PhoneNumber}</p>
                <p>${Address}</p>
                <a href="/galaxy_bookshelf/web/payment/add_edit_address.jsp">Edit Address</a>
            </div>

            <table>
                <tr>
                    <th>No.</th>
                    <th colspan="2">Product</th>
                    <th>Unit Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                </tr>
                <% int no = 1; %>
                <c:forEach var="item" items="${SelectedItems}">
                    <tr>
                        <td><%= no++ %></td>
                        <td><img src="${item.productPic}" alt="${item.productName}" /></td>
                        <td>${item.productName}</td>

                        <td>
                            <c:choose>
                                <c:when test="${item.discountPrice > 0}">
                                    <del>RM <fmt:formatNumber value="${item.productPrice}" type="number" minFractionDigits="2" /></del><br />
                                    <strong>RM <fmt:formatNumber value="${item.discountPrice}" type="number" minFractionDigits="2" /></strong>
                                </c:when>
                                <c:otherwise>
                                    RM <fmt:formatNumber value="${item.productPrice}" type="number" minFractionDigits="2" />
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>${item.quantityInCart}</td>
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
                    </tr>
                </c:forEach>

                <tr class="total-row">
                    <td colspan="4"></td>
                    <td>Merchandise Subtotal</td>
                    <td>RM <fmt:formatNumber value="${Subtotal}" type="number" minFractionDigits="2" /></td>
                </tr>
                <tr class="total-row">
                    <td colspan="4"></td>
                    <td>Shipping Fee</td>
                    <td>RM <fmt:formatNumber value="${ShippingFee}" type="number" minFractionDigits="2" /></td>
                </tr>
                <tr class="total-row">
                    <td colspan="4"></td>
                    <td>Total Payment</td>
                    <td>RM <fmt:formatNumber value="${Total}" type="number" minFractionDigits="2" /></td>
                </tr>
            </table>

            <input type="hidden" name="cart_ids" value="${CartIDs}" />

            <div class="payment-methods">
                <p><strong>Select Payment Method:</strong></p>
                <c:forEach var="pay" items="${PayTypes}">
                    <label>
                        <input type="radio" name="pay_type" value="${pay.id}" required />
                        ${pay.name}
                    </label>
                </c:forEach>
            </div>

            <button type="submit">Confirm & Pay</button>
        </form>

    </body>
</html>
