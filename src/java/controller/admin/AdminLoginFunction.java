package controller.admin;

import model.staff.Staff;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpSession;

public class AdminLoginFunction extends HttpServlet {

    private static final String Host = "jdbc:derby://localhost:1527/db_galaxy_bookshelf";
    private static String User = "GALAXY";
    private static String password = "GALAXY";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");

        String staffId = request.getParameter("staff_id");
        String staffPassword = request.getParameter("staff_password");

        HttpSession session = request.getSession();

        Staff staff = new Staff();
        staff.setStaffId(staffId);
        staff.setStaffPassword(staffPassword);

        String role = isValidLogin(staff);

        if (role != null) {

            session.setAttribute("userRole", role);
            session.setAttribute("account_status", staff.getStaffId());

            if ("admin".equals(role)) {
                response.sendRedirect("/galaxy_bookshelf/web/index.jsp");
            } else {
                response.sendRedirect("/galaxy_bookshelf/web/index.jsp");
            }
        } else {

            response.sendRedirect("/galaxy_bookshelf/admin/loginError.jsp");
        }
    }

    private String isValidLogin(Staff staff) {
        String query = "SELECT * FROM GALAXY.STAFF WHERE STAFF_ID = ? AND STAFF_PASSWORD = ?";

        try (Connection conn = DriverManager.getConnection(Host, User, password); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, staff.getStaffId());
            stmt.setString(2, staff.getStaffPassword());

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {

                    if ("A1".equals(staff.getStaffId())) {
                        return "admin";
                    } else {
                        return "staff";
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}
