<%-- 
    Document   : add_edit_address
    Created on : 24 Apr 2025, 5:55:40 PM
    Author     : ON YUEN SHERN
--%>
<%@ page import="model.payment.PaymentAddress" %>
<%@ page import="model.payment.ShippingState" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Galaxy | Payment Address</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <a href="#" onclick="confirmBack(event);">Back without save</a>

        <h1>Customer Address Details</h1>

        <form id="addressForm" action="/galaxy_bookshelf/address_process" method="POST">
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" value="${PaymentAddress.firstName}" /><br><br>

            <label for="lastName">Last Name:</label>
            <input type="text" id="lastName" name="lastName" value="${PaymentAddress.lastName}" /><br><br>

            <label for="contactNo">Contact No:</label>
            <input type="text" id="contactNo" name="contactNo" value="${PaymentAddress.contactNo}" /><br>

            <h2>Address</h2>

            <label for="addressNo">Address No:</label>
            <input type="text" id="addressNo" name="addressNo" value="${PaymentAddress.addressNo}" /><br><br>

            <label for="addressJalan">Address Jalan:</label>
            <input type="text" id="addressJalan" name="addressJalan" value="${PaymentAddress.addressJalan}" /><br><br>

            <label for="addressCity">City:</label>
            <input type="text" id="addressCity" name="addressCity" value="${PaymentAddress.addressCity}" /><br><br>

            <label for="addressCode">Postal Code:</label>
            <input type="text" id="addressCode" name="addressCode" value="${PaymentAddress.addressCode}" /><br><br>

            <label for="addressState">State:</label>
            <select id="addressState" name="addressState">
                <c:forEach var="state" items="${shippingStates}">
                    <option value="${state.stateId}" ${state.stateId == PaymentAddress.addressState ? 'selected' : ''}>
                        ${state.stateName}
                    </option>
                </c:forEach>
            </select><br><br>

            <input type="submit" value="Submit" />
        </form>

        <script>
            function confirmBack(event) {
                if (confirm("Are you sure you want to go back without saving?")) {
                    history.back();
                }
            }
        </script>

    </body>
</html>