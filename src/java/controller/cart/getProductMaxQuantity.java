package controller.cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

/**
 *
 * @author ON YUEN SHERN
 */
public class getProductMaxQuantity extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String productId = "P1";

        int quantity = 0;

        try {
            // Update with your database connection details
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String sql = "SELECT QUANTITY FROM GALAXY.PRODUCT WHERE PRODUCT_ID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, productId);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                quantity = rs.getInt("QUANTITY");
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("quantity", quantity);

        request.getRequestDispatcher("/product/add_to_cart.jsp").forward(request, response);
    }
}
