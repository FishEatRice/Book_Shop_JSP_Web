package controller.staff;

import model.staff.Staff;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;


public class updateMyProfile extends HttpServlet {

    private static final String Host = "jdbc:derby://localhost:1527/db_galaxy_bookshelf";
    private static String User = "GALAXY";
    private static String passwor = "GALAXY";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
        String staffId = request.getParameter("staffId");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String password = request.getParameter("password");
        

        
        String query = "UPDATE GALAXY.STAFF SET STAFF_FIRSTNAME = ?, STAFF_LASTNAME = ?, STAFF_PASSWORD = ? WHERE STAFF_ID = ?";
        
        try (Connection conn = DriverManager.getConnection(Host, User, passwor);
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, password);
            stmt.setString(4, staffId);

           
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
               
                response.sendRedirect("/galaxy_bookshelf/staff/staffDashboard.jsp");
            } else {
               
                response.sendRedirect("/galaxy_bookshelf/staff/updateError.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();  
            response.sendRedirect("/galaxy_bookshelf/staff/updateError.jsp");
        }
    }
}
