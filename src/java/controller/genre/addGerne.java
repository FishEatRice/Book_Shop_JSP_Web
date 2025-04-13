/*
* Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
* Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
*/
package controller.genre;

import jakarta.persistence.*;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.genre.Genre;

public class addGerne extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("galaxy_bookshelfPU");

    @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher rd = request.getRequestDispatcher("/genre/add_genre.jsp");
        rd.forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
            EntityManager em = emf.createEntityManager();
            EntityTransaction tx = em.getTransaction();

            tx.begin(); // beginTransaction();

            //For auto incrementing the genre_id
            String newGenreId = "G";
            String lastId = em.createQuery(
                "SELECT g.genreId FROM Genre g ORDER BY LENGTH(g.genreId) DESC, g.genreId DESC", String.class)
                .setMaxResults(1) // LIMIT 1 to get the last genreId
                .getSingleResult(); // Get the last genreId

            String genreId = newGenreId + String.format("%d", Integer.parseInt(lastId.substring(1)) + 1);
            
            // Create and save Genre object
            Genre genre = new Genre();
            genre.setGenreId(genreId);
            genre.setGenreName(request.getParameter("genre_name"));
            
            em.persist(genre);

            // Commit the transaction
            tx.commit(); //commitTransaction();
            em.close(); //closeEntityManager();

            // Redirect to the genre listing page
            response.sendRedirect("list_genre.jsp");
    }



}
