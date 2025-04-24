<%-- 
    Document   : crudCustomer
    Created on : Apr 13, 2025, 6:06:32 AM
    Author     : yq
--%>
<%@ page import="java.util.*, controller.customer.crudCustomer, controller.customer.crudCustomer.Customer" %>
<%@ include file="/header/main_header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Management Customer List</h2>
        <table>
            <tr>
                <th># &nbsp; &nbsp; &nbsp;</th>
                <th>CUSTOMER_ID  &nbsp; &nbsp; </th>
                <th>CUSTOMER_NAME &nbsp; &nbsp;</th> 
                <th>CUSTOMER_PASSWORD &nbsp; &nbsp;</th> 
                <th>CUSTOMER_EMAIL &nbsp; &nbsp;</th>
                <th>CUSTOMER_FIRSTNAME &nbsp; &nbsp;</th>
                <th>CUSTOMER_LASTNAME &nbsp; &nbsp;</th>
                <th>CUSTOMER_CONTACTNO  &nbsp; &nbsp;</th>
                <th>CUSTOMER_ADDRESS_JALAN &nbsp; &nbsp;</th> 
                <th>CUSTOMER_ADDRESS_STATE &nbsp; &nbsp;</th> 
                <th>CUSTOMER_ADDRESS_CITY &nbsp; &nbsp;</th>
                <th>CUSTOMER_ADDRESS_CODE &nbsp; &nbsp;</th>
                <th>CUSTOMER_PROFILE &nbsp; &nbsp;</th>
                <th>CUSTOMER_QUESTION_ID  &nbsp; &nbsp;</th>
                <th>CUSTOMER_QUESTION_ANSWER &nbsp; &nbsp;</th> 
                <th>CUSTOMER_REQUEST &nbsp; &nbsp;</th>
                <th>Controller &nbsp; &nbsp;</th>


            </tr>

            <%
           ArrayList<Customer> customerList = crudCustomer.getAllCustomer();
           int count = 0;

           for (Customer c : customerList) {
               count++;
            %>
            <tr>
                <td><%= count %></td>
                <td><%= c.id %></td>
                <td><%= c.name %></td>
                <td><%= c.password %></td>
                <td><%= c.email %></td>
                <td><%= c.firstName %></td>
                <td><%= c.lastName %></td>
                <td><%= c.contactNo %></td>
                <td><%= c.addressJalan %></td>
                <td><%= c.addressState %></td>
                <td><%= c.addressCity %></td>
                <td><%= c.addressCode %></td>
                <td><%= c.profile %></td>
                <td><%= c.questionId %></td>
                <td><%= c.questionAnswer %></td>
                <td><%= c.request %></td>
                <td><a href="/galaxy_bookshelf/staff/editCustomer.jsp?id=<%= c.id %>">Edit</a></td>  <!--pass data-->
                <td><a href="deleteCustomer.jsp?id=<%= c.id %>">Delete</a></td>
                <td></td>
            </tr>
            <%
                }

                while (count < 8) {
                    count++;
            %>
            <tr>
                <td><%= count %></td>
                <td colspan="15">&nbsp;</td>
            </tr>
            <%
                }
            %>
        </table>
    </body>
</html>