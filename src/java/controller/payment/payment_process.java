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
        HttpSession session = request.getSession();
        String customer_id = (String) session.getAttribute("customer_id");

        String full_shippping_address = "";

        LocalDateTime now = LocalDateTime.now(ZoneId.of("Asia/Kuala_Lumpur"));
        String basePaymentId = customer_id + "P" + now.format(java.time.format.DateTimeFormatter.ofPattern("ddMMyyyyHHmmss"));

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

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

                double discount_price = 0.0;

                String CheckDiscountSQL = "SELECT DISCOUNT_PRICE FROM GALAXY.DISCOUNT WHERE PRODUCT_ID = ? AND DISCOUNT_SWITCH = 'true'";
                PreparedStatement CheckDiscountSTML = conn.prepareStatement(CheckDiscountSQL);
                CheckDiscountSTML.setString(1, product_id);
                ResultSet CheckDiscountRS = CheckDiscountSTML.executeQuery();

                while (CheckDiscountRS.next()) {
                    discount_price = CheckDiscountRS.getDouble("DISCOUNT_PRICE");
                }

                //Payment Address
                String AddressSQL = "SELECT C.CUSTOMER_FIRSTNAME, C.CUSTOMER_LASTNAME, C.CUSTOMER_CONTACTNO, C.CUSTOMER_ADDRESS_NO, C.CUSTOMER_ADDRESS_JALAN, C.CUSTOMER_ADDRESS_CITY, C.CUSTOMER_ADDRESS_CODE, S.STATE_NAME FROM GALAXY.CUSTOMER C JOIN GALAXY.SHIPPING_STATE S ON C.CUSTOMER_ADDRESS_STATE = S.STATE_ID WHERE CUSTOMER_ID = ?";
                PreparedStatement address_stmt = conn.prepareStatement(AddressSQL);
                address_stmt.setString(1, customer_id);
                ResultSet address_rs = address_stmt.executeQuery();
                while (address_rs.next()) {
                    String Customer_Name = address_rs.getString("CUSTOMER_FIRSTNAME") + " " + address_rs.getString("CUSTOMER_LASTNAME");
                    String Customer_Contact = address_rs.getString("CUSTOMER_CONTACTNO");
                    String Customer_Address = address_rs.getString("CUSTOMER_ADDRESS_NO") + ", " + address_rs.getString("CUSTOMER_ADDRESS_JALAN") + "<br>" + address_rs.getString("CUSTOMER_ADDRESS_CODE") + " " + address_rs.getString("CUSTOMER_ADDRESS_CITY") + "<br>" + address_rs.getString("STATE_NAME");
                    full_shippping_address = Customer_Name + "<br>(+60) " + Customer_Contact + "<br>" + Customer_Address;
                }

                address_rs.close();
                address_stmt.close();

                // Insert payment record
                PreparedStatement payStmt = conn.prepareStatement("INSERT INTO galaxy.payment (payment_id, customer_id, product_id, product_name, quantity, pay_datetime, pay_type_id, pay_price, Shipping_address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
                payStmt.setString(1, payment_id);
                payStmt.setString(2, customer_id);
                payStmt.setString(3, product_id);
                payStmt.setString(4, product_name);
                payStmt.setInt(5, cart_quantity);
                payStmt.setTimestamp(6, Timestamp.valueOf(now));
                payStmt.setString(7, payType.toUpperCase());
                if (discount_price <= 0.0) {
                    payStmt.setDouble(8, price);
                } else {
                    payStmt.setDouble(8, discount_price);
                }
                payStmt.setString(9, full_shippping_address);

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

            // insert shipping fee
            PreparedStatement fee_ps = conn.prepareStatement("SELECT FEE FROM GALAXY.SHIPPING_FEE SF JOIN GALAXY.SHIPPING_STATE SS ON SF.SHIPPING_ID = SS.SHIPPING_ID JOIN GALAXY.CUSTOMER CR ON SS.STATE_ID = CR.CUSTOMER_ADDRESS_STATE WHERE CR.CUSTOMER_ID = ?");
            fee_ps.setString(1, customer_id);
            ResultSet fee_rs = fee_ps.executeQuery();
            if (fee_rs.next()) {
                double shippingFee = fee_rs.getDouble("FEE");
                String payment_id = basePaymentId + "-" + rowCount;

                PreparedStatement shipInsert = conn.prepareStatement("INSERT INTO galaxy.payment (payment_id, customer_id, product_id, product_name, quantity, pay_datetime, pay_type_id, pay_price, shipping_address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
                shipInsert.setString(1, payment_id);
                shipInsert.setString(2, customer_id);
                shipInsert.setString(3, "Fee");
                shipInsert.setString(4, "Shipping Fee");
                shipInsert.setInt(5, 1);
                shipInsert.setTimestamp(6, Timestamp.valueOf(now));
                shipInsert.setString(7, payType.toUpperCase());
                shipInsert.setDouble(8, shippingFee);
                shipInsert.setString(9, full_shippping_address);
                shipInsert.executeUpdate();
                shipInsert.close();
            }

            fee_rs.close();
            fee_ps.close();

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Direct go, user cannot go back
        response.sendRedirect("/galaxy_bookshelf/payment/payment_success.jsp");
    }
}
