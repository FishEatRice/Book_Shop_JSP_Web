/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.customer;

/**
 *
 * @author yq
 */
import model.customer.Customer;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import jakarta.servlet.annotation.WebServlet;


public class CustomerLoginFunction extends HttpServlet {

    private static final String Host = "jdbc:derby://localhost:1527/db_galaxy_bookshelf";
    private static String User = "GALAXY";
    private static String password = "GALAXY";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");

          Customer customer = new Customer();
          
        customer.setCustomerEmail(request.getParameter("customer_email"));
        customer.setCustomerPassword(request.getParameter("customer_password"));
        
                // Debugging
        System.out.println("Received customerEmail: " + customer.getCustomerEmail());
        System.out.println("Received customerPassword: " + customer.getCustomerPassword());

        // Validate login
        if (isValidLogin(customer)) {
            // Successful
            response.sendRedirect("/galaxy_bookshelf/customer/customerDashboard.jsp");
        } else {
            // Failed
            response.sendRedirect("#");
        }
        
        

    }
    
     private boolean isValidLogin(Customer customer)  {
        String query = "SELECT * FROM GALAXY.CUSTOMER WHERE CUSTOMER_EMAIL = ? AND CUSTOMER_PASSWORD = ?";

        try (Connection conn = DriverManager.getConnection(Host,User,password);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, customer.getCustomerEmail());
            stmt.setString(2, customer.getCustomerPassword());

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.err.println("Database connection error: " + e.getMessage());
            return false;
        }
    }


}

