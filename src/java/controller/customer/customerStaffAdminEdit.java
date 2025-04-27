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

//update customer (admin and staff)
public class customerStaffAdminEdit extends HttpServlet {

    private static final String Host = "jdbc:derby://localhost:1527/db_galaxy_bookshelf";
    private static final String User = "GALAXY";
    private static final String passwor = "GALAXY";

    /**
     *
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // get form data
        String id = request.getParameter("customerId");
        String name = request.getParameter("customerName");
        String email = request.getParameter("customerEmail");
        String password = request.getParameter("customerPassword");
        String firstName = request.getParameter("customerFirstName");
        String lastName = request.getParameter("customerLastName");
        String addressNo = request.getParameter("customerAddressNo");
        String addressJalan = request.getParameter("customerAddressJalan");
        String addressCity = request.getParameter("customerAddressCity");
        String addressState = request.getParameter("customerAddressState");
        String addressCode = request.getParameter("customerAddressCode");
        String questionId = request.getParameter("customerquestionId");
        String questionAnswer = request.getParameter("customerquestionAnswer");
        String customerRequest = request.getParameter("customerRequest");
        
        String updateSQL = "UPDATE GALAXY.CUSTOMER SET "
                + "CUSTOMER_NAME = ?, CUSTOMER_EMAIL = ?, CUSTOMER_PASSWORD = ?, "
                + "CUSTOMER_FIRSTNAME = ?, CUSTOMER_LASTNAME = ?, "
                + "CUSTOMER_ADDRESS_NO = ?, CUSTOMER_ADDRESS_JALAN = ?, "
                + "CUSTOMER_ADDRESS_CITY = ?, CUSTOMER_ADDRESS_STATE = ?, CUSTOMER_ADDRESS_CODE = ? ,"
                + "CUSTOMER_QUESTION_ID= ?, CUSTOMER_QUESTION_ANSWER=?, CUSTOMER_REQUEST =? WHERE CUSTOMER_ID = ?";

        try (Connection conn = DriverManager.getConnection(Host, User, passwor); PreparedStatement stmt = conn.prepareStatement(updateSQL)) {

            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setString(4, firstName);
            stmt.setString(5, lastName);
            stmt.setString(6, addressNo);
            stmt.setString(7, addressJalan);
            stmt.setString(8, addressCity);
            stmt.setString(9, addressState);
            stmt.setString(10, addressCode);
            stmt.setString(11, questionId);
            stmt.setString(12, questionAnswer);
            stmt.setString(13, customerRequest);
            stmt.setString(14, id);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                
                response.sendRedirect("/galaxy_bookshelf/staff/customerManagementList.jsp");
            } else {
                
                response.getWriter().write("Update failed.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Database error: " + e.getMessage());
        }
    }
}
