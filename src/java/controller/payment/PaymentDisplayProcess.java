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
import model.payment.PaymentSummary;

/**
 *
 * @author ON YUEN SHERN
 */
public class PaymentDisplayProcess extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerId = "C1"; // You can change this based on session or input

        List<PaymentSummary> paymentSummaries = new ArrayList<>();

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String sql = "SELECT SUBSTR(PAYMENT_ID, 1, LENGTH(PAYMENT_ID) - 2) AS MAIN_PAYMENT_ID, CUSTOMER_ID, PAY_DATETIME, PAY_TYPE_ID, SUM(PAY_PRICE) AS TOTAL_AMOUNT, COUNT(*) AS TOTAL_ITEMS FROM GALAXY.PAYMENT WHERE CUSTOMER_ID = ? GROUP BY SUBSTR(PAYMENT_ID, 1, LENGTH(PAYMENT_ID) - 2), CUSTOMER_ID, PAY_DATETIME, PAY_TYPE_ID ORDER BY PAY_DATETIME DESC";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                PaymentSummary ps = new PaymentSummary();
                ps.setMainPaymentId(rs.getString("MAIN_PAYMENT_ID"));
                ps.setCustomerId(rs.getString("CUSTOMER_ID"));
                ps.setPayDatetime(rs.getTimestamp("PAY_DATETIME"));
                ps.setPayTypeId(rs.getString("PAY_TYPE_ID"));
                ps.setTotalAmount(rs.getDouble("TOTAL_AMOUNT"));
                ps.setTotalItems(rs.getInt("TOTAL_ITEMS"));

                paymentSummaries.add(ps);
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("paymentSummaries", paymentSummaries);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/payment/customer_payment.jsp");
        dispatcher.forward(request, response);
    }
}
