/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.product;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Base64;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.genre.Genre;
import model.product.Product;


@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB limit
public class productCreate extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("galaxy_bookshelfPU");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EntityManager em = emf.createEntityManager();
        List<Genre> genreList = em.createQuery("SELECT g FROM Genre g", Genre.class).getResultList(); // SELECT * FROM genre (List all the Genre)
        request.setAttribute("genreList", genreList); 

        request.getRequestDispatcher("/product/addProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                EntityManager em = emf.createEntityManager();
                EntityTransaction tx = em.getTransaction();
                HttpSession session = request.getSession();
        
                try {
                    tx.begin();
        
                    String name = request.getParameter("productName").trim();
                    String description = request.getParameter("productInformation").trim();
                    String genreId = request.getParameter("genreId");
                    String priceStr = request.getParameter("productPrice");
                    String qtyStr = request.getParameter("quantity");
        
                    if (name.isEmpty() || description.isEmpty() || genreId == null || genreId.isEmpty()
                            || priceStr == null || priceStr.isEmpty() || qtyStr == null || qtyStr.isEmpty()) {
                        session.setAttribute("error", "All fields are required.");
                        response.sendRedirect(request.getContextPath() + "/web/product/addProduct.jsp");
                        return;
                    }
                    
                    List<Product> existingProducts = em.createNamedQuery("Product.findByProductName", Product.class)
                        .setParameter("productName", name)
                        .getResultList();
            
                    if (!existingProducts.isEmpty()) {
                        session.setAttribute("error", "Product name already exists. Please choose a different name.");
                        response.sendRedirect(request.getContextPath() + "/web/product/addProduct.jsp");
                        return; 
                    }

                    BigDecimal price = new BigDecimal(priceStr);
                    int qty = Integer.parseInt(qtyStr);
        
                    if (price.compareTo(BigDecimal.ZERO) <= 0 || qty <= 0) {
                        session.setAttribute("error", "Price and quantity must be greater than 0.");
                        response.sendRedirect(request.getContextPath() + "/web/product/addProduct.jsp");
                        return;
                    }
        
                    Genre genre = em.find(Genre.class, genreId);
        
                    if (genre == null) {
                        session.setAttribute("error", "Selected genre not found.");
                        response.sendRedirect(request.getContextPath() + "/web/product/addProduct.jsp");
                        return;
                    }
        
                    Part filePart = request.getPart("productPicture");
                    if (filePart == null || filePart.getSize() == 0) {
                        session.setAttribute("error", "Product picture is required.");
                        response.sendRedirect(request.getContextPath() + "/web/product/addProduct.jsp");
                        return;
                    }
        
                    String contentType = filePart.getContentType();
                    if (!"image/jpeg".equalsIgnoreCase(contentType) && !"image/jpg".equalsIgnoreCase(contentType)) {
                        session.setAttribute("error", "Only JPEG images are allowed.");
                        response.sendRedirect(request.getContextPath() + "/web/product/addProduct.jsp");
                        return;
                    }
        
                    byte[] imageBytes = filePart.getInputStream().readAllBytes();
                    String fileName = filePart.getSubmittedFileName();
                    String base64 = Base64.getEncoder().encodeToString(imageBytes);
                    String imageJson = "{\"fileName\":\"" + fileName + "\",\"fileType\":\"" + contentType + "\",\"base64Image\":\"" + base64 + "\"}";
        
                    List<String> idList = em.createQuery(
                            "SELECT p.productId FROM Product p ORDER BY LENGTH(p.productId) DESC, p.productId DESC", String.class)
                            .setMaxResults(1)
                            .getResultList();
        
                    String productId = idList.isEmpty() ? "P1" :
                            "P" + (Integer.parseInt(idList.get(0).substring(1)) + 1);
        
                    Product product = new Product();
                    product.setProductId(productId);
                    product.setProductName(name);
                    product.setProductInformation(description);
                    product.setProductPicture(imageJson);
                    product.setProductPrice(price);
                    product.setQuantity(qty);
                    product.setGenreId(genre);
        
                    em.persist(product);
                    tx.commit();
        
                    session.setAttribute("success", "Product added successfully.");
                    response.sendRedirect(request.getContextPath() + "/web/product/product.jsp");
        
                } catch (Exception e) {
                    e.printStackTrace();
                    if (tx != null && tx.isActive()) {
                        tx.rollback();
                    }
                    session.setAttribute("error", "Failed to add product. Please try again.");
                    response.sendRedirect(request.getContextPath() + "/web/product/product.jsp");
                } finally {
                    em.close();
                }
    }

}