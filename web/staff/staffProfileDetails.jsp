<%@ page import="model.staff.Staff" %>
<%@ include file="/header/main_header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update My Profile</title>
    </head>
    <body>
        <h1>My Profile Details</h1>

        <%@ page import="java.sql.*, model.staff.Staff" %>
<%
    String staffId = (String) session.getAttribute("staffId");
    Staff staff = null;

    if (staffId != null) {
        try {
            String host = "jdbc:derby://localhost:1527/db_galaxy_bookshelf";
            String user = "GALAXY";
            String pass = "GALAXY";
            Connection conn = DriverManager.getConnection(host, user, pass);
            String sql = "SELECT * FROM GALAXY.STAFF WHERE STAFF_ID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, staffId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                staff = new Staff();
                staff.setStaffId(rs.getString("STAFF_ID"));
                staff.setFirstName(rs.getString("STAFF_FIRSTNAME"));
                staff.setLastName(rs.getString("STAFF_LASTNAME"));
                staff.setStaffPassword(rs.getString("STAFF_PASSWORD"));
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>
<form action="../updateMyProfile" method="post">
    <input type="hidden" name="staffId" value="<%= staff.getStaffId() %>" />
    <%
    if (staff != null) {
%>
    <p>Staff ID: <%= staff.getStaffId() %></p>
    <p>First Name: <%= staff.getFirstName() %></p>
    <p>Last Name: <%= staff.getLastName() %></p>
<%
    } else {
%>
    <p>No staff info found.</p>
<%
    }
%>


    <label>First Name: </label>
    <input type="text" name="firstName" value="<%= staff.getFirstName() %>" /><br>

    <label>Last Name: </label>
    <input type="text" name="lastName" value="<%= staff.getLastName() %>" /><br>

    <label>Password: </label>
    <input type="password" name="password" value="<%= staff.getStaffPassword() %>" /><br>

    <input type="submit" value="Update Profile" />
</form>

    </body>
</html>
