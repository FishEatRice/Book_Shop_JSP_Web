package controller.report;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import model.report.report_display;

public class sales_records extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the report type (daily, monthly, yearly)
        String reportType = request.getParameter("type");

        if (reportType == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Report type is required.");
            return;
        }

        // Set up the database connection
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            // Set the transaction isolation level to avoid locking
            conn.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);

            // Build the SQL query based on the report type (daily, monthly, or yearly)
            String sql = "SELECT * FROM GALAXY.PAYMENT WHERE pay_datetime >= ? ORDER BY pay_datetime ASC";
            PreparedStatement stmt = conn.prepareStatement(sql);

            // Determine the date range filter based on the report type
            String startDate = "";
            switch (reportType) {
                case "daily":
                    // Today's date at midnight
                    startDate = new SimpleDateFormat("yyyy-MM-dd 00:00:00.000").format(new java.util.Date());
                    break;
                case "monthly":
                    // First day of the current month
                    startDate = new SimpleDateFormat("yyyy-MM-01 00:00:00.000").format(new java.util.Date());
                    break;
                case "yearly":
                    // First day of the current year
                    startDate = new SimpleDateFormat("yyyy-01-01 00:00:00.000").format(new java.util.Date());
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid report type.");
                    return;
            }

            // Set the parameter in the SQL query (filter based on date)
            stmt.setString(1, startDate);

            // Execute the query and get the result set
            ResultSet rs = stmt.executeQuery();

            // Prepare the list to store the report data
            List<report_display> reportList = new ArrayList<>();

            while (rs.next()) {
                String productName = rs.getString("product_name");
                int quantity = rs.getInt("quantity");
                double payPrice = rs.getDouble("pay_price");
                Timestamp datetime = rs.getTimestamp("pay_datetime");

                // Add the product data to the list
                report_display report = new report_display(productName, quantity, payPrice * quantity, datetime);
                reportList.add(report);
            }

            // Close the resources
            rs.close();
            stmt.close();
            conn.close();

            // Set the report data as a request attribute
            request.setAttribute("reportList", reportList);
            request.setAttribute("reportType", reportType);

            // Forward the request to the JSP page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/report/sales_report.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the report.");
        }
    }
}
