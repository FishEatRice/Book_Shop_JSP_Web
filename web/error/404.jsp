<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>404 Not Found</title>
    </head>
    <body>

        <h1>404 Not Found</h1>
        <p>Oops! Looks like this page doesn't exist.</p>
        <p>Please go <a href="<%= request.getContextPath() %>">Back to Main Page.</a></p>
    
    </body>
</html>
