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
                <th>CUSTOMER ID</th>
                <th>CUSTOMER NAME</th> 
                <th>CUSTOMER EMAIL</th>
                <th>CUSTOMER CONTACT NO</th>
                <th>ACTION</th>
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
                <td><%= c.getCustomerEmail() %></td>
                <td><%= c.getCustomerContactNo() %></td>

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
    </body>
</html>
