package controller.customer;

import model.customer.Customer;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpSession;

public class CustomerLoginFunction extends HttpServlet {

    private static final String Host = "jdbc:derby://localhost:1527/db_galaxy_bookshelf";
    private static final String User = "GALAXY";
    private static final String passwor = "GALAXY";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");

   
        String email = request.getParameter("customer_email");
        String pwd = request.getParameter("customer_password");

      
        HttpSession session = request.getSession();

  
        String existingStatus = (String) session.getAttribute("account_status");
        String existingRole = (String) session.getAttribute("userRole");

        if (existingStatus != null && !"customer".equals(existingRole)) {
            response.sendRedirect(request.getContextPath() + "/web/index.jsp");
            return;
        }


        Customer customer = getCustomerIfValid(email, pwd);
        if (customer != null) {
          
            session.setAttribute("userRole", "customer");                
            session.setAttribute("account_status", customer.getCustomerEmail()); 
            session.setAttribute("customer_email", customer.getCustomerEmail()); 
            session.setAttribute("customer_id", customer.getCustomerId());

            response.sendRedirect(request.getContextPath() + "/web/index.jsp");
        } else {
           
            response.sendRedirect(request.getContextPath() + "/customer/customerLoginError.jsp");
        }
    }
    

    private Customer getCustomerIfValid(String email, String password) {
        String sql = "SELECT * FROM GALAXY.CUSTOMER WHERE CUSTOMER_EMAIL = ? AND CUSTOMER_PASSWORD = ?";

        try (Connection conn = DriverManager.getConnection(Host, User, passwor); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Customer c = new Customer();
                    c.setCustomerId(rs.getString("CUSTOMER_ID"));
                    c.setCustomerEmail(rs.getString("CUSTOMER_EMAIL"));
                    return c;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
