/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.admin;

/**
 *
 * @author yq
 */
import model.staff.Staff;
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

        String action = request.getParameter("action");

        String staffFirstName = request.getParameter("firstName");
        String staffLastName = request.getParameter("lastName");
        String staffPassword = "1234";
        int staffPosition = 1;

        Staff staff = new Staff();

        staff.setFirstName(staffFirstName);
        staff.setLastName(staffLastName);
        staff.setStaffPassword(staffPassword);
        staff.setPosition(staffPosition);

        if (!"create".equalsIgnoreCase(action)) {
            String staffId = request.getParameter("id");
            staff.setStaffId(staffId);
        }

        boolean success = false;

        switch (action) {
            case "create":
                success = CreateStaff(staff);
                break;
            case "edit":
                success = updateStaff(staff);
                break;
            case "delete":
                success = deleteStaff(staff);
                break;
            default:
                success = false;
        }

        if (success) {
            response.sendRedirect("/galaxy_bookshelf/admin/succesStaff.jsp"); // 注册成功
        } else {
            request.setAttribute("failedStaff", staff);
            request.getRequestDispatcher("/admin/failStaff.jsp").forward(request, response); // 使用 forward 传数据
        }

    }

    private boolean CreateStaff(Staff staff) {
        String queryID = "SELECT STAFF_ID FROM GALAXY.STAFF ORDER BY CAST(SUBSTR(STAFF_ID, 2) AS INT) DESC FETCH FIRST 1 ROW ONLY";

        String query = "INSERT INTO GALAXY.STAFF(STAFF_ID,STAFF_FIRSTNAME,STAFF_LASTNAME,STAFF_PASSWORD,POSITION) VALUES (?,?,?,?,?)";

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
            staff.setStaffId(newStaffId);

            PreparedStatement sstmt = conn.prepareStatement(query);
            sstmt.setString(1, staff.getStaffId());
            sstmt.setString(2, staff.getFirstName());
            sstmt.setString(3, staff.getLastName());
            sstmt.setString(4, staff.getStaffPassword());
            sstmt.setInt(5, staff.getPosition());

            int rowsAffected = sstmt.executeUpdate(); // 执行插入操作
            System.out.println("Attempting to insert staff with ID: " + staff.getStaffId());

            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Database connection error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }

    }

    public static java.util.ArrayList<Staff> getAllStaff() {
        java.util.ArrayList<Staff> list = new java.util.ArrayList<>();

        String query = "SELECT * FROM GALAXY.STAFF";
        try (Connection conn = DriverManager.getConnection(Host, User, password); PreparedStatement stmt = conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Staff staff = new Staff();
                staff.setStaffId(rs.getString("STAFF_ID"));
                staff.setFirstName(rs.getString("STAFF_FIRSTNAME"));
                staff.setLastName(rs.getString("STAFF_LASTNAME"));
                staff.setStaffPassword(rs.getString("STAFF_PASSWORD"));
                staff.setPosition(rs.getInt("POSITION"));
                list.add(staff);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching staff list: " + e.getMessage());
        }

        return list;
    }

    private boolean updateStaff(Staff staff) {
        String query = "UPDATE GALAXY.STAFF SET STAFF_FIRSTNAME = ?, STAFF_LASTNAME = ?, STAFF_PASSWORD = ?, POSITION = ? WHERE STAFF_ID = ?";
        try (Connection conn = DriverManager.getConnection(Host, User, password)) {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, staff.getFirstName());
            stmt.setString(2, staff.getLastName());
            stmt.setString(3, staff.getStaffPassword());
            stmt.setInt(4, staff.getPosition());
            stmt.setString(5, staff.getStaffId());  // 使用已有的staffId进行更新
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean deleteStaff(Staff staff) {
        String query = "DELETE FROM GALAXY.STAFF WHERE STAFF_ID = ?";

        try (Connection conn = DriverManager.getConnection(Host, User, password)) {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, staff.getStaffId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
