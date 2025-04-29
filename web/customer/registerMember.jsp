<%@ include file="/header/main_header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Galaxy | Forget Password</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />

        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .register-box {
                background-color: white;
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 500px;
            }

            h3 {
                text-align: center;
                margin-bottom: 30px;
                color: #333;
            }

            label {
                display: block;
                margin-bottom: 5px;
                color: #333;
                font-weight: bold;
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border-radius: 6px;
                border: 1px solid #ccc;
            }

            .otp-section {
                display: flex;
                gap: 10px;
            }

            button,
            input[type="submit"],
            input[type="reset"] {
                padding: 10px 20px;
                border: none;
                border-radius: 6px;
                width: 200px;
                background-color: #3498db;
                color: white;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            button:hover,
            input[type="submit"]:hover,
            input[type="reset"]:hover {
                background-color: #2980b9;
            }

            .error-message {
                color: red;
                text-align: center;
                margin-bottom: 20px;
            }

            .otp-button {
                width: 200px;
                height: 39px;
            }

            .back-link {
                display: inline-block;
                margin-bottom: 20px;
                text-decoration: none;
                color: #3498db;
                font-weight: bold;
            }
        </style>

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

            function sendOTP() {
                var email = document.getElementsByName("email")[0].value;

                if (!email) {
                    alert("Please enter your email first.");
                    return;
                }

                var xhr = new XMLHttpRequest();
                xhr.open("POST", "/galaxy_bookshelf/sendOTP", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            alert(xhr.responseText);
                        } else {
                            alert("Failed to send OTP. Please try again.");
                        }
                    }
                };
                xhr.send("email=" + encodeURIComponent(email));
            }
        </script>
    </head>
    <body>

        <div class="register-box">
            <a href="/galaxy_bookshelf/customer/customerLogin.jsp" class="back-link">← Back to Customer Login</a>

            <h3>Register Now</h3>

            <% 
                String error = (String) session.getAttribute("error");
                if (error != null) { 
            %>
            <div class="error-message"><%= error %></div>
            <%
                    session.removeAttribute("error");
                }
            %>

            <form method="post" action="../crudCustomer" onsubmit="return validatePassword();">
                <input type="hidden" name="action" value="create" />

                <label for="name">Name:</label>
                <input type="text" name="name" required/>

                <label for="email">Email:</label>
                <input type="text" name="email" required/>

                <label for="otp">OTP:</label>
                <div class="otp-section">
                    <input type="text" name="otp" required/>
                    <button type="button" class="otp-button" onclick="sendOTP()">Get OTP</button>
                </div>

                <label for="password">Password:</label>
                <input type="password" name="password" required/>

                <label for="confirmPassword">Double Confirm Password:</label>
                <input type="password" name="confirmPassword" required/>

                <div style="text-align: center; margin-top: 20px;">
                    <input type="submit" value="Register" style="margin-right: 10px;" />
                    <input type="reset" value="Reset" />
                </div>
            </form>
        </div>

    </body>
</html>
