<%-- 
    Document   : staffLogin
    Created on : Apr 11, 2025, 8:05:13 AM
    Author     : yq
--%>

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
        <title>Staff Login</title>
        <meta charset="UTF-8">
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .login-container {
                background-color: #ffffff;
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                max-width: 400px;
                width: 100%;
            }

            h2 {
                text-align: center;
                margin-bottom: 30px;
                color: #333;
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                color: #333;
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 6px;
            }

            button[type="submit"] {
                width: 100%;
                padding: 12px;
                background-color: #3498db;
                color: white;
                border: none;
                border-radius: 6px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            button[type="submit"]:hover {
                background-color: #2980b9;
            }
        </style>
    </head>
    <body>

        <div class="login-container">
            <h2>Staff Login</h2>
            <form action="../AdminLoginFunction" method="POST">
                <label for="staff_id">Staff ID:</label>
                <input type="text" id="staff_id" name="staff_id" required />

                <label for="staff_password">Password:</label>
                <input type="password" id="staff_password" name="staff_password" required />

                <button type="submit">Login</button>
            </form>
        </div>

    </body>
</html>
