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
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.product.Product;

/**
 *
 * @author ASUS
 */
public class productDelete extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("galaxy_bookshelfPU");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                EntityManager em = emf.createEntityManager();
                EntityTransaction tx = em.getTransaction();

                try {
                    tx.begin(); 

                    String productId = request.getParameter("id");
        
                    String query1 = "UPDATE GALAXY.PAYMENT SET PRODUCT_ID = 'Deleted' WHERE PRODUCT_ID = ?";
                    int updatedCount1 = em.createNativeQuery(query1)
                        .setParameter(1, productId)
                        .executeUpdate();

                    String query2 = "DELETE FROM GALAXY.DISCOUNT WHERE PRODUCT_ID = ?";
                    int updatedCount2 = em.createNativeQuery(query2)
                        .setParameter(1, productId)
                        .executeUpdate();

                    String query3 = "DELETE FROM GALAXY.CART WHERE PRODUCT_ID = ?";
                    int updatedCount3 = em.createNativeQuery(query3)
                        .setParameter(1, productId)
                        .executeUpdate();

                    Product product = em.find(Product.class, productId); // SELECT * FROM Product WHERE product_id = ?
                    em.remove(product); // DELETE FROM Product WHERE product_id = ?

                    tx.commit(); 

                    HttpSession session = request.getSession();
                    session.setAttribute("success", "Product deleted successfully.");
                    response.sendRedirect(request.getContextPath() + "/web/product/product.jsp");


                } catch (Exception e) {
                    e.printStackTrace();
                    if (tx != null && tx.isActive()) {
                        tx.rollback(); 
                    }
                
                    HttpSession session = request.getSession();
                    session.setAttribute("error", "Product delete failed, try again later.");
                    response.sendRedirect(request.getContextPath() + "/web/product/product.jsp");
                } finally {
                    em.close(); 
                }
    }

}
