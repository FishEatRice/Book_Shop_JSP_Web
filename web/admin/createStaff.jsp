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

        <h3>Create staff Now</h3>
        <form method="post" action="../crudStaff" onsubmit="return validatePassword(); ">


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
