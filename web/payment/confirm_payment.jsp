<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Galaxy | Cart</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <a href="/galaxy_bookshelf/web/customer/list_cart.jsp" >Back to Cart</a>

        <h2>Confirm Your Items</h2>

        <%
               String Customer_id = (String) session.getAttribute("customer_id");
        %>

        <form action="/galaxy_bookshelf/web/payment/process.jsp" method="get">

            <input type="hidden" name="customer_id" value="<%= Customer_id %>">

            <p>${FullName} | (+60) ${PhoneNumber}</p>
            <p>${Address}</p>
            <a href="/galaxy_bookshelf/web/payment/add_edit_address.jsp">Edit Address</a>

            <br><br>

            <table border="1">
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
                        <td>
                            <img src="${item.productPic}" width="100" />
                        </td>
                        <td>${item.productName}</td>
                        <!-- Display Got Discount Or Not -->
                        <td>
                            <c:choose>
                                <c:when test="${item.discountPrice > 0}">
                                    <del style="color: gray;">
                                        RM <fmt:formatNumber value="${item.productPrice}" type="number" minFractionDigits="2" />
                                    </del><br />
                                    <strong style="color: red;">
                                        RM <fmt:formatNumber value="${item.discountPrice}" type="number" minFractionDigits="2" />
                                    </strong>
                                </c:when>
                                <c:otherwise>
                                    RM <fmt:formatNumber value="${item.productPrice}" type="number" minFractionDigits="2" />
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>${item.quantityInCart}</td>
                        <!-- Taking Discount Price, if yes -->
                        <td>
                            <c:choose>
                                <c:when test="${item.discountPrice > 0}">
                                    <fmt:formatNumber value="${item.discountPrice * item.quantityInCart}" type="number" minFractionDigits="2" />
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${item.productPrice * item.quantityInCart}" type="number" minFractionDigits="2" />
                                </c:otherwise>
                            </c:choose>
                        </td>

                    </tr>
                </c:forEach>
                <tr>
                    <td colspan="4"></td>
                    <td>Merchandise Subtotal</td>
                    <td>RM <fmt:formatNumber value="${Subtotal}" type="number" minFractionDigits="2" /></td>
                </tr>
                <tr>
                    <td colspan="4"></td>
                    <td>Shipping Fee</td>
                    <td>RM <fmt:formatNumber value="${ShippingFee}" type="number" minFractionDigits="2" /></td>
                </tr>
                <tr>
                    <td colspan="4"></td>
                    <td>Total Payment</td>
                    <td>RM <fmt:formatNumber value="${Total}" type="number" minFractionDigits="2" /></td>
                </tr>

            </table>

            <br>

            <input type="hidden" name="cart_ids" value="${CartIDs}" />
            <p>Select Payment Method:</p>
            <c:forEach var="pay" items="${PayTypes}">
                <label>
                    <input type="radio" name="pay_type" value="${pay.id}" required />
                    ${pay.name}
                    <br>
                </label>
            </c:forEach>

            <br>

            <button type="submit">Confirm & Pay</button>
        </form>
    </body>
</html>