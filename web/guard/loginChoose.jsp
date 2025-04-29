<%@ include file="/header/main_header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login Choose</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-card {
            background-color: white;
            padding: 40px 30px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 90%;
            max-width: 400px;
        }

        .login-card h2 {
            margin-bottom: 30px;
            color: #2c3e50;
        }

        .login-card a {
            text-decoration: none;
        }

        .login-card button {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            margin: 10px 0;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        .login-card button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>

    <div class="login-card">
        <h2>Select Login Type</h2>

        <a href="/galaxy_bookshelf/customer/customerLogin.jsp">
            <button type="button">Member Login</button>
        </a>

        <a href="/galaxy_bookshelf/staff/staffLogin.jsp">
            <button type="button">Staff Login</button>
        </a>
    </div>

</body>
</html>

