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

            // Exp:               cart_id in cart      product_id in cart     quantity in cart set how many in cart    product name in product      quantity in product and as max stock                                          JOIN in two sql                            Just Get the customer that already login
            String sql = "SELECT GALAXY.CART.CART_ID, GALAXY.CART.PRODUCT_ID, GALAXY.CART.QUANTITY AS CART_QUANTITY, GALAXY.PRODUCT.PRODUCT_NAME, GALAXY.PRODUCT.QUANTITY AS STOCK_QUANTITY FROM GALAXY.CART JOIN GALAXY.PRODUCT ON GALAXY.CART.PRODUCT_ID = GALAXY.PRODUCT.PRODUCT_ID WHERE GALAXY.CART.CUSTOMER_ID = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, Customer_ID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Put inside Model
                CustomerCart.add(new CustomerCart(
                        rs.getString("CART_ID"),
                        rs.getString("PRODUCT_ID"),
                        rs.getString("PRODUCT_NAME"),
                        rs.getInt("CART_QUANTITY"),
                        rs.getInt("STOCK_QUANTITY")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("Cart_Item", CustomerCart);

        request.getRequestDispatcher("/cart/customer_cart.jsp").forward(request, response);
    }
}
