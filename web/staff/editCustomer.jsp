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
    

    customer.setCustomerQuestionId(rs.getString("CUSTOMER_QUESTION_ID"));
    customer.setCustomerQuestionAnswer(rs.getString("CUSTOMER_QUESTION_ANSWER"));
    customer.setCustomerRequest(rs.getInt("CUSTOMER_REQUEST"));
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

        <div class="form-container">
            <form action="../customerStaffAdminEdit" method="post">
                <input type="hidden" name="action" value="edit">

                <!-- Customer ID (readonly) -->
                <label>Customer ID:</label>
                <input type="text" name="customerId" value="<%= (customer.getCustomerId() != null && !"null".equals(customer.getCustomerId())) ? customer.getCustomerId() : "" %>" readonly /><br>

                <!-- Username -->
                <label>Username:</label>
                <input type="text" name="customerName" value="<%= (customer.getCustomerName() != null && !"null".equals(customer.getCustomerName())) ? customer.getCustomerName() : "" %>" required placeholder="请输入用户名" /><br>

                <!-- First Name -->
                <label>First Name:</label>
                <input type="text" name="customerFirstName" value="<%= (customer.getCustomerFirstName() != null && !"null".equals(customer.getCustomerFirstName())) ? customer.getCustomerFirstName() : "" %>" /><br>

                <!-- Last Name -->
                <label>Last Name:</label>
                <input type="text" name="customerLastName" value="<%= (customer.getCustomerLastName() != null && !"null".equals(customer.getCustomerLastName())) ? customer.getCustomerLastName() : "" %>" /><br>

                <!-- Contact Number -->
                <label>Contact No:</label>
                <input type="text" name="customerContactNo" value="<%= (customer.getCustomerContactNo() != null && !"null".equals(customer.getCustomerContactNo())) ? customer.getCustomerContactNo() : "" %>" /><br>

                <!-- Email -->
                <label>Email:</label>
                <input type="email" name="customerEmail" value="<%= (customer.getCustomerEmail() != null && !"null".equals(customer.getCustomerEmail())) ? customer.getCustomerEmail() : "" %>" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" /><br>

                <!-- Password -->
                <label>Password:</label>
                <input type="password" name="customerPassword" value="<%= (customer.getCustomerPassword() != null && !"null".equals(customer.getCustomerPassword())) ? customer.getCustomerPassword() : "" %>" autocomplete="new-password" /><br>

                <!-- Address Section -->
                <h3>Address</h3>
                <label>Address No:</label>
                <input type="text" name="customerAddressNo" value="<%= (customer.getCustomerAddressNo() != null && !"null".equals(customer.getCustomerAddressNo())) ? customer.getCustomerAddressNo() : "" %>" /><br>

                <label>Street:</label>
                <input type="text" name="customerAddressJalan" value="<%= (customer.getCustomerAddressJalan() != null && !"null".equals(customer.getCustomerAddressJalan())) ? customer.getCustomerAddressJalan() : "" %>" /><br>

                <label>City:</label>
                <input type="text" name="customerAddressCity" value="<%= (customer.getCustomerAddressCity() != null && !"null".equals(customer.getCustomerAddressCity())) ? customer.getCustomerAddressCity() : "" %>" /><br>

                <label>State:</label>
                <select name="customerAddressState" required>
                    <option value="">-- Please select --</option>
                    <option value="Selangor" <%= "Selangor".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Selangor | RM 5.00</option>
                    <option value="Kuala Lumpur" <%= "Kuala Lumpur".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Kuala Lumpur | RM 5.00</option>
                    <option value="Johor" <%= "Johor".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Johor | RM 5.00</option>
                    <option value="Penang" <%= "Penang".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Penang | RM 5.00</option>
                    <option value="Kedah" <%= "Kedah".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Kedah | RM 5.00</option>
                    <option value="Perak" <%= "Perak".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Perak | RM 5.00</option>
                    <option value="Melaka" <%= "Melaka".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Melaka | RM 5.00</option>
                    <option value="Pahang" <%= "Pahang".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Pahang | RM 5.00</option>
                    <option value="Negeri Sembilan" <%= "Negeri Sembilan".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Negeri Sembilan | RM 5.00</option>
                    <option value="Putrajaya" <%= "Putrajaya".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Putrajaya | RM 5.00</option>
                    <option value="Kelantan" <%= "Kelantan".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Kelantan | RM 5.00</option>
                    <option value="Terengganu" <%= "Terengganu".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Terengganu | RM 5.00</option>
                    <option value="Perlis" <%= "Perlis".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Perlis | RM 5.00</option>
                    <option value="Sabah" <%= "Sabah".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Sabah | RM 7.00</option>
                    <option value="Labuan" <%= "Labuan".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Labuan | RM 7.00</option>
                    <option value="Sarawak" <%= "Sarawak".equals(customer.getCustomerAddressState()) ? "selected" : "" %>>Sarawak | RM 7.00</option>
                </select><br>

                <label>Postal Code:</label>
                <input type="text" name="customerAddressCode" value="<%= (customer.getCustomerAddressCode() != null && !"null".equals(customer.getCustomerAddressCode())) ? customer.getCustomerAddressCode() : "" %>" pattern="\d{5}" /><br>

                <!-- Security Question Section -->
                <h3>Security Question</h3>


                <label>Question ID:</label>
                <input type="text" name="customerQuestionId" value="<%= (customer.getCustomerQuestionId() != null && !"null".equals(customer.getCustomerQuestionId())) ? customer.getCustomerQuestionId() : "" %>" /><br>

                <label>Answer:</label>
                <input type="text" name="customerQuestionAnswer" value="<%= (customer.getCustomerQuestionAnswer() != null && !"null".equals(customer.getCustomerQuestionAnswer())) ? customer.getCustomerQuestionAnswer() : "" %>" /><br>

                <label>Request:</label>
                <input type="number" name="customerRequest" value="${customer.customerRequest}">


                <!-- Submit Button -->
                <input type="submit" value="Update Information" />
            </form>

            <br><a href="/galaxy_bookshelf/staff/customerManagementList.jsp">Back to Customer List</a>
        </div>

    </body>
</html>
