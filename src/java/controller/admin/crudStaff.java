/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.admin;

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

@WebServlet("/crudStaff")
public class crudStaff extends HttpServlet {

    private static final String Host = "jdbc:derby://localhost:1527/db_galaxy_bookshelf";
    private static String User = "GALAXY";
    private static String password = "GALAXY";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String staffFirstName = request.getParameter("firstName");
        String staffLastName = request.getParameter("lastName");
        String staffPassword = "1234";

        boolean success = CreateStaff(staffFirstName, staffLastName, staffPassword);

        if (success) {
            response.sendRedirect("/galaxy_bookshelf/admin/succesStaff.jsp"); // 注册成功
        } else {
            response.sendRedirect("#"); // 注册失败
        }
    }

    private boolean CreateStaff(String staffFirstName, String staffLastName, String staffPassword) {
         String queryID = "SELECT MAX(STAFF_ID) FROM GALAXY.STAFF";
        String query = "INSERT INTO GALAXY.STAFF(STAFF_ID,STAFF_FIRSTNAME,STAFF_LASTNAME,STAFF_PASSWORD) VALUES (?,?, ?,?)";

        try (Connection conn = DriverManager.getConnection(Host, User, password)) {

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(queryID);
            String newStaffId = "s1";
            
             if (rs.next()) {
                String maxId = rs.getString(1); // 例如：c1, c2, c3
                if (maxId != null && maxId.startsWith("s")) {
                    // 提取数字部分，并增加 1
                    int currentId = Integer.parseInt(maxId.substring(1)); // 获取数字部分：1, 2, 3
                    newStaffId = "s" + (currentId + 1); // 生成新 ID：c2, c3, c4
                }
            }
            PreparedStatement sstmt = conn.prepareStatement(query);
            sstmt.setString(1, newStaffId);
            sstmt.setString(2, staffFirstName);
            sstmt.setString(3, staffLastName);
            sstmt.setString(4, staffPassword);
            

            int rowsAffected = sstmt.executeUpdate(); // 执行插入操作
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Database connection error: " + e.getMessage());
            return false;
        }
    }

}
