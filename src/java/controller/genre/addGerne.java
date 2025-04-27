/*
* Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
* Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
*/
package controller.genre;

import jakarta.persistence.*;
import jakarta.servlet.RequestDispatcher;
import java.util.List;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.genre.Genre;

public class addGerne extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("galaxy_bookshelfPU");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        //return view to add genre
        RequestDispatcher rd = request.getRequestDispatcher("/genre/add_genre.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin(); 
            
            String genreName = request.getParameter("genre_name").trim();

            //Validation
            if (genreName.isEmpty()) {
                request.setAttribute("error", "Genre name cannot be empty.");
                request.setAttribute("genreData", genreName); 
                request.getRequestDispatcher("/genre/add_genre.jsp").forward(request, response);
                return;
            }
            
            List<Genre> existingGenres = em.createNamedQuery(
                    "Genre.findByGenreName", Genre.class)
                    .setParameter("genreName", genreName)
                    .getResultList();
            
            if (!existingGenres.isEmpty()) {
                request.setAttribute("error", "The Genre already exists.");
                request.setAttribute("genreData", genreName); 
                request.getRequestDispatcher("/genre/add_genre.jsp").forward(request, response);
                return;
            }
            
            // Generate a new genre ID
            List<String> lastId = em.createQuery(
                    "SELECT g.genreId FROM Genre g ORDER BY LENGTH(g.genreId) DESC, g.genreId DESC", String.class)
                    .setMaxResults(1)
                    .getResultList();
            
            String genreId = lastId.isEmpty() ? "G1" :
                    "G" + (Integer.parseInt(lastId.get(0).substring(1)) + 1);
            
            Genre genre = new Genre(genreId, genreName);
            
            em.persist(genre); // INSERT INTO genre (genre_id, genre_name) VALUES (?, ?)
            tx.commit(); 
            
            HttpSession session = request.getSession();
            session.setAttribute("success", "Genre added successfully.");
            response.sendRedirect(request.getContextPath() + "/web/genre/list_genre.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null && tx.isActive()) {
                tx.rollback(); 
            }
            
            HttpSession session = request.getSession();
            session.setAttribute("error", "Genre add failed, try again later.");
            response.sendRedirect(request.getContextPath() + "/web/genre/list_genre.jsp");
            
        } finally {
            em.close(); 
        }
        
    }
}
