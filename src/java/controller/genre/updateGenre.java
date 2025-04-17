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

public class updateGenre extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("galaxy_bookshelfPU");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

                // Return view to edit genre
                String genreId = request.getParameter("id");
                EntityManager em = emf.createEntityManager();
                Genre genre_data = em.find(Genre.class, genreId); // SELECT * FROM genre WHERE genre_id = ?
                request.setAttribute("genreData", genre_data);
                request.getRequestDispatcher("/genre/edit_genre.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                EntityManager em = emf.createEntityManager();
                EntityTransaction tx = em.getTransaction();

            try {
                String genreId = request.getParameter("genre_id");
                String newGenreName = request.getParameter("genre_name").trim();

                tx.begin();

                // Check if the admin update the same genre name
                Genre currentGenre = em.find(Genre.class, genreId);

                if (newGenreName.equalsIgnoreCase(currentGenre.getGenreName())) {
                    request.setAttribute("error", "The name entered is the same as the current one.");
                    request.setAttribute("genreData", currentGenre); 
                    request.getRequestDispatcher("/genre/edit_genre.jsp").forward(request, response);
                    return;
                }
                
                // Check if the new genre name already exists in the database
                Genre existingGenre = null;
                try {
                    existingGenre = em.createNamedQuery("Genre.findByGenreName", Genre.class)
                                      .setParameter("genreName", newGenreName)
                                      .getSingleResult();
                } catch (NoResultException e) {
                    e.printStackTrace(); 
                }
                
                if (existingGenre != null) {
                    request.setAttribute("error", "The genre name already exists.");
                    request.setAttribute("genreData", currentGenre); 
                    request.getRequestDispatcher("/genre/edit_genre.jsp").forward(request, response);
                    return;
                }
                
                // Update genre
                currentGenre.setGenreName(newGenreName); //UPDATE genre SET genre_name = ? WHERE genre_id = ?
                em.merge(currentGenre); // This line should now work properly
                tx.commit();

                HttpSession session = request.getSession();
                session.setAttribute("success", "Genre updated successfully.");
                response.sendRedirect(request.getContextPath() + "/web/genre/list_genre.jsp");

            } catch (Exception e) {
                e.printStackTrace();
                if (tx != null && tx.isActive()) {
                    tx.rollback();
                }

                HttpSession session = request.getSession();
                session.setAttribute("error", "Genre edit failed, try again later.");
                response.sendRedirect(request.getContextPath() + "/web/genre/list_genre.jsp");

            } finally {
                em.close();
            }
    }
}
