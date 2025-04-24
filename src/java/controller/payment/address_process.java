/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.payment;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

/**
 *
 * @author ON YUEN SHERN
 */
public class address_process extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customer_id = "C1"; // Hardcoded for now; adjust if needed

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String contactNo = request.getParameter("contactNo");
        String addressNo = request.getParameter("addressNo");
        String addressJalan = request.getParameter("addressJalan");
        String addressCity = request.getParameter("addressCity");
        String addressCode = request.getParameter("addressCode");
        String addressState = request.getParameter("addressState");

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String sql = "UPDATE GALAXY.CUSTOMER SET CUSTOMER_FIRSTNAME = ?, CUSTOMER_LASTNAME = ?, CUSTOMER_CONTACTNO = ?, CUSTOMER_ADDRESS_NO = ?, CUSTOMER_ADDRESS_JALAN = ?, CUSTOMER_ADDRESS_CITY = ?, CUSTOMER_ADDRESS_CODE = ?, CUSTOMER_ADDRESS_STATE = ? WHERE CUSTOMER_ID = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, contactNo);
            stmt.setString(4, addressNo);
            stmt.setString(5, addressJalan);
            stmt.setString(6, addressCity);
            stmt.setString(7, addressCode);
            stmt.setString(8, addressState);
            stmt.setString(9, customer_id);

            stmt.executeUpdate();

            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("/galaxy_bookshelf/web/customer/list_cart.jsp");
    }
}
