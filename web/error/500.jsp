<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>500 Internel Server Error</title>
    </head>
    <body>
        <h1>500 Internel Server Error</h1>
        <p>Oops! Looks like something went wrong</p>
        <p>If the problem persists, please contact the system administrator.</p>
        <p>Please go <a href="<%= request.getContextPath() %>">Back to Main Page.</a></p>
    </body>
</html>
