<%@ include file="/header/main_header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login Error</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .error-box {
                background-color: white;
                padding: 40px 30px;
                border-radius: 12px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                width: 90%;
                max-width: 400px;
                text-align: center;
            }

            .error-box h2 {
                color: #e74c3c;
                margin-bottom: 20px;
            }

            .error-box p {
                color: #555;
                margin-bottom: 30px;
            }

            .error-box a {
                display: inline-block;
                margin: 10px;
                padding: 10px 20px;
                text-decoration: none;
                color: white;
                background-color: #3498db;
                border-radius: 8px;
                transition: background-color 0.3s ease;
            }

            .error-box a:hover {
                background-color: #2980b9;
            }
        </style>
    </head>
    <body>

        <div class="error-box">
            <h2>Login Failed</h2>
            <p>Invalid Member or Staff credentials. Please try again.</p>

            <a href="/galaxy_bookshelf/customer/customerLogin.jsp">Customer Login</a>
            <a href="/galaxy_bookshelf/staff/staffLogin.jsp">Staff Login</a>
        </div>

    </body>
</html>
