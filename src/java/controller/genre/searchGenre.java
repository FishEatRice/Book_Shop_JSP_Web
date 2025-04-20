/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.genre;

import jakarta.persistence.*;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.genre.Genre;

public class searchGenre extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("galaxy_bookshelfPU");
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

            String query = request.getParameter("query");
            EntityManager em = emf.createEntityManager();

            //When searching by id
            List<Genre> genre_dataList = em.createNamedQuery("Genre.findByGenreId", Genre.class)
                    .setParameter("genreId", query)
                    .getResultList();

            //When searching by name
            if (genre_dataList.isEmpty()) {
                String findByName = "%" + query + "%";
                genre_dataList = em.createNamedQuery("Genre.findByGenreName", Genre.class)
                    .setParameter("genreName", findByName)
                    .getResultList();
            }

            //return result to JSP
            request.setAttribute("genreData", genre_dataList); 
            request.getRequestDispatcher("/genre/list_genre.jsp").forward(request, response);

            em.close();
    }
}