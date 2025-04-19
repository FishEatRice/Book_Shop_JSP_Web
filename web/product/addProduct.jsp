<%-- 
    Document   : addProduct
    Created on : 19 Apr 2025, 14:14:18
    Author     : JS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Product Page</title>
    </head>
    <body>
        <!-- Add New Product -->
        <h3>Add Product</h3>
        <form action="ProductController" method="get">
            <input type="hidden" name="action" value="create" />
            Name: <input type="text" name="name" required /><br/>
            Description: <input type="text" name="description" required /><br/>
            Image: <input type="file" name="image" required /><br/>
            <label for="genreId">Genre:</label>
            <select name="genreId" id="genreId" required>
                <option value="">Select Genre</option>
                    <c:forEach var="genre" items="${genreList}">
                        <option value="${genre.genreId}">${genre.genreName}</option>
                    </c:forEach>
            </select><br><br>
            Price: <input type="number" min="0.00" step="0.01" name="price" required /><br/>
            Quantity: <input type="number" min="1" name="quantity" required /><br/>
            <button type="submit">Add</button>
        </form>
    </body>
</html>
