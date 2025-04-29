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
import java.util.ArrayList;
import java.util.List;
import model.product.Product;
import model.genre.Genre;

/**
 *
 * @author JS
 */
public class clientProductSearch extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("galaxy_bookshelfPU");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                String query = request.getParameter("query");
                String genreId = request.getParameter("genreId");
        
                EntityManager em = emf.createEntityManager();

                //Display for dropdown
                List<Genre> genreList = em.createQuery("SELECT g FROM Genre g", Genre.class).getResultList();

                //retrieve data when searching
                List<Product> productData = new ArrayList<>();
        
                if (query != null && !query.isEmpty() && genreId != null && !genreId.isEmpty()) {
                    // Search by Name and Genre
                    productData = em.createQuery(
                        "SELECT p FROM Product p WHERE LOWER(p.productName) LIKE LOWER(:productName) AND LOWER(p.genreId.genreId) LIKE LOWER(:genreId)", Product.class)
                            .setParameter("productName", "%" + query + "%")
                            .setParameter("genreId", "%" + genreId + "%")
                            .getResultList();
                
                } else if (query != null && !query.isEmpty()) {
                    // Search by Name only
                    String findByName = "%" + query + "%";
                    productData = em.createNamedQuery("Product.findByProductName", Product.class)
                        .setParameter("productName", findByName)
                        .getResultList();
                
                } else if (genreId != null && !genreId.isEmpty()) {
                    // Search by Genre only
                    productData = em.createNativeQuery(
                        "SELECT * FROM Product p WHERE LOWER(p.genre_id) LIKE LOWER(?)", Product.class)
                        .setParameter(1, "%" + genreId + "%")
                        .getResultList();
                } else {
                    //If user input nothing
                    productData = em.createNativeQuery(
                        "SELECT * FROM Product", Product.class)
                            .setParameter("productName", "%" + query + "%")
                            .setParameter("genreId", "%" + genreId + "%")
                            .getResultList();
                }
                
                
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
    
                // Set the result as a request attribute
                request.setAttribute("productData", productData);
                request.setAttribute("genreId", genreId);
                request.setAttribute("genreList", genreList);
                request.getRequestDispatcher("/product/clientProductListing.jsp").forward(request, response);
    
        }
    }