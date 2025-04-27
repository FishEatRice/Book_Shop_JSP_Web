<%-- 
    Document   : registerMember
    Created on : Apr 11, 2025, 8:03:37 AM
    Author     : yq
--%>
<%@ include file="/header/main_header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Register Member</title>
        <script type="text/javascript">
            // JavaScript 函数，用来验证密码一致性
            function validatePassword() {
                var password = document.getElementsByName("password")[0].value;
                var confirmPassword = document.getElementsByName("confirmPassword")[0].value;

                // 如果密码不一致
                if (password !== confirmPassword) {
                    alert("Passwords do not match. Please try again.");
                    return false;  // 阻止表单提交
                }
                return true;  // 密码一致，允许提交
            }
        </script>
    </head>
    <body>



        <h3>Register Now</h3>
        <form method="post" action="../crudCustomer" onsubmit="return validatePassword();">
            <input type="hidden" name="action" value="create" />

            <p><label>Name :</label>
                <input type="text" name="name" size="40" /></p>
            <p><label>Email :</label>
                <input type="text" name="email" size="40" /></p>
            <p><label>Password :</label>
                <input type="password" name="password" size="60" /></p>
            <p><label>Double Confirm Password:</label>
                <input type="password" name="confirmPassword" size="60" /></p>

            <p><input type="submit" value="Submit" />
                <input type="reset" value="Reset" /></p>
        </form>

    </body>
</html>
