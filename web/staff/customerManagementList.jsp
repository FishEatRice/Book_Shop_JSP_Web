<%@ page import="java.util.*, model.customer.Customer" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.customer.crudCustomer" %>
<%@ include file="/header/main_header.jsp" %>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Customer List</title>
        <style>
            table, th, td {
                border: 1px solid black;
                padding: 5px;
            }
        </style>
    </head>
    <body>
        <h2>Management Customer List</h2>
        <table border="1">
            <tr>
                <th>#</th>
                <th>CUSTOMER_ID</th>
                <th>CUSTOMER_NAME</th> 
                <th>CUSTOMER_PASSWORD</th> 
                <th>CUSTOMER_EMAIL</th>
                <th>CUSTOMER_FIRSTNAME</th>
                <th>CUSTOMER_LASTNAME</th>
                <th>CUSTOMER_CONTACTNO</th>
                <th>CUSTOMER__ADDRESS_NO</th>
                <th>CUSTOMER_ADDRESS_JALAN</th> 
                <th>CUSTOMER_ADDRESS_STATE</th> 
                <th>CUSTOMER_ADDRESS_CITY</th>
                <th>CUSTOMER_ADDRESS_CODE</th>
                <th>CUSTOMER_QUESTION_ID</th>
                <th>CUSTOMER_QUESTION_ANSWER</th> 
                <th>ACTION</th> >
            </tr>
            <%
                try{
                //  request take customer data (CRUD custome java)
                ArrayList<Customer> customerList = crudCustomer.getAllCustomer();
                int count = 1;

                // 
                if (customerList != null && !customerList.isEmpty()) {
                    for (Customer c : customerList) {
            %>
            <tr>
                <td><%= count++ %></td>
                <td><%= c.getCustomerId() %></td>
                <td><%= c.getCustomerName() %></td>
                <td><%= c.getCustomerPassword() %></td>
                <td><%= c.getCustomerEmail() %></td>
                <td><%= c.getCustomerFirstName() %></td>
                <td><%= c.getCustomerLastName() %></td>
                <td><%= c.getCustomerContactNo() %></td>
                <td><%= c.getCustomerAddressNo() %></td>
                <td><%= c.getCustomerAddressJalan() %></td>
                <td><%= c.getCustomerAddressState() %></td>
                <td><%= c.getCustomerAddressCity() %></td>
                <td><%= c.getCustomerAddressCode() %></td>
                <td><%= c.getCustomerQuestionId() %></td>
                <td><%= c.getCustomerQuestionAnswer() %></td>
                
                <td>
                    <form action="/galaxy_bookshelf/staff/editCustomer.jsp" method="post" style="display:inline;">
                        <input type="hidden" name="customerId" value="<%= c.getCustomerId() %>" />
                        <input type="submit" value="edit" />
                    </form>
                    <form action="../crudCustomer" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete" />
                        <input type="hidden" name="id" value="<%= c.getCustomerId() %>" />
                        <input type="submit" value="delete" onclick="return confirm('Are you sure to delete this Customer?');" />
                    </form>
                </td>
            </tr>
            <%
                    } //for
                } else {
            %>
            <tr><td colspan="16">No customers found.</td></tr>
            <%
                }
            } catch (Exception e) {
            %>
            <tr><td colspan="5">Error loading staff: <%= e.getMessage() %></td></tr>
            <%
                     }
            %>
        </table>
        <a href="javascript:history.back()">Back to Previous Page</a>
    </body>
</html>
