/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.admin;

/**
 *
 * @author yq
 */
import model.staff.Staff;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import jakarta.servlet.annotation.WebServlet;



public class AdminLoginFunction extends HttpServlet {

    private static final String Host = "jdbc:derby://localhost:1527/db_galaxy_bookshelf";
    private static String User = "GALAXY";
    private static String password = "GALAXY";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");

        // Retrieve form parameters
        Staff staff = new Staff();

        // Debugging
        staff.setStaffId(request.getParameter("staff_id"));
        staff.setStaffPassword(request.getParameter("staff_password"));
        
        
        String checkAcc = isValidLogin(staff);
        
        // Validate login
        if (checkAcc!= null) {
            
            // Successful
            if(checkAcc.equals("admin"))
            response.sendRedirect("/galaxy_bookshelf/admin/adminDashboard.jsp");
            else {
                // staff
                response.sendRedirect("/galaxy_bookshelf/staff/staffDashboard.jsp");
            }

        } else {
            // Failed
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
                    // Check if this is the admin account
                    if ("A1".equals(staff.getStaffId())) { //a1 is admin id
                        return "admin";
                    } else {
                        return "staff"; // it's a regular staff
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Database connection error: " + e.getMessage());
        }
        return null; // No matching staff
    }
}