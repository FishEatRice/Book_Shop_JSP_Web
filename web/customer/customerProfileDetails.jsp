<%@ page import="java.sql.*, model.customer.Customer" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/header/main_header.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Profile</title>
    </head>
    <body>
        <%
            String customerId = (String) session.getAttribute("customer_id");
            Customer customer = null;

            if (customerId != null) {
                try {
                    String host = "jdbc:derby://localhost:1527/db_galaxy_bookshelf";
                    String user = "GALAXY";
                    String pass = "GALAXY";
                    Connection conn = DriverManager.getConnection(host, user, pass);
                    String sql = "SELECT * FROM GALAXY.CUSTOMER WHERE CUSTOMER_ID = ?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, customerId);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        customer = new Customer();
                        customer.setCustomerId(rs.getString("CUSTOMER_ID"));
                        customer.setCustomerName(rs.getString("CUSTOMER_NAME"));
                        customer.setCustomerEmail(rs.getString("CUSTOMER_EMAIL"));
                        customer.setCustomerContactNo(rs.getString("CUSTOMER_CONTACTNO"));
                        customer.setCustomerPassword(rs.getString("CUSTOMER_PASSWORD"));
                        customer.setCustomerFirstName(rs.getString("CUSTOMER_FIRSTNAME"));
                        customer.setCustomerLastName(rs.getString("CUSTOMER_LASTNAME"));
                        customer.setCustomerAddressNo(rs.getString("CUSTOMER_ADDRESS_NO"));
                        customer.setCustomerAddressJalan(rs.getString("CUSTOMER_ADDRESS_JALAN"));
                        customer.setCustomerAddressState(rs.getString("CUSTOMER_ADDRESS_STATE"));
                        customer.setCustomerAddressCity(rs.getString("CUSTOMER_ADDRESS_CITY"));
                        customer.setCustomerAddressCode(rs.getString("CUSTOMER_ADDRESS_CODE"));
                    }

                    rs.close();
                    ps.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                }
            }
        %>
        <h3>My Profile Details: </h3>
        <p>User Name: <%= customer.getCustomerName() %></p>
        <p>Full Name: <%= customer.getCustomerFirstName() %> <%= customer.getCustomerLastName() %></p>
        <p>Email: <%= customer.getCustomerEmail() %></p>
        <%
            boolean showAddress = customer != null &&
                                  customer.getCustomerAddressNo() != null && !customer.getCustomerAddressNo().isEmpty() &&
                                  customer.getCustomerAddressJalan() != null && !customer.getCustomerAddressJalan().isEmpty() &&
                                  customer.getCustomerAddressCity() != null && !customer.getCustomerAddressCity().isEmpty() &&
                                  customer.getCustomerAddressCode() != null && !customer.getCustomerAddressCode().isEmpty() &&
                                  customer.getCustomerAddressState() != null && !customer.getCustomerAddressState().isEmpty();
        %>

        <% if (showAddress) { %>
        <p>Address: <br>
            <%= customer.getCustomerAddressNo() %>, <%= customer.getCustomerAddressJalan() %><br>
            <%= customer.getCustomerAddressCode() %> <%= customer.getCustomerAddressCity() %><br>
            <%= customer.getStateName(customer.getCustomerAddressState()) %>
        </p>
        <% } %>

        <%
            String message = (String) session.getAttribute("message");
            String messageType = (String) session.getAttribute("messageType");

            if (message != null) {
        %>
        <p style="color: <%= "success".equals(messageType) ? "green" : "red" %>;">
            <strong><%= message %></strong>
        </p>
        <%
                // Clear message after showing
                session.removeAttribute("message");
                session.removeAttribute("messageType");
            }
        %>

        <h3>Edit Profile:</h3>
        <form action="../customerMyProfile" method="post">
            <label>Customer ID:</label>
            <input type="text" name="customerId" 
                   value="<%= (customer.getCustomerId() != null && !"null".equals(customer.getCustomerId())) ? customer.getCustomerId() : "" %>" 
                   readonly />

            <br><br>

            <label>Username:</label>
            <input type="text" name="customerName" 
                   value="<%= (customer.getCustomerName() != null && !"null".equals(customer.getCustomerName())) ? customer.getCustomerName() : "" %>" 
                   required />

            <br><br>

            <label>First Name:</label>
            <input type="text" name="customerFirstName" 
                   value="<%= (customer.getCustomerFirstName() != null && !"null".equals(customer.getCustomerFirstName())) ? customer.getCustomerFirstName() : "" %>" required/>

            <br><br>

            <label>Last Name:</label>
            <input type="text" name="customerLastName" 
                   value="<%= (customer.getCustomerLastName() != null && !"null".equals(customer.getCustomerLastName())) ? customer.getCustomerLastName() : "" %>" required/>

            <br><br>

            <label>Contact No:</label>
            <input type="text" name="contactNo" 
                   value="<%= (customer.getCustomerContactNo() != null && !"null".equals(customer.getCustomerContactNo())) ? customer.getCustomerContactNo() : "" %>" required/>

            <br><br>

            <label>Old Password:</label>
            <input type="password" name="old_password" required />

            <br>

            <h4><u>If you do not want to change your password, you can leave New Password and Confirm New Password blank.</u></h4>

            <label>New Password:</label>
            <input type="password" name="new_password" />

            <br><br>

            <label>Confirm New Password:</label>
            <input type="password" name="double_new_password" />

            <br>

            <!-- Address -->
            <h3>Address:</h3>
            <label>Address No:</label>
            <input type="text" name="customerAddressNo" 
                   value="<%= (customer.getCustomerAddressNo() != null && !"null".equals(customer.getCustomerAddressNo())) ? customer.getCustomerAddressNo() : "" %>" required/>

            <br><br>

            <label>Street:</label>
            <input type="text" name="customerAddressJalan" 
                   value="<%= (customer.getCustomerAddressJalan() != null && !"null".equals(customer.getCustomerAddressJalan())) ? customer.getCustomerAddressJalan() : "" %>" required/>

            <br><br>

            <label>City:</label>
            <input type="text" name="customerAddressCity" 
                   value="<%= (customer.getCustomerAddressCity() != null && !"null".equals(customer.getCustomerAddressCity())) ? customer.getCustomerAddressCity() : "" %>" required/>

            <br><br>

            <label>State:</label>
            <select name="customerAddressState" required>
                <option value="">-- Please select --</option>
                <option value="ST1" <%= "ST1".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Selangor | RM 5.00</option>
                <option value="ST2" <%= "ST2".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Kuala Lumpur | RM 5.00</option>
                <option value="ST3" <%= "ST3".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Johor | RM 5.00</option>
                <option value="ST4" <%= "ST4".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Penang | RM 5.00</option>
                <option value="ST5" <%= "ST5".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Kedah | RM 5.00</option>
                <option value="ST6" <%= "ST6".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Perak | RM 5.00</option>
                <option value="ST7" <%= "ST7".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Melaka | RM 5.00</option>
                <option value="ST8" <%= "ST8".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Pahang | RM 5.00</option>
                <option value="ST9" <%= "ST9".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Negeri Sembilan | RM 5.00</option>
                <option value="ST10" <%= "ST10".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Putrajaya | RM 5.00</option>
                <option value="ST11" <%= "ST11".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Kelantan | RM 5.00</option>
                <option value="ST12" <%= "ST12".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Terengganu | RM 5.00</option>
                <option value="ST13" <%= "ST13".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Perlis | RM 5.00</option>
                <option value="ST14" <%= "ST14".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Sabah | RM 7.00</option>
                <option value="ST15" <%= "ST15".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Labuan | RM 7.00</option>
                <option value="ST16" <%= "ST16".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Sarawak | RM 7.00</option>
            </select>

            <br><br>

            <label>Postal Code:</label>
            <input type="text" name="customerAddressCode" 
                   value="<%= (customer.getCustomerAddressCode() != null && !"null".equals(customer.getCustomerAddressCode())) ? customer.getCustomerAddressCode() : "" %>" 
                   pattern="\d{5}" required/>

            <br><br>

            <input type="submit" value="Update Information">

        </form>
    </body>
</html>
