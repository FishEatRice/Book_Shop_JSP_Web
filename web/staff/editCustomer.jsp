<%-- 
    Document   : editCustomer
    Created on : Apr 14, 2025, 7:09:50 AM
    Author     : yq
--%>
<%@ include file="/header/main_header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
  </head>
<body>

    <h1>Edit Customer Information</h1>

    <div class="form-container">
        <form action="/crudCustomer" method="post">
            <!-- 用于编辑客户的ID -->
            <input type="hidden" name="action" value="edit" />
            <input type="hidden" name="id" value="${customer.id}" />

            <label for="name">Name:</label>
            <input type="text" id="name" name="name" value="${customer.name}" required />

            <br><br><label for="email">Email:</label>
            <input type="email" id="email" name="email" value="${customer.email}" required />

            <br><br><label for="password">Password:</label>
            <input type="password" id="password" name="password" value="${customer.password}" required />

            <br><br><label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" value="${customer.firstName}" required />

           <br><br> <label for="lastName">Last Name:</label>
            <input type="text" id="lastName" name="lastName" value="${customer.lastName}" required />

           <br><br> <label for="contactNo">Contact Number:</label>
            <input type="text" id="contactNo" name="contactNo" value="${customer.contactNo}" required />

            <br><br><label for="addressJalan">Street Address:</label>
            <input type="text" id="addressJalan" name="addressJalan" value="${customer.addressJalan}" required />

            <br><br><label for="addressState">State:</label>
            <input type="text" id="addressState" name="addressState" value="${customer.addressState}" required />

           <br><br> <label for="addressCity">City:</label>
            <input type="text" id="addressCity" name="addressCity" value="${customer.addressCity}" required />

            <br><br><label for="addressCode">Postal Code:</label>
            <input type="text" id="addressCode" name="addressCode" value="${customer.addressCode}" required />

            <br><br><label for="profile">Profile:</label>
            <input type="text" id="profile" name="profile" value="${customer.profile}" />

            <br><br><label for="questionId">Security Question ID:</label>
            <input type="text" id="questionId" name="questionId" value="${customer.questionId}" />

            <br><br><label for="questionAnswer">Security Question Answer:</label>
            <input type="text" id="questionAnswer" name="questionAnswer" value="${customer.questionAnswer}" />

           <br><br> <label for="request">Additional Request:</label>
            <input type="text" id="request" name="request" value="${customer.request}" />

            <input type="submit" value="Save Changes" />
        </form>

        <a href="/galaxy_bookshelf/customer/profile.jsp">Back to Profile</a>
    </div>

</body>
</html>