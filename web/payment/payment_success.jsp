<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Galaxy | Success</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f9fafb;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            .success-container {
                text-align: center;
                background-color: #ffffff;
                padding: 40px 30px;
                border-radius: 12px;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
                max-width: 500px;
            }

            .success-container i {
                font-size: 60px;
                color: #2ecc71;
                margin-bottom: 20px;
            }

            .success-container h3 {
                color: #2c3e50;
                font-size: 26px;
                margin-bottom: 15px;
            }

            .success-container p {
                color: #7f8c8d;
                font-size: 16px;
                line-height: 1.6;
                margin-bottom: 30px;
            }

            .success-container a {
                display: inline-block;
                padding: 12px 24px;
                background-color: #3498db;
                color: white;
                text-decoration: none;
                font-weight: bold;
                border-radius: 6px;
                transition: background-color 0.3s ease;
            }

            .success-container a:hover {
                background-color: #2980b9;
            }

            @media (max-width: 600px) {
                .success-container {
                    margin: 20px;
                    padding: 30px 20px;
                }

                .success-container h3 {
                    font-size: 22px;
                }

                .success-container p {
                    font-size: 15px;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <div class="success-container">
            <i class="fa-regular fa-circle-check"></i>
            <h3>Payment Successful</h3>
            <p>
                Thank you so much for your purchase!<br>
                If you're happy with your experience, we’d truly appreciate a 5-star review.<br>
                Have a wonderful day!
            </p>
            <a href="/galaxy_bookshelf/web/payment/payment_list.jsp">
                Check My Purchase & Leave a Review
            </a>
        </div>
    </body>
</html>
