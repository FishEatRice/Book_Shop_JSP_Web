<%-- 
    Document   : customerForgetPassword
    Created on : 28 Apr 2025, 5:08:19 PM
    Author     : ON YUEN SHERN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Galaxy | Forget Password</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
    </head>
    <script type="text/javascript">
        function validatePassword() {
            var password = document.getElementsByName("password")[0].value;
            var confirmPassword = document.getElementsByName("confirmPassword")[0].value;

            if (password !== confirmPassword) {
                alert("Passwords do not match. Please try again.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <%@ include file="/header/main_header.jsp" %>


    <h3>Forget Password</h3>

    <% 
        String error = (String) session.getAttribute("error");
        if (error != null) { 
    %>
    <p style="color:red;"><%= error %></p>
    <% 
        session.removeAttribute("error"); 
        } 
    %>

    <form method="post" action="/galaxy_bookshelf/reset_password" onsubmit="return validatePassword();">
        <input type="hidden" name="action" value="create" />

        <p><label>Email :</label>
            <input type="text" name="email" size="40" required/></p>
        <p><label>OTP :</label>
            <input type="text" name="otp" size="10" required/>
            <button type="button" onclick="sendOTP()">Get OTP</button></p>
        <p><label>New Password :</label>
            <input type="password" name="password" size="60" required/></p>
        <p><label>Double Confirm Password:</label>
            <input type="password" name="confirmPassword" size="60" required/></p>

        <p><input type="submit" value="Submit" />
            <input type="reset" value="Reset" /></p>
    </form>

    <script type="text/javascript">
        function sendOTP() {
            var email = document.getElementsByName("email")[0].value;

            if (!email) {
                alert("Please enter your email first.");
                return;
            }

            // Send request to server
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "/galaxy_bookshelf/sendOTP", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        alert(xhr.responseText); // Server returns success/failure message
                    } else {
                        alert("Failed to send OTP. Please try again.");
                    }
                }
            };
            xhr.send("email=" + encodeURIComponent(email));
        }
    </script>
</body>
</html>
