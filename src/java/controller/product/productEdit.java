/*
* Click
nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt
to change this license
* Click
nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to
edit this template
 */
package controller.product;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Base64;
import java.util.List;
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
public class productEdit extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("galaxy_bookshelfPU");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productID = request.getParameter("id");
        EntityManager em = emf.createEntityManager();

        Product productData = em.find(Product.class, productID); // SELECT * FROM product WHERE product_id = ?
        List<Genre> genreList = em.createQuery("SELECT g FROM Genre g", Genre.class).getResultList(); // SELECT * FROM genre (List all the Genre)

        request.setAttribute("productData", productData);
        request.setAttribute("genreList", genreList);
        request.getRequestDispatcher("/product/editProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        HttpSession session = request.getSession();

        try {

            String productId = request.getParameter("productId").trim();
            String nameOri = request.getParameter("productNameOri").trim();
            String name = request.getParameter("productName").trim();
            String description = request.getParameter("productInformation").trim();
            String genreId = request.getParameter("genreId");
            String priceStr = request.getParameter("productPrice");
            String qtyStr = request.getParameter("quantity");

            // Input validation
            if (name.isEmpty() || description.isEmpty() || genreId == null || genreId.isEmpty() || priceStr == null || priceStr.isEmpty() || qtyStr == null || qtyStr.isEmpty()) {
                session.setAttribute("error", "All fields are required.");
                response.sendRedirect(request.getContextPath() + "/web/product/editProduct.jsp?id=" + productId);
                return;
            }

            BigDecimal price = new BigDecimal(priceStr);
            int quantity = Integer.parseInt(qtyStr);

            if (price.compareTo(BigDecimal.ZERO) <= 0 || quantity <= 0) {
                session.setAttribute("error", "Price and quantity must be greater than 0.");
                response.sendRedirect(request.getContextPath() + "/web/product/editProduct.jsp?id=" + productId);
                return;
            }

            tx.begin();

            Product product = em.find(Product.class, productId);
            List<Product> existingProducts = em.createNamedQuery("Product.findByProductName", Product.class)
                    .setParameter("productName", name)
                    .getResultList();
            
            if (!nameOri.equals(name)) {
                if (!existingProducts.isEmpty()) {
                    session.setAttribute("error", "Product name already exists. Please choose a different name.");
                    response.sendRedirect(request.getContextPath() + "/web/product/editProduct.jsp?id=" + productId);
                    return;
                }
            }

            Genre genre = em.find(Genre.class, genreId);

            // Update product details
            product.setProductName(name);
            product.setProductInformation(description);
            product.setGenreId(genre);
            product.setProductPrice(price);
            product.setQuantity(quantity);

            // Optional: Update product image if uploaded
            Part filePart = request.getPart("productPicture");
            if (filePart != null && filePart.getSize() > 0) {
                String contentType = filePart.getContentType();

                if (!"image/jpeg".equalsIgnoreCase(contentType) && !"image/jpg".equalsIgnoreCase(contentType)) {
                    session.setAttribute("error", "Only JPEG images are allowed.");
                    response.sendRedirect(request.getContextPath() + "/web/product/editProduct.jsp");
                    return;
                }

                byte[] imageBytes = filePart.getInputStream().readAllBytes();
                String fileName = filePart.getSubmittedFileName();
                String base64 = Base64.getEncoder().encodeToString(imageBytes);

                String imageJson = String.format("{\"fileName\":\"%s\",\"fileType\":\"%s\",\"base64Image\":\"%s\"}", fileName, contentType, base64);
                product.setProductPicture(imageJson);
            }

            em.merge(product);
            tx.commit();

            session.setAttribute("success", "Product updated successfully.");
            response.sendRedirect(request.getContextPath() + "/web/product/product.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            if (tx.isActive()) {
                tx.rollback();
            }

            session.setAttribute("error", "Product update failed.Please try again.");
            response.sendRedirect(request.getContextPath() + "/web/product/editProduct.jsp?id=" + request.getParameter("productId"));
        } finally {
            em.close();
        }
    }
}
