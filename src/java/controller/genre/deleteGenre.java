/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.genre;

import jakarta.persistence.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.genre.Genre;

public class deleteGenre extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("galaxy_bookshelfPU");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

                EntityManager em = emf.createEntityManager();
                EntityTransaction tx = em.getTransaction();

                try {
                    tx.begin(); 

                    String genreId = request.getParameter("id");

                    Genre genre = em.find(Genre.class, genreId); // SELECT * FROM genre WHERE genre_id = ?
                    em.remove(genre); // DELETE FROM genre WHERE genre_id = ?

                    tx.commit(); 

                    HttpSession session = request.getSession();
                    session.setAttribute("success", "Genre deleted successfully.");
                    response.sendRedirect(request.getContextPath() + "/web/genre/list_genre.jsp");


                } catch (Exception e) {
                    e.printStackTrace();
                    if (tx != null && tx.isActive()) {
                        tx.rollback(); 
                    }
                
                    HttpSession session = request.getSession();
                    session.setAttribute("error", "Genre delete failed, try again later.");
                    response.sendRedirect(request.getContextPath() + "/web/genre/list_genre.jsp");
                } finally {
                    em.close(); 
                }

    }
}
