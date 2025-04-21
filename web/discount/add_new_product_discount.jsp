<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.discount.NewDiscountDisplay" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Galaxy | Discount</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />
    </head>
    <body>
        <h1>Add New Product Discount</h1>

        <table border="1" cellpadding="5">
            <tr>
                <th>No.</th>
                <th>Name</th>
                <th>Image</th>
                <th>Original Price</th>
                <th>Discount Price</th>
                <th>Actions</th>
            </tr>

            <c:if test="${not empty productDiscountInfoList}">
                <c:forEach var="item" items="${productDiscountInfoList}">
                    <tr>
                        <td><c:out value="${item.productId}" /></td>
                        <td><c:out value="${item.productName}" /></td>
                        <td><img src="${item.productPic}" alt="${item.productName}" width="100" /></td>
                        <td>RM <fmt:formatNumber value="${item.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
                        <td>
                            <c:if test="${item.discountStatus}">
                                <i class="fa-solid fa-tag" style="color: green;"></i> RM <fmt:formatNumber value="${item.discountPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                            </c:if>
                            <c:if test="${!item.discountStatus}">
                                <i class="fa-solid fa-tag" style="color: red;"></i> No Discount
                            </c:if>
                        </td>
                        <td>
                            <a href="/galaxy_bookshelf/discount/new_discount.jsp?id=${item.productId}&name=${item.productName}&price=${item.productPrice}&discount=${item.discountPrice}">
                                Create & Edit Discount for this product
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </c:if>

            <c:if test="${empty productDiscountInfoList}">
                <tr>
                    <td colspan="6">No products found.</td>
                </tr>
            </c:if>
        </table>
    </body>
</html>
