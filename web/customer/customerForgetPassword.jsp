<%-- 
    Document   : customerForgetPassword
    Created on : 28 Apr 2025, 5:08:19 PM
    Author     : ON YUEN SHERN
--%>

<%@ include file="/header/main_header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Register Member</title>
        <script type="text/javascript">
            // JavaScript 函数，用来验证密码一致性
            function validatePassword() {
                var password = document.getElementsByName("password")[0].value;
                var confirmPassword = document.getElementsByName("confirmPassword")[0].value;

                // 如果密码不一致
                if (password !== confirmPassword) {
                    alert("Passwords do not match. Please try again.");
                    return false;  // 阻止表单提交
                }
                return true;  // 密码一致，允许提交
            }
        </script>
    </head>
    <body>



        <h3>Register Now</h3>

        <% 
            String error = (String) session.getAttribute("error");
            if (error != null) { 
        %>
        <p style="color:red;"><%= error %></p>
        <% 
            session.removeAttribute("error");  // 清除错误信息，只显示一次
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
