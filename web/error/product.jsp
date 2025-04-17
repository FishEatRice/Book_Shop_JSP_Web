<%-- 
    Document   : index
    Created on : 11 Apr 2025, 10:20:03 PM
    Author     : Galaxy Brain
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.product.Product" %>
<%@ page import="java.util.List" %>
<%
    
%>
<html>
    <head>
        <title>Product Management</title>
    </head>
    <body>
        <h2>Product List - Role: </h2>

        <!-- Search Form -->
        <form action="ProductController" method="get">
            <input type="text" name="keyword" placeholder="Search by name" />
            <input type="hidden" name="action" value="search" />
            <button type="submit">Search</button>
        </form>

        <!-- Add New Product -->
        <h3>Add Product</h3>
        <form action="ProductController" method="get">
            <input type="hidden" name="action" value="create" />
            Name: <input type="text" name="name" required /><br/>
            Description: <input type="text" name="description" required /><br/>
            Image: <input type="file" name="image" required /><br/>
            Genre: <input type="number" name="genre" required /><br/>
            Price: <input type="number" min="0.00" step="0.01" name="price" required /><br/>
            Quantity: <input type="number" min="1" name="quantity" required /><br/>
            <button type="submit">Add</button>
        </form>

        <%
            int count = 1;
        %>
        <!-- Product Table -->
        <h3>Product List</h3>
        <table border="1" cellpadding="5">
            <tr>
                <th>No.</th>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Image</th>
                <th>Genre</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>

            <tr style="">
                <td><%= count++ %></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td>


                    <strong> (Low Stock!)</strong>

                </td>

                <td>
                    <form action="ProductController" method="get" style="display:inline;">
                        <input type="hidden" name="action" value="edit" />
                        <input type="hidden" name="id" value="" />
                        <button type="submit">Edit</button>
                    </form>


                    <form action="ProductController" method="get" style="display:inline;">
                        <input type="hidden" name="action" value="delete" />
                        <input type="hidden" name="id" value="" />
                        <button type="submit" onclick="return confirm('Are you sure to delete?')">Delete</button>
                    </form>

                </td>
            </tr>

        </table>
    </body>
</html>

