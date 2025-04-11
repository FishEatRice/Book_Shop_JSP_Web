<%-- 
    Document   : registerMember
    Created on : Apr 11, 2025, 8:03:37 AM
    Author     : yq
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Register Member</title>
    </head>
    <body>
        <h3>Register Now</h3>
        <form method="post" action="p" >

            <p><label>Name :</label>
                <input type="text" name="name" size="40" /></p>
             <p><label>Email :</label>
                <input type="text" name="email" size="40" /></p>
            <p><label>Password :</label>
                <input type="text" name="password" size="60" /></p>
            <p><label>Double Confirm Password:</label>
                <input type="text" name="password2" size="60" /></p>

            <p><input type="submit" value="Submit" />
                <input type="reset" value="Reset" /></p>
            a
        </form>

    </body>
</html>
