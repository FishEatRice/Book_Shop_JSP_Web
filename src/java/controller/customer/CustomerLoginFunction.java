/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.customer;

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

@WebServlet("/CustomerLoginFunction")
public class CustomerLoginFunction extends HttpServlet {

    private static final String Host = "jdbc:derby://localhost:1527/db_galaxy_bookshelf";
    private static String User = "GALAXY";
    private static String password = "GALAXY";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");

        // Retrieve form parameters
        String customerId = request.getParameter("customer_id");
        String customerPassword = request.getParameter("customer_password");
        
                // Debugging
        System.out.println("Received customerId: " + customerId);
        System.out.println("Received customerPassword: " + customerPassword);

        // Validate login
        if (isValidLogin(customerId, customerPassword)) {
            // Successful
            response.sendRedirect("/galaxy_bookshelf/customer/customerDashboard.jsp");
        } else {
            // Failed
            response.sendRedirect("#");
        }
        
        

    }
    
     private boolean isValidLogin(String customerId, String customerPassword) {
        String query = "SELECT * FROM GALAXY.STAFF WHERE CUSTOMER_ID = ? AND CUSTOMER_PASSWORD = ?";

        try (Connection conn = DriverManager.getConnection(Host,User,password);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, customerId);
            stmt.setString(2, customerPassword);

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.err.println("Database connection error: " + e.getMessage());
            return false;
        }
    }


}

