package controller.report;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import java.util.*;
import model.report.report_display;

/**
 *
 * @author ON YUEN SHERN
 */
public class report_main_show extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            conn.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED); // To avoid locking

            String sql = "SELECT * FROM GALAXY.PAYMENT ORDER BY PRODUCT_NAME ASC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            Map<String, report_display> ReportData = new HashMap<>();

            while (rs.next()) {
                String product_name = rs.getString("product_name");
                int quantity = rs.getInt("quantity");
                double price = rs.getDouble("pay_price");

                if (!product_name.equals("Shipping Fee")) {
                    // Check if the product is already in the map
                    report_display existingReport = ReportData.get(product_name);

                    if (existingReport == null) {
                        // First time encountering this product, create a new report_display object
                        report_display newReport = new report_display(product_name, quantity, price * quantity);
                        ReportData.put(product_name, newReport);
                    } else {
                        // Product already encountered, update its quantity and sales
                        existingReport.setQuantity(existingReport.getQuantity() + quantity);
                        existingReport.setSale(existingReport.getSale() + (price * quantity));
                    }
                }
            }

            // Close the resources
            rs.close();
            stmt.close();
            conn.close();

            // Set the product report map as a request attribute
            request.setAttribute("ReportData", ReportData);

            // Forward to the JSP page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/report/report_main.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
