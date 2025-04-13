/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import model.cart.Cart;

/**
 *
 * @author ON YUEN SHERN
 */
public class add_to_cart_process extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the product ID and quantity from the form submission
        String product_id = request.getParameter("product_id");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Demo
        String customer_id = "C1";

        // Message
        String cartResponds = "Failed";

        if (checkCartQuantity(customer_id, product_id)) {
            add_old_cart(customer_id, product_id, quantity);
            cartResponds = "old_cart";
        } else {
            new_cart(customer_id, product_id, quantity);
            cartResponds = "new_cart";
        }

        HttpSession session = request.getSession();
        session.setAttribute("cartResponds", cartResponds);

        String referer = request.getHeader("Referer");
        response.sendRedirect(referer);
    }

    // Check Cart 
    private boolean checkCartQuantity(String customer_id, String product_id) {
        try {
            // Update with your database connection details
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String sql = "SELECT * FROM GALAXY.CART WHERE CUSTOMER_ID = ? AND PRODUCT_ID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, customer_id);
            stmt.setString(2, product_id);

            ResultSet rs = stmt.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // A Old Cart, add one inside
    private void add_old_cart(String customer_id, String product_id, int quantity) {
        try {
            // Update with your database connection details
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            // Find Cart ID
            String sql = "SELECT CART_ID, QUANTITY FROM GALAXY.CART WHERE CUSTOMER_ID = ? AND PRODUCT_ID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, customer_id);
            stmt.setString(2, product_id);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String oldCartId = rs.getString("CART_ID");
                int NewQuantity = rs.getInt("QUANTITY") + quantity;

                // Delete Old Data
                sql = "DELETE FROM GALAXY.CART WHERE CART_ID = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, oldCartId);
                stmt.executeUpdate();

                // Get New Cart ID
                Cart newCart = new Cart(customer_id);
                String newCartId = newCart.getCartId();

                // Insert New Cart
                sql = "INSERT INTO GALAXY.CART (CART_ID, CUSTOMER_ID, PRODUCT_ID, QUANTITY) VALUES (?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, newCartId);
                stmt.setString(2, customer_id);
                stmt.setString(3, product_id);
                stmt.setInt(4, NewQuantity);
                stmt.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // A New Cart
    private void new_cart(String customer_id, String product_id, int quantity) {
        Cart cart = new Cart(customer_id);

        String cart_id = cart.getCartId();

        try {
            // Update with your database connection details
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String sql = "INSERT INTO GALAXY.CART (CART_ID, CUSTOMER_ID, PRODUCT_ID, QUANTITY) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, cart_id);
            stmt.setString(2, customer_id);
            stmt.setString(3, product_id);
            stmt.setInt(4, quantity);

            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
