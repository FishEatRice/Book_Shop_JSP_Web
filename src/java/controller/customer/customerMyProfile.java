/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

/**
 *
 * @author yq
 */
public class customerMyProfile extends HttpServlet {

    private static final String Host = "jdbc:derby://localhost:1527/db_galaxy_bookshelf";
    private static final String User = "GALAXY";
    private static final String passwor = "GALAXY";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String id = request.getParameter("customerId");
        String name = request.getParameter("customerName");
        String contact_no = request.getParameter("contactNo");
        String old_password = request.getParameter("old_password");
        String new_password = request.getParameter("new_password");
        String double_new_password = request.getParameter("double_new_password");
        String firstName = request.getParameter("customerFirstName");
        String lastName = request.getParameter("customerLastName");
        String addressNo = request.getParameter("customerAddressNo");
        String addressJalan = request.getParameter("customerAddressJalan");
        String addressCity = request.getParameter("customerAddressCity");
        String addressState = request.getParameter("customerAddressState");
        String addressCode = request.getParameter("customerAddressCode");

        HttpSession session = request.getSession();

        String finalPassword = old_password;

        // If user wants to change password
        if (new_password != null && !new_password.trim().isEmpty()) {
            if (new_password.equals(double_new_password)) {
                finalPassword = new_password;
            } else {
                session.setAttribute("message", "New password and confirmation do not match.");
                session.setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/customer/customerProfileDetails.jsp");
                return;
            }
        }

        String updateSQL = "UPDATE GALAXY.CUSTOMER SET "
                + "CUSTOMER_NAME = ?, CUSTOMER_PASSWORD = ?,"
                + "CUSTOMER_FIRSTNAME = ?, CUSTOMER_LASTNAME = ?, "
                + "CUSTOMER_ADDRESS_NO = ?, CUSTOMER_ADDRESS_JALAN = ?, "
                + "CUSTOMER_ADDRESS_CITY = ?, CUSTOMER_ADDRESS_STATE = ?, CUSTOMER_ADDRESS_CODE = ?, CUSTOMER_CONTACTNO = ? "
                + "WHERE CUSTOMER_ID = ? AND CUSTOMER_PASSWORD = ?";

        try (Connection conn = DriverManager.getConnection(Host, User, passwor); PreparedStatement stmt = conn.prepareStatement(updateSQL)) {

            stmt.setString(1, name);
            stmt.setString(2, finalPassword);
            stmt.setString(3, firstName);
            stmt.setString(4, lastName);
            stmt.setString(5, addressNo);
            stmt.setString(6, addressJalan);
            stmt.setString(7, addressCity);
            stmt.setString(8, addressState);
            stmt.setString(9, addressCode);
            stmt.setString(10, contact_no);
            stmt.setString(11, id);
            stmt.setString(12, old_password); // Check old password

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                session.setAttribute("message", "Profile updated successfully!");
                session.setAttribute("messageType", "success");
            } else {
                session.setAttribute("message", "Incorrect Old Password or Customer ID not found.");
                session.setAttribute("messageType", "error");
            }
            response.sendRedirect(request.getContextPath() + "/customer/customerProfileDetails.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("message", "Database error: " + e.getMessage());
            session.setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/customer/customerProfileDetails.jsp");
        }
    }
}
