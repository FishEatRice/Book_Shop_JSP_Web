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
            /* Header */
            h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 20px;
            }

            /* Table Styling */
            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            }

            th, td {
                padding: 12px;
                border: 1px solid #ccc;
                text-align: center;
            }

            th {
                background-color: #2c3e50;
                color: #fff;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            /* Action Buttons */
            input[type="submit"] {
                background-color: #3498db;
                border: none;
                color: white;
                padding: 6px 12px;
                margin: 2px;
                cursor: pointer;
                font-size: 14px;
                border-radius: 4px;
                transition: background-color 0.3s ease;
            }

            input[type="submit"]:hover {
                background-color: #2980b9;
            }

            /* Confirmation & messages */
            td[colspan="16"], td[colspan="5"] {
                text-align: center;
                font-style: italic;
                color: #888;
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
