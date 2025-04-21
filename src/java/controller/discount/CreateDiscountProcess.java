package controller.discount;

/**
 *
 * @author ON YUEN SHERN
 */
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class CreateDiscountProcess extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productId = request.getParameter("productId");
        String discountPriceStr = request.getParameter("discountPrice");
        String expiredDatetimeStr = request.getParameter("expiredDatetime");
        String discountSwitch = request.getParameter("discountSwitch");

        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            // Check Discount having same product or not?
            String CheckSQL = "SELECT * FROM GALAXY.DISCOUNT WHERE PRODUCT_ID = ?";
            PreparedStatement checkStmt = conn.prepareStatement(CheckSQL);
            checkStmt.setString(1, productId);
            ResultSet rs = checkStmt.executeQuery();

            // If Yes, turn exists
            boolean exists = rs.next();

            // Parse and format expiry time
            LocalDateTime expiredDateTime = LocalDateTime.parse(expiredDatetimeStr);
            String formattedExpiry = expiredDateTime.format(DateTimeFormatter.ofPattern("yyyyMMddHHmm"));

            String discountId = productId + "DS" + formattedExpiry;

            if (exists) {
                // Delete Old Discount
                String deleteSQL = "DELETE FROM GALAXY.DISCOUNT WHERE PRODUCT_ID = ?";
                PreparedStatement deleteStmt = conn.prepareStatement(deleteSQL);
                deleteStmt.setString(1, productId);
                deleteStmt.executeUpdate();
            }

            // Insert new discount
            String NewDisSQL = "INSERT INTO GALAXY.DISCOUNT (DISCOUNT_ID, PRODUCT_ID, DISCOUNT_PRICE, DISCOUNT_EXPIRED, DISCOUNT_SWITCH) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement NewDicStmt = conn.prepareStatement(NewDisSQL);
            NewDicStmt.setString(1, discountId);
            NewDicStmt.setString(2, productId);
            NewDicStmt.setDouble(3, Double.parseDouble(discountPriceStr));
            NewDicStmt.setTimestamp(4, Timestamp.valueOf(expiredDateTime));
            NewDicStmt.setBoolean(5, Boolean.parseBoolean(discountSwitch));

            NewDicStmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("/galaxy_bookshelf/web/discount/discount_manager.jsp");
    }
}
