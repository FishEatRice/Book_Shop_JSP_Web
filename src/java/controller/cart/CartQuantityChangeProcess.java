/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

/**
 *
 * @author ON YUEN SHERN
 */
public class CartQuantityChangeProcess extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String Cart_ID = request.getParameter("cart_id");
        String quantity = request.getParameter("quantity");

        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String sql = "UPDATE GALAXY.CART SET QUANTITY = ? WHERE CART_ID = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, quantity);
            stmt.setString(2, Cart_ID);

            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/web/customer/list_cart.jsp");
    }
}
