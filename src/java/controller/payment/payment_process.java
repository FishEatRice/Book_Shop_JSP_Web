/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.payment;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.ZoneId;

/**
 *
 * @author ON YUEN SHERN
 */
public class payment_process extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String cart_id = request.getParameter("cart_id");
        String payType = request.getParameter("payType");

        String customer_id = "C1"; // demo

        // 0: NULL
        // 1: Packaging
        // 2: Shipping
        // 3: Delivery
        // 4: Success
        // 5: Refund
        int shippingStatus = 1;

        int cart_quantity = 0;
        String product_id = "";
        String product_name = "";

        double price = 0.0;
        int StockQuantity = 0;

        int StockAfter = 0;

        // Get Time
        LocalDateTime now = LocalDateTime.now(ZoneId.of("Asia/Kuala_Lumpur"));

        String formattedDateTime = now.format(java.time.format.DateTimeFormatter.ofPattern("ddMMyyyyHHmmss"));
        String payment_id = customer_id + "P" + formattedDateTime;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            // Get Product id & Quantity In Cart
            String cartQuery = "SELECT product_id, quantity FROM galaxy.cart WHERE cart_id = ?";
            PreparedStatement cartStmt = conn.prepareStatement(cartQuery);
            cartStmt.setString(1, cart_id);
            ResultSet cartRs = cartStmt.executeQuery();

            if (cartRs.next()) {
                cart_quantity = cartRs.getInt("quantity");
                product_id = cartRs.getString("product_id");
            }
            cartRs.close();
            cartStmt.close();

            // Get Product_Price & StockQuantity
            String productQuery = "SELECT product_name, product_price, quantity FROM galaxy.product WHERE product_id = ?";
            PreparedStatement productStmt = conn.prepareStatement(productQuery);
            productStmt.setString(1, product_id);
            ResultSet productRs = productStmt.executeQuery();

            if (productRs.next()) {
                product_name = productRs.getString("product_name");
                price = productRs.getDouble("product_price");
                StockQuantity = productRs.getInt("quantity");
            }
            productRs.close();
            productStmt.close();

            // Remove Cart that already pay
            String deleteCart = "DELETE FROM galaxy.cart WHERE customer_id = ? AND product_id = ?";
            PreparedStatement deleteStmt = conn.prepareStatement(deleteCart);
            deleteStmt.setString(1, customer_id);
            deleteStmt.setString(2, product_id);
            deleteStmt.executeUpdate();
            deleteStmt.close();

            // Insert payment record
            String PaymentSuccess = "INSERT INTO galaxy.payment (payment_id, customer_id, product_name, quantity, pay_datetime, pay_type_id, shipping_status, pay_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement PaymentSuccessStmt = conn.prepareStatement(PaymentSuccess);
            PaymentSuccessStmt.setString(1, payment_id);
            PaymentSuccessStmt.setString(2, customer_id);
            PaymentSuccessStmt.setString(3, product_name);
            PaymentSuccessStmt.setInt(4, cart_quantity);
            PaymentSuccessStmt.setTimestamp(5, Timestamp.valueOf(now));
            PaymentSuccessStmt.setString(6, payType.toUpperCase());
            PaymentSuccessStmt.setInt(7, shippingStatus);
            PaymentSuccessStmt.setDouble(8, price);

            PaymentSuccessStmt.executeUpdate();
            PaymentSuccessStmt.close();

            // Stock after pay
            StockAfter = StockQuantity - cart_quantity;

            // Update Stock
            String StockUpdate = "UPDATE galaxy.product SET quantity = ? WHERE product_id = ?";
            PreparedStatement StockUpdateStmt = conn.prepareStatement(StockUpdate);
            StockUpdateStmt.setInt(1, StockAfter);
            StockUpdateStmt.setString(2, product_id);

            StockUpdateStmt.executeUpdate();
            StockUpdateStmt.close();

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Back 
        response.sendRedirect(request.getContextPath() + "/web/customer/list_cart.jsp");
    }
}
