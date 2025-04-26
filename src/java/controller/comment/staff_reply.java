/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.comment;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import java.util.*;
import model.comment.Comment;

/**
 *
 * @author ON YUEN SHERN
 */
public class staff_reply extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Comment> comments = new ArrayList<>();

        String sort = request.getParameter("sort");
        if (sort == null || sort.trim().isEmpty()) {
            sort = "%%";
        }

        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String sql = "";

            if (sort.equals("ignore")) {
                sql = "SELECT * FROM GALAXY.PAYMENT WHERE CAST(STAFF_REPLY AS VARCHAR(1000)) != 'no comment' AND CAST(STAFF_REPLY AS VARCHAR(1000)) LIKE ?";
            } else {
                sql = "SELECT * FROM GALAXY.PAYMENT WHERE CAST(STAFF_REPLY AS VARCHAR(1000)) != 'no comment' AND CAST(STAFF_REPLY AS VARCHAR(1000)) != 'ignore' AND CAST(STAFF_REPLY AS VARCHAR(1000)) LIKE ?";
            }

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, sort);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String paymentId = rs.getString("PAYMENT_ID");
                String productName = rs.getString("PRODUCT_NAME");
                int ratingStar = rs.getInt("RATING_STAR");
                String commentText = rs.getString("COMMENT");
                String reply = rs.getString("STAFF_REPLY");

                Comment comment = new Comment(paymentId, productName, ratingStar, commentText, reply);
                comments.add(comment);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("comments", comments);
        request.getRequestDispatcher("/comment/staff_comment_list.jsp").forward(request, response);
    }
}
