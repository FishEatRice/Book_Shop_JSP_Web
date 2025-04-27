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

/**
 *
 * @author ON YUEN SHERN
 */
public class submit_comment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int ratingStar = Integer.parseInt(request.getParameter("ratingStar"));
        String comment = request.getParameter("comment");
        String paymentId = request.getParameter("paymentId");

        // Make it stop before -
        String mainPaymentId = paymentId.split("-")[0];

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String sql = "UPDATE GALAXY.PAYMENT SET RATING_STAR = ?, COMMENT = ?, STAFF_REPLY = ? WHERE PAYMENT_ID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, ratingStar);
            stmt.setString(2, comment);
            stmt.setString(3, "not yet reply");
            stmt.setString(4, paymentId);

            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("/galaxy_bookshelf/web/payment/payment_details.jsp?mainPaymentId=" + mainPaymentId);
    }
}
