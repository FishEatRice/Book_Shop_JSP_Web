<%-- 
    Document   : CustomerLogin
    Created on : Apr 11, 2025, 8:02:18 AM
    Author     : yq
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Member Login</title>
</head>
<body>
    <h2>Login</h2>
    <form action="../CustomerLoginFunction" method="POST">
        <label for="customer_id">Member ID:</label>
        <input type="text" id="customer_id" name="customer_id" required/><br><br>

        <label for="customer_password">Password:</label>
        <input type="password" id="staff_password" name="customer_password" required/><br><br>

        <button type="submit">Login</button>
    </form>
    <a href="#"> Forget Password</a> <br>
    <a href="../customer/registerMember.jsp"> Register</a> <br>

</body>
</html>