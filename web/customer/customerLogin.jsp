<%@ include file="/header/main_header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String role = (String) session.getAttribute("userRole");

    if (role != null) {
        response.sendRedirect(request.getContextPath() + "/web/index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Member Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .login-box {
                background-color: white;
                padding: 40px 30px;
                border-radius: 12px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                width: 90%;
                max-width: 400px;
            }

            .login-box h2 {
                text-align: center;
                margin-bottom: 25px;
                color: #2c3e50;
            }

            .login-box label {
                display: block;
                margin-bottom: 8px;
                color: #333;
            }

            .login-box input[type="text"],
            .login-box input[type="password"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border-radius: 8px;
                border: 1px solid #ccc;
                box-sizing: border-box;
            }

            .login-box button {
                width: 100%;
                padding: 12px;
                background-color: #3498db;
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .login-box button:hover {
                background-color: #2980b9;
            }

            .login-box .links {
                text-align: center;
                margin-top: 20px;
            }

            .login-box .links a {
                text-decoration: none;
                color: #3498db;
                margin: 0 10px;
                font-size: 14px;
            }

            .login-box .links a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>

        <div class="login-box">
            <h2>Member Login</h2>
            <form action="../CustomerLoginFunction" method="POST">
                <label for="customer_email">Email</label>
                <input type="text" id="customer_email" name="customer_email" required>

                <label for="customer_password">Password</label>
                <input type="password" id="customer_password" name="customer_password" required>

                <button type="submit">Login</button>
            </form>

            <div class="links">
                <a href="/galaxy_bookshelf/customer/customerForgetPassword.jsp">Forgot Password?</a> |
                <a href="/galaxy_bookshelf/customer/registerMember.jsp">Register</a>
            </div>
        </div>

    </body>
</html>
