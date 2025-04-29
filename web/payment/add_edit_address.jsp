<%@ page import="model.payment.PaymentAddress" %>
<%@ page import="model.payment.ShippingState" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Galaxy | Payment Address</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <style>
            h1 {
                text-align: center;
                color: #34495e;
            }

            p {
                text-align: center;
                margin-bottom: 30px;
                color: #7f8c8d;
            }

            a {
                display: inline-block;
                margin-bottom: 20px;
                color: #3498db;
                text-decoration: none;
            }

            form {
                max-width: 600px;
                margin: auto;
                background-color: #ffffff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            }

            label {
                display: block;
                margin-top: 15px;
                font-weight: bold;
            }

            input[type="text"],
            select {
                width: 95%;
                padding: 10px 12px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
                transition: border-color 0.3s ease;
            }

            select {
                width: 100%;
            }


            input[type="text"]:focus,
            select:focus {
                border-color: #3498db;
                outline: none;
            }

            input[type="submit"] {
                margin-top: 25px;
                width: 100%;
                padding: 12px;
                background-color: #3498db;
                color: #fff;
                font-size: 16px;
                font-weight: bold;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            input[type="submit"]:hover {
                background-color: #2980b9;
            }

            h2 {
                margin-top: 30px;
                border-bottom: 1px solid #ecf0f1;
                padding-bottom: 5px;
                color: #2c3e50;
            }

            @media (max-width: 600px) {
                body {
                    padding: 15px;
                }

                form {
                    padding: 20px;
                }

                h1, p {
                    font-size: 18px;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <h1>Customer Address Details</h1>
        <p>Please make sure your address is entered correctly before making payment.</p>

        <form id="addressForm" action="/galaxy_bookshelf/address_process" method="POST">
            <a href="#" onclick="confirmBack(event);">← Back without save</a>

            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" value="${PaymentAddress.firstName}" required />

            <label for="lastName">Last Name:</label>
            <input type="text" id="lastName" name="lastName" value="${PaymentAddress.lastName}" required />

            <label for="contactNo">Contact No:</label>
            <input type="text" id="contactNo" name="contactNo" value="${PaymentAddress.contactNo}" required />

            <h2>Address</h2>

            <label for="addressNo">Address No:</label>
            <input type="text" id="addressNo" name="addressNo" value="${PaymentAddress.addressNo}" required />

            <label for="addressJalan">Address Jalan:</label>
            <input type="text" id="addressJalan" name="addressJalan" value="${PaymentAddress.addressJalan}" required />

            <label for="addressCity">City:</label>
            <input type="text" id="addressCity" name="addressCity" value="${PaymentAddress.addressCity}" required />

            <label for="addressCode">Postal Code:</label>
            <input type="text" id="addressCode" name="addressCode" value="${PaymentAddress.addressCode}" required />

            <label for="addressState">State:</label>
            <select id="addressState" name="addressState" required>
                <c:forEach var="state" items="${shippingStates}">
                    <option value="${state.stateId}" ${state.stateId == PaymentAddress.addressState ? 'selected' : ''}>
                        ${state.stateName} | RM <fmt:formatNumber value="${state.fee}" type="number" minFractionDigits="2" />
                    </option>
                </c:forEach>
            </select>

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
