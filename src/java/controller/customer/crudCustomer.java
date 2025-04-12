/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.customer;

/**
 *
 * @author yq
 */
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/crudCustomer")

public class crudCustomer extends HttpServlet {

    private static final String Host = "jdbc:derby://localhost:1527/db_galaxy_bookshelf";
    private static String User = "GALAXY";
    private static String password = "GALAXY";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerName = request.getParameter("name");
        String customerEmail = request.getParameter("email");
        String customerPassword = request.getParameter("password");

        
        
         
        boolean success = CreateCustomer(customerName, customerEmail, customerPassword);
        
        if (success) {
            response.sendRedirect("/galaxy_bookshelf/customer/succes.jsp"); // 注册成功
        } else {
            response.sendRedirect("/galaxy_bookshelf/customer/error.jsp"); // 注册失败
        }
    }

    

    private boolean CreateCustomer(String customerName, String customerPassword, String customerEmail) {
        String queryID = "SELECT MAX(CUSTOMER_ID) FROM GALAXY.CUSTOMER";
        String query = "INSERT INTO GALAXY.CUSTOMER (CUSTOMER_ID,CUSTOMER_NAME, CUSTOMER_PASSWORD, CUSTOMER_EMAIL) VALUES (?,?, ?, ?)";
        
        try (Connection conn = DriverManager.getConnection(Host, User, password)) {

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(queryID);
            String newCustomerId = "c1";

            if (rs.next()) {
                String maxId = rs.getString(1); // 例如：c1, c2, c3
                if (maxId != null && maxId.startsWith("c")) {
                    // 提取数字部分，并增加 1
                    int currentId = Integer.parseInt(maxId.substring(1)); // 获取数字部分：1, 2, 3
                    newCustomerId = "c" + (currentId + 1); // 生成新 ID：c2, c3, c4
                }
            }
            PreparedStatement sstmt = conn.prepareStatement(query);
            sstmt.setString(1, newCustomerId);
            sstmt.setString(2, customerName);
            sstmt.setString(3, customerEmail);
            sstmt.setString(4, customerPassword);

            int rowsAffected = sstmt.executeUpdate(); // 执行插入操作

            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Database connection error: " + e.getMessage());
            return false;
        }
    }

}
