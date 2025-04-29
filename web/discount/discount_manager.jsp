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

        <h2>Discount Manager</h2>

        <a href="/galaxy_bookshelf/web/discount/add_discount_product.jsp">Create & Edit New Discount</a>

        <br><br>

        <c:choose>
            <c:when test="${not empty Discount}">
                <table border="1">
                    <tr>
                        <th colspan="2">Product Name</th>
                        <th>Original Price</th>
                        <th>Discount Price</th>
                        <th>Expired Date</th>
                        <th>Details</th>
                        <th>Switch</th>
                        <th>Action</th>
                    </tr>

                    <c:forEach var="item" items="${Discount}">
                        <tr>
                            <td><img src="${item.productPic}" alt="${item.productName}" width="100" /></td>
                            <td>${item.productName}</td>
                            <td>RM <fmt:formatNumber value="${item.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
                            <td>RM <fmt:formatNumber value="${item.discountPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
                            <td><fmt:formatDate value="${item.expiredDatetime}" pattern="dd-MM-yyyy HH:mm:ss" /></td>
                            <td>${item.details}</td>
                            <td>
                                <button type="button" onclick="DiscountSwitch('${item.discountId}')">
                                    <c:choose>
                                        <c:when test="${item.discountSwitch}">ON</c:when>
                                        <c:otherwise>OFF</c:otherwise>
                                    </c:choose>
                                </button>
                            </td>
                            <td>
                                <button type="button" onclick="DeleteDiscount('${item.discountId}')">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:when>

            <c:otherwise>
                <p>No discount products available.</p>
            </c:otherwise>
        </c:choose>

        <script>
            function DiscountSwitch(discountId) {
                window.location.href = '/galaxy_bookshelf/discountSwitch?discount_id=' + discountId;
            }

            function DeleteDiscount(discountId) {
                if (confirm("Are you sure you want to delete this discount?")) {
                    window.location.href = '/galaxy_bookshelf/DeleteDiscount?discount_id=' + discountId;
                }
            }
        </script>
    </body>
</html>
