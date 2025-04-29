package controller.cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import model.cart.Cart;

public class add_to_cart_process extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String customer_id = (String) session.getAttribute("customer_id");

        // If user not logged in
        if (customer_id == null) {
            sendAlertAndRedirect(response, "You must login first!", request.getContextPath() + "/customer/customerLogin.jsp");
            return;
        }

        String product_id = request.getParameter("product_id");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Check if quantity requested is valid
        int availableStock = getProductStock(product_id);
        int currentCartQty = getCurrentCartQuantity(customer_id, product_id);
        if (quantity + currentCartQty > availableStock) {
            sendAlertAndRedirect(response, "Unable to add selected quantity to cart as it would exceed your purchase limit.", request.getHeader("Referer"));
            return;
        }

        String cartResponds = "Failed";

        if (checkCartQuantity(customer_id, product_id)) {
            add_old_cart(customer_id, product_id, quantity);
            cartResponds = "old_cart";
        } else {
            new_cart(customer_id, product_id, quantity);
            cartResponds = "new_cart";
        }

        session.setAttribute("cartResponds", cartResponds);

        // After successful add
        sendAlertAndRedirect(response, "Successfully added to cart!", request.getHeader("Referer"));
    }

    // Utility: Show alert and redirect
    private void sendAlertAndRedirect(HttpServletResponse response, String message, String redirectURL) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script type='text/javascript'>");
        out.println("alert('" + message + "');");
        out.println("window.location.href='" + redirectURL + "';");
        out.println("</script>");
    }

    // Check if cart already has the product
    private boolean checkCartQuantity(String customer_id, String product_id) {
        try (Connection conn = getConnection()) {
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

    // Add quantity to existing cart item
    private void add_old_cart(String customer_id, String product_id, int quantity) {
        try (Connection conn = getConnection()) {
            // Find Cart ID and Old Quantity
            String sql = "SELECT CART_ID, QUANTITY FROM GALAXY.CART WHERE CUSTOMER_ID = ? AND PRODUCT_ID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, customer_id);
            stmt.setString(2, product_id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String oldCartId = rs.getString("CART_ID");
                int newQuantity = rs.getInt("QUANTITY") + quantity;

                // Delete Old Record
                sql = "DELETE FROM GALAXY.CART WHERE CART_ID = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, oldCartId);
                stmt.executeUpdate();

                // Insert New Record
                Cart newCart = new Cart(customer_id);
                String newCartId = newCart.getCartId();

                sql = "INSERT INTO GALAXY.CART (CART_ID, CUSTOMER_ID, PRODUCT_ID, QUANTITY) VALUES (?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, newCartId);
                stmt.setString(2, customer_id);
                stmt.setString(3, product_id);
                stmt.setInt(4, newQuantity);
                stmt.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Add new cart item
    private void new_cart(String customer_id, String product_id, int quantity) {
        try (Connection conn = getConnection()) {
            Cart cart = new Cart(customer_id);
            String cart_id = cart.getCartId();

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

    // Check available stock for a product
    private int getProductStock(String product_id) {
        int stock = 0;
        try (Connection conn = getConnection()) {
            String sql = "SELECT QUANTITY FROM GALAXY.PRODUCT WHERE PRODUCT_ID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, product_id);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                stock = rs.getInt("QUANTITY");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stock;
    }

    // Get current cart quantity for this customer and product
    private int getCurrentCartQuantity(String customer_id, String product_id) {
        int quantity = 0;
        try (Connection conn = getConnection()) {
            String sql = "SELECT QUANTITY FROM GALAXY.CART WHERE CUSTOMER_ID = ? AND PRODUCT_ID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, customer_id);
            stmt.setString(2, product_id);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                quantity = rs.getInt("QUANTITY");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return quantity;
    }

    // Database Connection Utility
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(
                "jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY"
        );
    }
}
