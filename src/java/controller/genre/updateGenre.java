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
import model.genre.Genre;

public class updateGenre extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("galaxy_bookshelfPU");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

                // Get the genre ID from the request parameter
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

                tx.begin(); // beginTransaction();

                //Request from form
                String genreId = request.getParameter("genre_id");
                String genreName = request.getParameter("genre_name");
                             
                Genre genre = em.find(Genre.class, genreId);
                // Update the genre object with new values
                genre.setGenreId(genreId);
                genre.setGenreName(genreName);
                
                //update the genre obect
                em.merge(genre); 

                // Commit the transaction
                tx.commit(); //commitTransaction();
                em.close(); //closeEntityManager();

                // Redirect to the genre listing page
                response.sendRedirect("list_genre.jsp");            
                
    }

}
