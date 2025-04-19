/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.product;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.genre.Genre;
import model.product.Product;

/**
 *
 * @author JS
 */
public class productCreate extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("galaxy_bookshelfPU");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher rd = request.getRequestDispatcher("/product/addProduct.jsp");
        rd.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EntityManager em = emf.createEntityManager();

        try {
            em.getTransaction().begin();
            
            List<String> newProductId = em.createQuery("SELECT p.PRODUCT_ID FROM PRODUCT p ORDER BY LENGTH(p.PRODUCT_ID) DESC, p.PRODUCT_ID DESC", String.class)
                    .setMaxResults(1) //LIMIT 1
                    .getResultList();
                
                String productId = newProductId.isEmpty() ? "P1" :
                    "P" + (Integer.parseInt(newProductId.get(0).substring(1)) + 1);
                
            // Create new Product
            Product p = new Product();
            p.setProductName(request.getParameter("Product_Name"));
            p.setProductInformation(request.getParameter("Product_Information"));
            p.setProductPicture(request.getParameter("Product_Picture"));
            String genreId = request.getParameter("GenreID");
            p.setProductPrice(Double.parseDouble(request.getParameter("Product_Price")));
            p.setQuantity(Integer.parseInt(request.getParameter("Quantity")));

            em.persist(p);
            em.getTransaction().commit();

            request.setAttribute("message", "Product created successfully!");

        } catch (Exception e) {
            em.getTransaction().rollback();
            request.setAttribute("error", "Error creating product: " + e.getMessage());
        } finally {
            em.close();
        }

        // Forward to a page (like product list or confirmation)
        RequestDispatcher rd = request.getRequestDispatcher("/productList");
        rd.forward(request, response);
    }

}
