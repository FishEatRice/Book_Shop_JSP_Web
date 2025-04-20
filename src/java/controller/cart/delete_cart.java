package controller.cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

/**
 *
 * @author ON YUEN SHERN
 */
public class delete_cart extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String Cart_ID = request.getParameter("cart_id");
        
        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String sql = "DELETE FROM GALAXY.CART WHERE CART_ID = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, Cart_ID);

            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/web/customer/list_cart.jsp");
    }
}
