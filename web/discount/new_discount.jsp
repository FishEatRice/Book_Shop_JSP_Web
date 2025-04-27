<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Galaxy | Discount</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <a href="/galaxy_bookshelf/web/discount/discount_manager.jsp">Back to Discount Manager</a>

        <h1>Create & Edit Discount</h1>

        <c:set var="productId" value="${param.id}" />
        <c:set var="productName" value="${param.name}" />
        <c:set var="originalPrice" value="${param.price}" />
        <c:set var="discountPrice" value="${param.discount}" />

        <form action="/galaxy_bookshelf/CreateDiscountProcess" method="post">
            <input type="hidden" name="productId" value="${productId}" />

            <input type="hidden" name="discountSwitch" value="false" />


            <p>Product Name : ${productName}</p>
            <p>Product Original Price : RM <fmt:formatNumber value="${originalPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>

            <c:if test="${discountPrice != 0.0}">
                <p>Original Discount Price : RM <fmt:formatNumber value="${discountPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
            </c:if>
            <label for="discountPrice">New Discount Price : RM </label>
            <input type="number" id="discountPrice" name="discountPrice" value=<fmt:formatNumber value="${discountPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /> step="0.01" required>

            <br><br>

            <label for="expiredDatetime">Discount Expiry Date & Time:</label><br>
            <input type="datetime-local" id="expiredDatetime" name="expiredDatetime" required>

            <br>

            <p>All discount offer will be set as OFF as default, please visit Discount Manager to ON the discount that you want</p>

            <input type="submit" value="Create Discount">
        </form>
    </body>
</html>
