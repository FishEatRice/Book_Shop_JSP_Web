<%-- 
    Document   : createStaff
    Created on : Apr 11, 2025, 10:28:51 PM
    Author     : yq
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Staff Page</title>

    </head>
    <body>

        <h3>Create staff Now</h3>
        <form method="post" action="../crudStaff">
             <input type="hidden" name="action" value="create"> 


            <p><label>First Name :</label>
                <input type="text" name="firstName" size="40" /></p>
            <p><label>Last Name  :</label>
                <input type="text" name="lastName" size="40" /></p>


            <p>Create<input type="submit" value="Submit" /><br>
                <input type="reset" value="Reset" /></p>
            a
        </form>
    </body>
</html>
