<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Galaxy | Discount</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <h2>Discount Product</h2>
        
        <a href="/galaxy_bookshelf/discount/add_new_discount.jsp">Create new discount</a>

        <c:choose>
            <c:when test="${not empty Discount}">
                <table border="1">
                    <tr>
                        <th colspan="2">Product Name</th>
                        <th>Original Price</th>
                        <th>Discount Price</th>
                        <th>Expired Date</th>
                        <th>Switch</th>
                        <th>Action</th>
                    </tr>

                    <c:forEach var="item" items="${Discount}">
                        <tr>
                            <td><img src="${item.productPic}" alt="${item.productName}" width="100" /></td>
                            <td>${item.productName}</td>
                            <td>RM <fmt:formatNumber value="${item.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
                            <td>RM <fmt:formatNumber value="${item.discountPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
                            <td>${item.expiredDatetime}</td>
                            <td>
                                <button type="button">
                                    <c:choose>
                                        <c:when test="${item.discountSwitch}">ON</c:when>
                                        <c:otherwise>OFF</c:otherwise>
                                    </c:choose>
                                </button>
                            </td>
                            <td>
                                <button type="button" onclick="#">Edit</button> | 
                                <button type="button" onclick="#">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:when>

            <c:otherwise>
                <p>No discount products available.</p>
            </c:otherwise>
        </c:choose>

    </body>
</html>
