<%@ page import="model.customer.Customer" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/header/main_header.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    String customerId = request.getParameter("customerId");
    Customer customer = new Customer();

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

        String sql = "SELECT * FROM GALAXY.CUSTOMER WHERE CUSTOMER_ID = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, customerId);

        ResultSet rs = stmt.executeQuery();

       if (rs.next()) {
    customer.setCustomerId(rs.getString("CUSTOMER_ID"));
    customer.setCustomerName(rs.getString("CUSTOMER_NAME"));
    customer.setCustomerPassword(rs.getString("CUSTOMER_PASSWORD"));
    customer.setCustomerEmail(rs.getString("CUSTOMER_EMAIL"));
    customer.setCustomerFirstName(rs.getString("CUSTOMER_FIRSTNAME"));
    customer.setCustomerLastName(rs.getString("CUSTOMER_LASTNAME"));
    customer.setCustomerContactNo(rs.getString("CUSTOMER_CONTACTNO"));
    customer.setCustomerAddressNo(rs.getString("CUSTOMER_ADDRESS_NO"));
    customer.setCustomerAddressJalan(rs.getString("CUSTOMER_ADDRESS_JALAN"));
    customer.setCustomerAddressCity(rs.getString("CUSTOMER_ADDRESS_CITY"));
    customer.setCustomerAddressState(rs.getString("CUSTOMER_ADDRESS_STATE"));
    customer.setCustomerAddressCode(rs.getString("CUSTOMER_ADDRESS_CODE"));
    
}
        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("Error loading customer data: " + e.getMessage());
    }

    request.setAttribute("customer", customer);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Customer Information</title>
    </head>
    <body>

        <h1>Edit Customer Information</h1>
        <a href="/galaxy_bookshelf/staff/customerManagementList.jsp">Back to Customer List</a>

        <br><br>

        <div class="form-container">
            <form action="../customerStaffAdminEdit" method="post">
                <input type="hidden" name="action" value="edit">

                <!-- Customer ID (readonly) -->
                <label>Customer ID:</label>
                <input type="text" name="customerId" value="<%= (customer.getCustomerId() != null && !"null".equals(customer.getCustomerId())) ? customer.getCustomerId() : "" %>" readonly /><br>

                <br>

                <!-- Username -->
                <label>Username:</label>
                <input type="text" name="customerName" value="<%= (customer.getCustomerName() != null && !"null".equals(customer.getCustomerName())) ? customer.getCustomerName() : "" %>" required /><br>

                <br>

                <!-- First Name -->
                <label>First Name:</label>
                <input type="text" name="customerFirstName" value="<%= (customer.getCustomerFirstName() != null && !"null".equals(customer.getCustomerFirstName())) ? customer.getCustomerFirstName() : "" %>" /><br>

                <br>

                <!-- Last Name -->
                <label>Last Name:</label>
                <input type="text" name="customerLastName" value="<%= (customer.getCustomerLastName() != null && !"null".equals(customer.getCustomerLastName())) ? customer.getCustomerLastName() : "" %>" /><br>

                <br>

                <!-- Contact Number -->
                <label>Contact No:</label>
                <input type="text" name="customerContactNo" value="<%= (customer.getCustomerContactNo() != null && !"null".equals(customer.getCustomerContactNo())) ? customer.getCustomerContactNo() : "" %>" /><br>

                <br>

                <!-- Email -->
                <label>Email:</label>
                <input type="email" name="customerEmail" value="<%= (customer.getCustomerEmail() != null && !"null".equals(customer.getCustomerEmail())) ? customer.getCustomerEmail() : "" %>" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" readonly/><br>

                <input type="hidden" name="customerPassword" value="<%= (customer.getCustomerPassword() != null && !"null".equals(customer.getCustomerPassword())) ? customer.getCustomerPassword() : "" %>" autocomplete="new-password" />
                <input type="hidden" name="customerAddressNo" value="<%= (customer.getCustomerAddressNo() != null && !"null".equals(customer.getCustomerAddressNo())) ? customer.getCustomerAddressNo() : "" %>" />
                <input type="hidden" name="customerAddressJalan" value="<%= (customer.getCustomerAddressJalan() != null && !"null".equals(customer.getCustomerAddressJalan())) ? customer.getCustomerAddressJalan() : "" %>" />
                <input type="hidden" name="customerAddressCity" value="<%= (customer.getCustomerAddressCity() != null && !"null".equals(customer.getCustomerAddressCity())) ? customer.getCustomerAddressCity() : "" %>" />
                <input type="hidden" name="customerAddressState" value="<%= (customer.getCustomerAddressState() != null && !"null".equals(customer.getCustomerAddressState())) ? customer.getCustomerAddressState() : "" %>" />
                <input type="hidden" name="customerAddressCode" value="<%= (customer.getCustomerAddressCode() != null && !"null".equals(customer.getCustomerAddressCode())) ? customer.getCustomerAddressCode() : "" %>" pattern="\d{5}" />

                <br>

                <!-- Submit Button -->
                <input type="submit" value="Update Information" />
            </form>

        </div>

    </body>
</html>
