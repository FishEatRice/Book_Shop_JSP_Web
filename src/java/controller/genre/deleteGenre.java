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

public class deleteGenre extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("galaxy_bookshelfPU");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

                EntityManager em = emf.createEntityManager();
                EntityTransaction tx = em.getTransaction();

                tx.begin(); // beginTransaction();

                //Request from parameter
                String genreId = request.getParameter("id");
                
                Genre genre = em.find(Genre.class, genreId); // SELECT * FROM genre WHERE genre_id = ?
 
                em.remove(genre); // DELETE FROM genre WHERE genre_id = ?

                // Commit the transaction
                tx.commit(); //commitTransaction();
                em.close(); //closeEntityManager();

                // Redirect to the genre listing page
                response.sendRedirect("list_genre.jsp"); 
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
