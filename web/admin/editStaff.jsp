<%@ page import="model.staff.Staff" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/header/main_header.jsp" %>
<%
        request.setCharacterEncoding("UTF-8");
    String staffId = request.getParameter("staffId");
    Staff staff = new Staff();
try {
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");
    String sql = "SELECT * FROM GALAXY.STAFF WHERE STAFF_ID = ?";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setString(1, staffId);
    ResultSet rs = stmt.executeQuery();

    if (rs.next()) {
        staff.setStaffId(rs.getString("STAFF_ID"));
        staff.setFirstName(rs.getString("STAFF_FIRSTNAME"));
        staff.setLastName(rs.getString("STAFF_LASTNAME"));
        staff.setStaffPassword(rs.getString("STAFF_PASSWORD"));
        staff.setPosition(rs.getInt("POSITION"));
    }

    rs.close();
    stmt.close();
    conn.close();
} catch (Exception e) {
    out.println("Error loading staff data: " + e.getMessage());
}

request.setAttribute("staff", staff);

%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Staff Information</title>
    </head>
    <body>

        <h1>Edit Staff Information</h1>

        <div class="form-container">
            <form action="/crudStaff" method="post">
                <input type="hidden" name="action" value="edit" />
                <input type="hidden" name="id" value="${staff.staffId}" />

                <label for="id">STAFF_ID:</label>
                <input type="text" id="id" name="id" value="${staff.staffId}" readonly />

                <br><br><label for="firstName">First Name:</label>
                <input type="text" id="firstName" name="firstName" value="${staff.firstName}" required />

                <br><br><label for="lastName">Last Name:</label>
                <input type="text" id="lastName" name="lastName" value="${staff.lastName}" required />

                <br><br><label for="password">Password:</label>
                <input type="password" id="password" name="password" value="${staff.staffPassword}" required />

                <br><br><label for="position">Position:</label>
                <input type="text" id="position" name="position" value="${staff.position}" required />

                <br><br><input type="submit" value="Save Changes" />
            </form>

            <br><a href="/galaxy_bookshelf/admin/controlStaff.jsp">Back to Staff List</a>
        </div>

    </body>
</html>
