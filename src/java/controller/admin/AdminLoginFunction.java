/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.admin;

/**
 *
 * @author yq
 */

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/AdminLoginFunction")

public class AdminLoginFunction extends HttpServlet{
    
    private static final String Host = "jdbc:derby://localhost:1527/db_galaxy_bookshelf";
    private static String User = "GALAXY";
    private static String password = "GALAXY";
    
    
     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");

        // Retrieve form parameters
        String staffId = request.getParameter("staff_id");
        String staffPassword = request.getParameter("staff_password");

        // Debugging
        System.out.println("Received staffId: " + staffId);
        System.out.println("Received staffPassword: " + staffPassword);

        // Validate login
        if (isValidLogin(staffId, staffPassword)) {
            // Successful
            response.sendRedirect("/galaxy_bookshelf/admin/adminDashboard.jsp");
            
        } else {
            // Failed
            response.sendRedirect("/galaxy_bookshelf/admin/loginError.jsp");
        }
        
        

    }

    private boolean isValidLogin(String staffId, String staffPassword) {
        String query = "SELECT * FROM GALAXY.STAFF WHERE STAFF_ID = ? AND STAFF_PASSWORD = ?";

        try (Connection conn = DriverManager.getConnection(Host,User,password);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, staffId);
            stmt.setString(2, staffPassword);

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.err.println("Database connection error: " + e.getMessage());
            return false;
        }
    }
    
}
    

