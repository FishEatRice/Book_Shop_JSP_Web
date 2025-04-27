package controller.discount;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;
import model.discount.Discount;

/**
 *
 * @author ON YUEN SHERN
 */
public class discount_manager extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Discount> DiscountList = new ArrayList<>();

        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String sql = "SELECT D.DISCOUNT_ID, D.PRODUCT_ID, D.DISCOUNT_PRICE, D.DISCOUNT_EXPIRED, D.DISCOUNT_SWITCH, P.PRODUCT_NAME, P.PRODUCT_PRICE, P.PRODUCT_PICTURE FROM GALAXY.DISCOUNT D JOIN GALAXY.PRODUCT P ON D.PRODUCT_ID = P.PRODUCT_ID ORDER BY CAST(SUBSTR(D.PRODUCT_ID, 2) AS INT)";

            PreparedStatement stmt = conn.prepareStatement(sql);
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

                // Add new object with full data
                DiscountList.add(new Discount(
                        rs.getString("DISCOUNT_ID"),
                        rs.getString("PRODUCT_ID"),
                        rs.getDouble("PRODUCT_PRICE"),
                        rs.getDouble("DISCOUNT_PRICE"),
                        rs.getTimestamp("DISCOUNT_EXPIRED"),
                        rs.getBoolean("DISCOUNT_SWITCH"),
                        rs.getString("PRODUCT_NAME"),
                        base64Src
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("Discount", DiscountList);

        request.getRequestDispatcher("/discount/discount_manager.jsp").forward(request, response);
    }
}
