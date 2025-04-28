package controller.discount;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;
import model.discount.NewDiscountDisplay;

public class discount_manager extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<NewDiscountDisplay> NewDiscountDisplay = new ArrayList<>();

        try {
            Connection conn = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/db_galaxy_bookshelf",
                    "GALAXY",
                    "GALAXY"
            );

            String sql = "SELECT * FROM GALAXY.PRODUCT";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String picJson = rs.getString("PRODUCT_PICTURE");
                String imageData = "";
                String imageType = "jpeg"; // default

                // Manually parse JSON string for base64Image and fileType
                if (picJson != null && picJson.contains("base64Image")) {
                    try {
                        String base64Key = "\"base64Image\":\"";
                        int base64Start = picJson.indexOf(base64Key);
                        if (base64Start != -1) {
                            base64Start += base64Key.length();
                            int base64End = picJson.indexOf("\"", base64Start);
                            if (base64End != -1) {
                                imageData = picJson.substring(base64Start, base64End);
                            }
                        }

                        String typeKey = "\"fileType\":\"";
                        int typeStart = picJson.indexOf(typeKey);
                        if (typeStart != -1) {
                            typeStart += typeKey.length();
                            int typeEnd = picJson.indexOf("\"", typeStart);
                            if (typeEnd != -1) {
                                imageType = picJson.substring(typeStart, typeEnd);
                            }
                        }
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                }

                String base64Src = "data:" + imageType + ";base64," + imageData;

                double discountPrice = 0.0;
                String discountDetails = "";

                // Check if Discount exists for this product
                String checkDiscountSQL = "SELECT * FROM GALAXY.DISCOUNT WHERE PRODUCT_ID = ?";
                PreparedStatement Discountstmt = conn.prepareStatement(checkDiscountSQL);
                Discountstmt.setString(1, rs.getString("PRODUCT_ID"));
                ResultSet Discountrs = Discountstmt.executeQuery();

                boolean DiscountStatus = false;
                if (Discountrs.next()) {
                    DiscountStatus = true;
                    discountPrice = Discountrs.getDouble("DISCOUNT_PRICE");
                    discountDetails = Discountrs.getString("DISCOUNT_DETAILS"); // <-- Get from DISCOUNT table!
                }

                // Add the product to the list
                NewDiscountDisplay.add(new NewDiscountDisplay(
                        rs.getString("PRODUCT_ID"),
                        rs.getString("PRODUCT_NAME"),
                        rs.getDouble("PRODUCT_PRICE"),
                        base64Src,
                        DiscountStatus,
                        discountPrice,
                        discountDetails // <-- Now it's correct
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("productDiscountInfoList", NewDiscountDisplay);

        // Forward to JSP
        request.getRequestDispatcher("/discount/add_new_product_discount.jsp").forward(request, response);
    }
}
