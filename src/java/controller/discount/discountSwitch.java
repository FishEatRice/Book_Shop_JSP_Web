/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.discount;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

/**
 *
 * @author ON YUEN SHERN
 */
public class discountSwitch extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Boolean DiscountSiwtch = false;

        String DISCOUNT_ID = request.getParameter("discount_id");

        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String sql = "SELECT DISCOUNT_SWITCH FROM GALAXY.DISCOUNT WHERE DISCOUNT_ID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, DISCOUNT_ID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                DiscountSiwtch = rs.getBoolean("DISCOUNT_SWITCH");
            }

            // True to false, false to true
            DiscountSiwtch = !DiscountSiwtch;

            String UpdatesSql = "UPDATE GALAXY.DISCOUNT SET DISCOUNT_SWITCH = ? WHERE DISCOUNT_ID = ?";
            PreparedStatement UpdateStml = conn.prepareStatement(UpdatesSql);
            UpdateStml.setBoolean(1, DiscountSiwtch);
            UpdateStml.setString(2, DISCOUNT_ID);
            UpdateStml.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("/galaxy_bookshelf/web/discount/discount_manager.jsp");
    }
}
