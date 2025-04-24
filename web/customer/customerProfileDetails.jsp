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
<h2>My Profile</h2>
<form action="/customerMyProfile" method="post">
    <!-- 基本信息 -->
    <h3>My Profile Details</h3>
    <label>Customer ID:</label>
    <input type="text" name="customerId" 
           value="<%= (customer.getCustomerId() != null && !"null".equals(customer.getCustomerId())) ? customer.getCustomerId() : "" %>" 
           readonly /><br>

    <label>Username:</label>
    <input type="text" name="customerName" 
           value="<%= (customer.getCustomerName() != null && !"null".equals(customer.getCustomerName())) ? customer.getCustomerName() : "" %>" 
           required placeholder="请输入用户名" /><br>

    <label>First Name:</label>
    <input type="text" name="customerFirstName" 
           value="<%= (customer.getCustomerFirstName() != null && !"null".equals(customer.getCustomerFirstName())) ? customer.getCustomerFirstName() : "" %>" /><br>

    <label>Last Name:</label>
    <input type="text" name="customerLastName" 
           value="<%= (customer.getCustomerLastName() != null && !"null".equals(customer.getCustomerLastName())) ? customer.getCustomerLastName() : "" %>" /><br>

    <!-- Context -->
    <h3>Context Number </h3>
    <label>Email:</label>
    <input type="email" name="customerEmail" 
           value="<%= (customer.getCustomerEmail() != null && !"null".equals(customer.getCustomerEmail())) ? customer.getCustomerEmail() : "" %>" 
           pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" /><br>

    <label>Password:</label>
    <input type="password" name="customerPassword" 
           value="<%= (customer.getCustomerPassword() != null && !"null".equals(customer.getCustomerPassword())) ? customer.getCustomerPassword() : "" %>" 
           autocomplete="new-password" /><br>

    <!-- Address -->
    <h3>Address</h3>
    <label>Address No:</label>
    <input type="text" name="customerAddressNo" 
           value="<%= (customer.getCustomerAddressNo() != null && !"null".equals(customer.getCustomerAddressNo())) ? customer.getCustomerAddressNo() : "" %>" /><br>

    <label>Street:</label>
    <input type="text" name="customerAddressJalan" 
           value="<%= (customer.getCustomerAddressJalan() != null && !"null".equals(customer.getCustomerAddressJalan())) ? customer.getCustomerAddressJalan() : "" %>" /><br>

    <label>City:</label>
    <input type="text" name="customerAddressCity" 
           value="<%= (customer.getCustomerAddressCity() != null && !"null".equals(customer.getCustomerAddressCity())) ? customer.getCustomerAddressCity() : "" %>" /><br>

    <label>State:</label>
    <input type="text" name="customerAddressState" 
           value="<%= (customer.getCustomerAddressState() != null && !"null".equals(customer.getCustomerAddressState())) ? customer.getCustomerAddressState() : "" %>" /><br>

    <label>Postal Code:</label>
    <input type="text" name="customerAddressCode" 
           value="<%= (customer.getCustomerAddressCode() != null && !"null".equals(customer.getCustomerAddressCode())) ? customer.getCustomerAddressCode() : "" %>" 
           pattern="\d{5}" /><br>


    <input type="submit" value="Update Information">

</form>
<button type="button" onclick="window.location.href='customerDashboard.jsp'">
    Back to Dashboard
</button>

</body>
</html>
