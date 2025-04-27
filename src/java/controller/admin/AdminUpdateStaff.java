/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

/**
 *
 * @author yq
 */
public class AdminUpdateStaff extends HttpServlet {

    private static final String Host = "jdbc:derby://localhost:1527/db_galaxy_bookshelf";
    private static final String User = "GALAXY";
    private static final String passwor = "GALAXY";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("staffId");
        String firstName = request.getParameter("staffFirstName");
        String lastName = request.getParameter("staffLastName");
        String password = request.getParameter("staffPassword");
        int position = Integer.parseInt(request.getParameter("position"));

        String query = "UPDATE GALAXY.STAFF SET STAFF_FIRSTNAME = ?, STAFF_LASTNAME = ?, STAFF_PASSWORD = ?, POSITION = ? WHERE STAFF_ID = ?";

        try (Connection conn = DriverManager.getConnection(Host, User, passwor); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, password);
            stmt.setInt(4, position);
            stmt.setString(5, id);

           
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                 response.sendRedirect("/galaxy_bookshelf/admin/controlStaff.jsp");
            } else {
                response.getWriter().println("No staff found with the given ID.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }
}
