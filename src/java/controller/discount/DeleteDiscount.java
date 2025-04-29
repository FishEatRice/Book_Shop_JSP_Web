/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.discount;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

/**
 *
 * @author ON YUEN SHERN
 */
public class DeleteDiscount extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String Discount_ID = request.getParameter("discount_id");

        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String sql = "DELETE FROM GALAXY.DISCOUNT WHERE DISCOUNT_ID = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, Discount_ID);

            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("/galaxy_bookshelf/web/discount/discount_manager.jsp");

    }
}
