package controller.cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;
import model.cart.CustomerCart;

/**
 *
 * @author ON YUEN SHERN
 */
public class customer_cart_list extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Get Customer_ID 
        String Customer_ID = "C1";

        List<CustomerCart> CustomerCart = new ArrayList<>();

        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String sql = "SELECT GALAXY.CART.CART_ID, GALAXY.CART.PRODUCT_ID, GALAXY.CART.QUANTITY AS CART_QUANTITY, GALAXY.PRODUCT.PRODUCT_NAME, GALAXY.PRODUCT.PRODUCT_PICTURE, GALAXY.PRODUCT.PRODUCT_PRICE, GALAXY.PRODUCT.QUANTITY AS STOCK_QUANTITY FROM GALAXY.CART JOIN GALAXY.PRODUCT ON GALAXY.CART.PRODUCT_ID = GALAXY.PRODUCT.PRODUCT_ID WHERE GALAXY.CART.CUSTOMER_ID = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, Customer_ID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String picJson = rs.getString("PRODUCT_PICTURE");
                String imageData = "";
                String imageType = "jpeg"; // default

                // Simple JSON parsing
                if (picJson != null && picJson.contains("base64Image")) {
                    int base64Start = picJson.indexOf("\"base64Image\":") + 15;
                    int base64End = picJson.indexOf("\"", base64Start);
                    if (base64Start > 14 && base64End > base64Start) {
                        imageData = picJson.substring(base64Start, base64End);
                    }

                    int typeStart = picJson.indexOf("\"fileType\":") + 12;
                    int typeEnd = picJson.indexOf("\"", typeStart);
                    if (typeStart > 11 && typeEnd > typeStart) {
                        imageType = picJson.substring(typeStart, typeEnd);
                    }
                }

                String base64Src = "data:" + imageType + ";base64," + imageData;

                double discount_price = 0.0;

                String CheckDiscountSQL = "SELECT DISCOUNT_PRICE FROM GALAXY.DISCOUNT WHERE PRODUCT_ID = ? AND DISCOUNT_SWITCH = 'true'";
                PreparedStatement CheckDiscountSTML = conn.prepareStatement(CheckDiscountSQL);
                CheckDiscountSTML.setString(1, rs.getString("PRODUCT_ID"));
                ResultSet CheckDiscountRS = CheckDiscountSTML.executeQuery();

                while (CheckDiscountRS.next()) {
                    discount_price = CheckDiscountRS.getDouble("DISCOUNT_PRICE");
                }

                // Put inside Model
                CustomerCart.add(new CustomerCart(
                        rs.getString("CART_ID"),
                        rs.getString("PRODUCT_ID"),
                        rs.getString("PRODUCT_NAME"),
                        rs.getDouble("PRODUCT_PRICE"),
                        base64Src,
                        rs.getInt("CART_QUANTITY"),
                        rs.getInt("STOCK_QUANTITY"),
                        discount_price
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        double subtotal = 0.0;

        for (CustomerCart cart : CustomerCart) {
            subtotal += cart.getProductPrice() * cart.getQuantityInCart();
        }

        double shippingFee = 3.0;
        double total = subtotal + shippingFee;

        request.setAttribute("Cart_Item", CustomerCart);
        request.setAttribute("Subtotal", subtotal);
        request.setAttribute("ShippingFee", shippingFee);
        request.setAttribute("Total", total);

        request.getRequestDispatcher("/cart/customer_cart.jsp").forward(request, response);
    }
}
