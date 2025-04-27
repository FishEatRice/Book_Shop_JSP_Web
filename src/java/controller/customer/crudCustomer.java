package controller.customer;

import model.customer.Customer;
import java.util.ArrayList;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;

public class crudCustomer extends HttpServlet {

    private static final String Host = "jdbc:derby://localhost:1527/db_galaxy_bookshelf";
    private static String User = "GALAXY";
    private static String passwor = "GALAXY";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // crud -delete -create -view ,but no update
        //update  other servlet

        String action = request.getParameter("action");
        String customerId = request.getParameter("customerId");
        String customerName = request.getParameter("name");
        String customerEmail = request.getParameter("email");
        String customerPassword = request.getParameter("password");
        int customerposition = 0;

        Customer customer = new Customer();

        customer.setCustomerName(customerName);
        customer.setCustomerEmail(customerEmail);
        customer.setCustomerPassword(customerPassword);

        if (!"create".equalsIgnoreCase(action)) {
            customerId = request.getParameter("id");
            customer.setCustomerId(customerId);

            //edit
        }

        boolean success = false;

        switch (action) {
            case "create":
                success = CreateCustomer(customer);
                break;

            case "list":
                ArrayList<Customer> customerList = getAllCustomer(); //
                request.setAttribute("customerList", customerList); // 
                request.getRequestDispatcher("/customer/customerManagementList.jsp").forward(request, response);
                return;
            case "delete":
                success = deleteCustomer(customer);
                break;
            default:
                request.setAttribute("failedCustomer", customer);
                response.sendRedirect("/galaxy_bookshelf/customer/error.jsp");
                return;
        }

        if (success) {
            if (action.equals("create")) {
                response.sendRedirect("/galaxy_bookshelf/customer/succes.jsp"); // customer的成功页面
            } else if (action.equals("delete")) {
                response.sendRedirect("/galaxy_bookshelf/staff/customerManagementList.jsp");
            }
        } else {
            if (action.equals("create")) {
                response.sendRedirect("/galaxy_bookshelf/customer/error.jsp"); // customer的失败页面
            } else if (action.equals("delete")) {
                response.sendRedirect("/galaxy_bookshelf/staff/error.jsp");
            }
        }
    }

    private boolean CreateCustomer(Customer customer) {
        String queryID = "SELECT MAX(CUSTOMER_ID) FROM GALAXY.CUSTOMER";
        String query = "INSERT INTO GALAXY.CUSTOMER (CUSTOMER_ID, CUSTOMER_NAME, CUSTOMER_PASSWORD, CUSTOMER_EMAIL) VALUES (?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(Host, User, passwor)) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(queryID);
            String newCustomerId = "C1";

            if (rs.next()) {
                String maxId = rs.getString(1); // 
                if (maxId != null && maxId.startsWith("C")) {
                    int currentId = Integer.parseInt(maxId.substring(1)); // 
                    newCustomerId = "C" + (currentId + 1); //
                }
            }
            customer.setCustomerId(newCustomerId);

            // 
            PreparedStatement sstmt = conn.prepareStatement(query);
            sstmt.setString(1, customer.getCustomerId());
            sstmt.setString(2, customer.getCustomerName());
            sstmt.setString(3, customer.getCustomerPassword());
            sstmt.setString(4, customer.getCustomerEmail());

            int rowsAffected = sstmt.executeUpdate(); // 

            System.out.println("Attempting to insert staff with ID: " + customer.getCustomerId());
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Database connection error: " + e.getMessage());
            return false;
        }
    }

    public static java.util.ArrayList<Customer> getAllCustomer() {
        java.util.ArrayList<Customer> list = new java.util.ArrayList<>();
        String query = "SELECT * FROM GALAXY.CUSTOMER";

        try (Connection conn = DriverManager.getConnection(Host, User, passwor); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getString("CUSTOMER_ID"));
                customer.setCustomerName(rs.getString("CUSTOMER_NAME"));
                customer.setCustomerPassword(rs.getString("CUSTOMER_PASSWORD"));
                customer.setCustomerEmail(rs.getString("CUSTOMER_EMAIL"));
                customer.setCustomerFirstName(rs.getString("CUSTOMER_FIRSTNAME"));
                customer.setCustomerLastName(rs.getString("CUSTOMER_LASTNAME"));
                customer.setCustomerContactNo(rs.getString("CUSTOMER_CONTACTNO"));
                customer.setCustomerAddressNo(rs.getString("CUSTOMER_ADDRESS_NO"));
                customer.setCustomerAddressJalan(rs.getString("CUSTOMER_ADDRESS_JALAN"));
                customer.setCustomerAddressState(rs.getString("CUSTOMER_ADDRESS_STATE"));
                customer.setCustomerAddressCity(rs.getString("CUSTOMER_ADDRESS_CITY"));
                customer.setCustomerAddressCode(rs.getString("CUSTOMER_ADDRESS_CODE"));

                customer.setCustomerQuestionId(rs.getString("CUSTOMER_QUESTION_ID"));
                customer.setCustomerQuestionAnswer(rs.getString("CUSTOMER_QUESTION_ANSWER"));
                list.add(customer);
            }

        } catch (SQLException e) {
            e.printStackTrace();

        }

        System.out.println("Customer list size: " + list.size()); // For debugging
        return list;
    }

    private boolean deleteCustomer(Customer customer) {
        String query = "";
        PreparedStatement stmt;

        try (Connection conn = DriverManager.getConnection(Host, User, passwor)) {

            query = "DELETE FROM GALAXY.CART WHERE CUSTOMER_ID = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, customer.getCustomerId());
            stmt.executeUpdate();

            query = "UPDATE GALAXY.PAYMENT SET CUSTOMER_ID = 'Deleted' WHERE CUSTOMER_ID = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, customer.getCustomerId());
            stmt.executeUpdate();

            query = "DELETE FROM GALAXY.CUSTOMER WHERE CUSTOMER_ID = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, customer.getCustomerId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
