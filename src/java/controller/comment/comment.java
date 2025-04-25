package controller.comment;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import java.util.*;
import model.comment.Comment;

public class comment extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String paymentId = request.getParameter("id");

        List<Comment> comments = new ArrayList<>();

        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String sql = "SELECT * FROM GALAXY.PAYMENT WHERE PAYMENT_ID LIKE ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, paymentId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String productName = rs.getString("PRODUCT_NAME");
                int ratingStar = rs.getInt("RATING_STAR");
                String commentText = rs.getString("COMMENT");

                Comment comment = new Comment(paymentId, productName, ratingStar, commentText);
                comments.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Pass the list of comments or just one comment to the JSP
        request.setAttribute("comments", comments);
        if (!comments.isEmpty()) {
            request.setAttribute("comment", comments.get(0)); // Pass the first comment if there are any
        }
        request.setAttribute("paymentId", paymentId); // Pass paymentId as well
        request.getRequestDispatcher("/comment/comment.jsp").forward(request, response);
    }
}
