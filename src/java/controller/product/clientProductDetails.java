/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.product;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.product.Product;

/**
 *
 * @author JS
 */
public class clientProductDetails extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("galaxy_bookshelfPU");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productID = request.getParameter("id");
        EntityManager em = emf.createEntityManager();

        Product productData = em.find(Product.class, productID); // SELECT * FROM product WHERE product_id = ?

        if (productData == null) {
            // Send 404 error
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return; 
        }

        // Process the product images (base64 image strings) - Convert JSON to Image
        if (productData != null) {
            String picJson = productData.getProductPicture();
            String imageData = "";
            String imageType = "jpeg";

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

                String base64Src = "data:" + imageType + ";base64," + imageData;
                productData.setProductPicture(base64Src);
            }

            try {
                Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");
                String discount_query = "SELECT DISCOUNT_PRICE FROM GALAXY.DISCOUNT WHERE PRODUCT_ID = ? AND DISCOUNT_SWITCH = 'true'";
                PreparedStatement stmt = conn.prepareStatement(discount_query);
                stmt.setString(1, productID);
                ResultSet rs = stmt.executeQuery();

                double discountPrice = 0.0;
                if (rs.next()) {
                    discountPrice = rs.getDouble("DISCOUNT_PRICE");
                }
                
                productData.setDiscountPrice(discountPrice);
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }
        request.setAttribute("productData", productData);
       
        request.getRequestDispatcher("/product/clientProductDetails.jsp").forward(request, response);
    }
}
