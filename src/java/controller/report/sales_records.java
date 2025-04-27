package controller.report;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.*;
import model.report.report_display;

public class sales_records extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reportType = request.getParameter("type"); // daily or monthly
        String dateParam = request.getParameter("date"); // date string

        double total_price = 0.0;
        double total_shipping = 0.0;

        if (reportType == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Report type is required.");
            return;
        }

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            conn.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);

            String sql = "SELECT * FROM GALAXY.PAYMENT WHERE pay_datetime >= ? AND pay_datetime < ? ORDER BY pay_datetime ASC";
            PreparedStatement stmt = conn.prepareStatement(sql);

            Calendar cal = Calendar.getInstance();
            Calendar calEnd = Calendar.getInstance();

            String startDateStr = "";
            String endDateStr = "";

            // Setup date formats
            SimpleDateFormat sqlFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
            SimpleDateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat monthFormat = new SimpleDateFormat("yyyy-MM");
            SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");

            if (dateParam == null || dateParam.isEmpty()) {
                // If no date provided, default
                java.util.Date today = new java.util.Date();
                if ("monthly".equalsIgnoreCase(reportType)) {
                    dateParam = monthFormat.format(today); // "yyyy-MM"
                } else if ("yearly".equalsIgnoreCase(reportType)) {
                    dateParam = yearFormat.format(today); // "yyyy"
                } else {
                    dateParam = dayFormat.format(today); // "yyyy-MM-dd"
                }
            }

            if ("monthly".equalsIgnoreCase(reportType)) {
                // Monthly mode
                java.util.Date parsedDate = monthFormat.parse(dateParam);
                cal.setTime(parsedDate);
                cal.set(Calendar.DAY_OF_MONTH, 1); // start of month

                calEnd.setTime(parsedDate);
                calEnd.set(Calendar.DAY_OF_MONTH, 1);
                calEnd.add(Calendar.MONTH, 1); // next month
            } else if ("yearly".equalsIgnoreCase(reportType)) {
                // Yearly mode
                java.util.Date parsedDate = yearFormat.parse(dateParam);
                cal.setTime(parsedDate);
                cal.set(Calendar.DAY_OF_YEAR, 1); // start of year

                calEnd.setTime(parsedDate);
                calEnd.set(Calendar.DAY_OF_YEAR, 1);
                calEnd.add(Calendar.YEAR, 1); // next year
            } else {
                // Daily mode
                java.util.Date parsedDate = dayFormat.parse(dateParam);
                cal.setTime(parsedDate);

                calEnd.setTime(parsedDate);
                calEnd.add(Calendar.DAY_OF_MONTH, 1); // next day
            }

            // Format into strings
            startDateStr = sqlFormat.format(cal.getTime());
            endDateStr = sqlFormat.format(calEnd.getTime());

            stmt.setString(1, startDateStr);
            stmt.setString(2, endDateStr);

            ResultSet rs = stmt.executeQuery();

            List<report_display> reportList = new ArrayList<>();

            while (rs.next()) {
                String productName = rs.getString("product_name");
                int quantity = rs.getInt("quantity");
                double payPrice = rs.getDouble("pay_price");
                Timestamp datetime = rs.getTimestamp("pay_datetime");

                if ("Shipping Fee".equals(productName)) {
                    total_shipping += payPrice;
                } else {
                    total_price += payPrice * quantity;
                    report_display report = new report_display(productName, quantity, payPrice * quantity, datetime);
                    reportList.add(report);
                }
            }

            rs.close();
            stmt.close();
            conn.close();

            request.setAttribute("reportList", reportList);
            request.setAttribute("reportType", reportType);
            request.setAttribute("dateParam", dateParam); // important to show current date in JSP
            request.setAttribute("total_price", total_price);
            request.setAttribute("total_shipping", total_shipping);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/report/sales_report.jsp");
            dispatcher.forward(request, response);

        } catch (ParseException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date format.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the report.");
        }
    }
}
