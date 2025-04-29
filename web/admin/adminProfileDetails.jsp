<%@ page import="model.staff.Staff" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Galaxy | My Profile</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>
        <h1>My Profile Details</h1>

        <%@ page import="java.sql.*, model.staff.Staff" %>
        <%
            String staffId = (String) session.getAttribute("account_status");

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
        <p>Name: <%= staff.getFirstName() %> <%= staff.getLastName() %></p>
        <p>Position: Admin</p>

        <%
            String message = (String) session.getAttribute("message");
            String messageType = (String) session.getAttribute("messageType");

            if (message != null) {
        %>
        <p style="color: <%= "success".equals(messageType) ? "green" : "red" %>;">
            <strong><%= message %></strong>
        </p>
        <%
                // Clear message after showing
                session.removeAttribute("message");
                session.removeAttribute("messageType");
            }
        %>

        <h3>Edit Profile:</h3>
        <form action="../updateMyProfile" method="post">
            <% if (staff != null) { %>
            <input type="hidden" name="staffId" value="<%= staff.getStaffId() %>" />
            <input type="hidden" name="position" value="<%= staff.getPosition() %>" />

            <label>First Name: </label>
            <input type="text" name="firstName" value="<%= staff.getFirstName() %>" required/>

            <br><br>

            <label>Last Name: </label>
            <input type="text" name="lastName" value="<%= staff.getLastName() %>" required/>

            <br><br>

            <label>Old Password: </label>
            <input type="password" name="old_password" value="" required/>

            <br>

            <h4><u>If you do not want to change your password, you can leave New Password and Confirm New Password blank.</u></h4>

            <label>New Password: </label>
            <input type="password" name="new_password" value="" />

            <br><br>

            <label>Confirm New Password: </label>
            <input type="password" name="double_new_password" value="" />

            <br><br>

            <input type="submit" value="Update Profile" />
            <% } else { %>
            <p>No staff info found.</p>
            <% } %>
        </form>
    </body>
</html>
