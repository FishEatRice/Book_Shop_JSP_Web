/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.product;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.product.Product;

/**
 *
 * @author JS
 */
public class clientProductListing extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("galaxy_bookshelfPU");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EntityManager em = emf.createEntityManager();
        List<Product> productData = em.createNamedQuery("Product.findAllByOrder", Product.class).getResultList();

        // Process the product images (base64 image strings) - Convert JSON to Image
        for (Product product : productData) {
            String picJson = product.getProductPicture();
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
                product.setProductPicture(base64Src);
            }

        }
        request.setAttribute("productData", productData);
        request.getRequestDispatcher("/product/clientProductListing.jsp").forward(request, response);
    }
}
