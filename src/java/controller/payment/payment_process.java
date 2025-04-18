// payment_process.java (Now using unique payment_id per row to prevent PK violation)
package controller.payment;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;

public class payment_process extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] cartIds = request.getParameter("cart_ids").split(",");
        String payType = Optional.ofNullable(request.getParameter("payType")).orElse("CARD");
        String customer_id = "C1"; // Demo only
        int shippingStatus = 1;

        LocalDateTime now = LocalDateTime.now(ZoneId.of("Asia/Kuala_Lumpur"));
        String basePaymentId = customer_id + "P" + now.format(java.time.format.DateTimeFormatter.ofPattern("ddMMyyyyHHmmss"));

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            System.out.println("[DEBUG] Cart IDs: " + Arrays.toString(cartIds));

            String placeholders = String.join(",", Collections.nCopies(cartIds.length, "?"));
            String cartQuery = "SELECT c.cart_id, c.product_id, c.quantity AS cart_qty, p.product_name, p.product_price, p.quantity AS stock_qty FROM galaxy.cart c JOIN galaxy.product p ON c.product_id = p.product_id WHERE c.cart_id IN (" + placeholders + ")";

            PreparedStatement stmt = conn.prepareStatement(cartQuery);
            for (int i = 0; i < cartIds.length; i++) {
                stmt.setString(i + 1, cartIds[i]);
            }

            ResultSet rs = stmt.executeQuery();
            int rowCount = 1;
            boolean foundItem = false;

            while (rs.next()) {
                foundItem = true;
                String cart_id = rs.getString("cart_id");
                String product_id = rs.getString("product_id");
                String product_name = rs.getString("product_name");
                int cart_quantity = rs.getInt("cart_qty");
                double price = rs.getDouble("product_price");
                int stock = rs.getInt("stock_qty");
                int stock_after = stock - cart_quantity;

                String payment_id = basePaymentId + "-" + rowCount;
                rowCount++;

                System.out.println("[DEBUG] Product: " + product_id + " | " + product_name + " | Qty: " + cart_quantity);

                // Insert payment record
                PreparedStatement payStmt = conn.prepareStatement("INSERT INTO galaxy.payment (payment_id, customer_id, product_id, product_name, quantity, pay_datetime, pay_type_id, shipping_status, pay_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
                payStmt.setString(1, payment_id);
                payStmt.setString(2, customer_id);
                payStmt.setString(3, product_id);
                payStmt.setString(4, product_name);
                payStmt.setInt(5, cart_quantity);
                payStmt.setTimestamp(6, Timestamp.valueOf(now));
                payStmt.setString(7, payType.toUpperCase());
                payStmt.setInt(8, shippingStatus);
                payStmt.setDouble(9, price);
                payStmt.executeUpdate();
                payStmt.close();

                // Update stock
                PreparedStatement updateStock = conn.prepareStatement("UPDATE galaxy.product SET quantity = ? WHERE product_id = ?");
                updateStock.setInt(1, stock_after);
                updateStock.setString(2, product_id);
                updateStock.executeUpdate();
                updateStock.close();

                // Delete cart item
                PreparedStatement delCart = conn.prepareStatement("DELETE FROM galaxy.cart WHERE cart_id = ?");
                delCart.setString(1, cart_id);
                delCart.executeUpdate();
                delCart.close();
            }
            rs.close();
            stmt.close();

            // Always insert shipping fee
            PreparedStatement fee_ps = conn.prepareStatement("SELECT FEE FROM GALAXY.SHIPPING_FEE SF JOIN GALAXY.SHIPPING_STATE SS ON SF.SHIPPING_ID = SS.SHIPPING_ID JOIN GALAXY.CUSTOMER CR ON SS.STATE_ID = CR.CUSTOMER_ADDRESS_STATE WHERE CR.CUSTOMER_ID = ?");
            fee_ps.setString(1, customer_id);
            ResultSet fee_rs = fee_ps.executeQuery();
            if (fee_rs.next()) {
                double shippingFee = fee_rs.getDouble("FEE");
                String payment_id = basePaymentId + "-" + rowCount;
                System.out.println("[DEBUG] Shipping Fee: RM " + shippingFee);

                PreparedStatement shipInsert = conn.prepareStatement("INSERT INTO galaxy.payment (payment_id, customer_id, product_id, product_name, quantity, pay_datetime, pay_type_id, shipping_status, pay_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
                shipInsert.setString(1, payment_id);
                shipInsert.setString(2, customer_id);
                shipInsert.setString(3, "Fee");
                shipInsert.setString(4, "Shipping Fee");
                shipInsert.setInt(5, 1);
                shipInsert.setTimestamp(6, Timestamp.valueOf(now));
                shipInsert.setString(7, payType.toUpperCase());
                shipInsert.setInt(8, shippingStatus);
                shipInsert.setDouble(9, shippingFee);
                shipInsert.executeUpdate();
                shipInsert.close();
            } else {
                System.out.println("[WARN] Shipping fee not found for customer " + customer_id);
            }
            fee_rs.close();
            fee_ps.close();

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/web/customer/list_cart.jsp");
    }
}