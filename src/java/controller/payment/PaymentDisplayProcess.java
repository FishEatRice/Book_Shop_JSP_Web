package controller.payment;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import java.util.*;
import model.payment.PaymentSummary;

public class PaymentDisplayProcess extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerId = "C1"; // You can change this based on session or input
        Map<String, PaymentSummary> summaryMap = new LinkedHashMap<>();

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            conn.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED); // To avoid locking

            String sql = "SELECT * FROM GALAXY.PAYMENT WHERE CUSTOMER_ID = ? ORDER BY PAY_DATETIME DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String paymentId = rs.getString("PAYMENT_ID");
                String mainPaymentId = paymentId.substring(0, paymentId.length() - 2);

                PaymentSummary ps = summaryMap.getOrDefault(mainPaymentId, new PaymentSummary());

                if (ps.getMainPaymentId() == null) {
                    ps.setMainPaymentId(mainPaymentId);
                    ps.setCustomerId(customerId);
                    ps.setPayDatetime(rs.getTimestamp("PAY_DATETIME"));
                    ps.setPayTypeId(rs.getString("PAY_TYPE_ID"));
                    ps.setTotalAmount(0.0);
                    ps.setTotalItems(0);
                }

                int quantity = rs.getInt("QUANTITY");
                double price = rs.getDouble("PAY_PRICE");

                ps.setTotalAmount(ps.getTotalAmount() + (price * quantity));
                ps.setTotalItems(ps.getTotalItems() + 1);

                summaryMap.put(mainPaymentId, ps);
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        List<PaymentSummary> paymentSummaries = new ArrayList<>(summaryMap.values());
        request.setAttribute("paymentSummaries", paymentSummaries);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/payment/customer_payment.jsp");
        dispatcher.forward(request, response);
    }
}
