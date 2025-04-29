<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Set Title Icon -->
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <style>
            h2 {
                text-align: center;
                margin-top: 40px;
                font-size: 28px;
                color: #2c3e50;
            }

            .report-links {
                max-width: 500px;
                margin: 50px auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .report-links a {
                display: block;
                margin: 15px 0;
                padding: 12px 20px;
                text-decoration: none;
                font-size: 18px;
                color: #ffffff;
                background-color: #3498db;
                border-radius: 8px;
                transition: background-color 0.3s, transform 0.2s;
            }

            .report-links a:hover {
                background-color: #2980b9;
                transform: scale(1.03);
            }
        </style>

        <title>Galaxy | Product Sales Report</title>
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <h2>Report Main Page</h2>

        <div class="report-links">
            <a href="/galaxy_bookshelf/web/report/sales_records.jsp?type=daily">Sales Records - Daily</a>
            <a href="/galaxy_bookshelf/web/report/sales_records.jsp?type=monthly">Sales Records - Monthly</a>
            <a href="/galaxy_bookshelf/web/report/sales_records.jsp?type=yearly">Sales Records - Yearly</a>
            <a href="/galaxy_bookshelf/web/report/report_top10.jsp">Top 10 Products of the Year</a>
        </div>

    </body>
</html>
