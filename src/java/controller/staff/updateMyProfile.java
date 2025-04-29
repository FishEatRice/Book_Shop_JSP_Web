package controller.staff;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class updateMyProfile extends HttpServlet {

    private static final String Host = "jdbc:derby://localhost:1527/db_galaxy_bookshelf";
    private static final String User = "GALAXY";
    private static final String passwor = "GALAXY";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("staffId");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String old_password = request.getParameter("old_password");
        String new_password = request.getParameter("new_password");
        String double_new_password = request.getParameter("double_new_password");
        int position = Integer.parseInt(request.getParameter("position"));

        String super_new_password = old_password;

        HttpSession session = request.getSession();

        if (new_password != null && !new_password.trim().isEmpty()) {
            if (new_password.equals(double_new_password)) {
                super_new_password = new_password; // Update to the new password
            } else {
                session.setAttribute("message", "New password and confirmation do not match.");
                session.setAttribute("messageType", "error");
                if (position == 1) {
                    response.sendRedirect(request.getContextPath() + "/admin/adminProfileDetails.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/staff/staffProfileDetails.jsp");
                }
                return;
            }
        }

        String query = "UPDATE GALAXY.STAFF SET STAFF_FIRSTNAME = ?, STAFF_LASTNAME = ?, STAFF_PASSWORD = ? WHERE STAFF_ID = ? AND STAFF_PASSWORD = ?";

        try (Connection conn = DriverManager.getConnection(Host, User, passwor); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, super_new_password);
            stmt.setString(4, id);
            stmt.setString(5, old_password);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                session.setAttribute("message", "Profile updated successfully!");
                session.setAttribute("messageType", "success");
            } else {
                session.setAttribute("message", "Incorrect Old Password or Staff ID not found.");
                session.setAttribute("messageType", "error");
            }
            if (position == 1) {
                response.sendRedirect(request.getContextPath() + "/admin/adminProfileDetails.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/staff/staffProfileDetails.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("message", "Database error: " + e.getMessage());
            session.setAttribute("messageType", "error");
            if (position == 1) {
                response.sendRedirect(request.getContextPath() + "/admin/adminProfileDetails.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/staff/staffProfileDetails.jsp");
            }
        }
    }
}
