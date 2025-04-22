/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.payment;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import java.util.*;
import model.payment.PaymentDetail;

/**
 *
 * @author ON YUEN SHERN
 */
public class DisplayPaymentDetails extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mainPaymentId = request.getParameter("mainPaymentId");

        ArrayList<PaymentDetail> paymentList = new ArrayList<>();

        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String sql = "SELECT * FROM GALAXY.PAYMENT WHERE PAYMENT_ID LIKE ?";

            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, mainPaymentId + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                PaymentDetail p = new PaymentDetail();
                p.setPaymentId(rs.getString("PAYMENT_ID"));
                p.setCustomerId(rs.getString("CUSTOMER_ID"));
                p.setQuantity(rs.getInt("QUANTITY"));
                p.setPayDatetime(rs.getString("PAY_DATETIME"));
                p.setPayTypeId(rs.getString("PAY_TYPE_ID"));
                p.setRatingStar(rs.getInt("RATING_STAR"));
                p.setComment(rs.getString("COMMENT"));
                p.setShippingStatus(rs.getInt("SHIPPING_STATUS"));
                p.setShipDatetime(rs.getString("SHIP_DATETIME"));
                p.setStaffId(rs.getString("STAFF_ID"));
                p.setPayPrice(rs.getDouble("PAY_PRICE"));
                p.setProductName(rs.getString("PRODUCT_NAME"));
                p.setProductId(rs.getString("PRODUCT_ID"));
                paymentList.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("paymentList", paymentList);
        request.getRequestDispatcher("/payment/payment_details.jsp").forward(request, response);
    }
}
