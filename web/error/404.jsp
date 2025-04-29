<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Galaxy | 404</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />

        <style>
            header {
                margin-bottom: 40px;
            }

            /* Title */
            h1 {
                font-size: 72px;
                margin: 0;
                color: #e74c3c;
            }

            /* Message */
            p {
                font-size: 18px;
                margin: 10px 0;
            }

            /* Link Styling */
            back-btn {
                color: #3498db;
                text-decoration: none;
                font-weight: bold;
                transition: color 0.3s;
            }

            back-btn:hover {
                color: #1d6fa5;
            }

            /* Responsive Typography */
            @media (max-width: 600px) {
                h1 {
                    font-size: 48px;
                }

                p {
                    font-size: 16px;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <h1>404 Not Found</h1>
        <p>Oops! Looks like this page doesn't exist.</p>
        <p>Please go <a class='back-btn' href="<%= request.getContextPath() %>">Back to Main Page.</a></p>

    </body>
</html>
