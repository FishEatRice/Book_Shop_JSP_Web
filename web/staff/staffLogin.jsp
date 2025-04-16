<%-- 
    Document   : staffLogin
    Created on : Apr 11, 2025, 8:05:13 AM
    Author     : yq
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
// 获取 staffId 的值（需强制转换为 String）
String staffId = (String) session.getAttribute("staffId");

if (staffId != null) {
    // 先检查是否是管理员（假设 A1 是管理员标识）
    if ("A1".equals(staffId)) {
        response.sendRedirect(request.getContextPath() + "/admin/adminDashboard.jsp");
    } else {
        // 其他员工跳转到员工仪表盘
        response.sendRedirect(request.getContextPath() + "/staff/staffDashboard.jsp");
    }
}
%>


<!DOCTYPE html>
<html>
    <head>
        <title>Staff Login</title>
    </head>
    <body>


        <h2>Login</h2>
        <form action="../AdminLoginFunction" method="POST">
            <label for="staff_id">Staff ID:</label>
            <input type="text" id="staff_id" name="staff_id" required/><br><br>

            <label for="staff_password">Password:</label>
            <input type="password" id="staff_password" name="staff_password" required/><br><br>

            <button type="submit">Login</button>
        </form>
        <a href="#"> Forget Password</a>

    </body>
</html>
