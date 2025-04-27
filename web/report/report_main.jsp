<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Set Title Icon -->
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <title>Galaxy | Product Sales Report</title>
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <h2>Report Main Page</h2>

        <a href="/galaxy_bookshelf/web/report/sales_records.jsp?type=daily">Sales Records - Daily</a>

        <br>

        <a href="/galaxy_bookshelf/web/report/sales_records.jsp?type=monthly">Sales Records - Monthly</a>

        <br>

        <a href="/galaxy_bookshelf/web/report/sales_records.jsp?type=yearly">Sales Records - Yearly</a>

        <br>

        <a href="/galaxy_bookshelf/web/report/report_top10.jsp">Top 10 Products of the Year</a>
    </body>
</html>
