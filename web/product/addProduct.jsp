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
        <link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css" rel="stylesheet">
        <title>Add Product Page</title>
    </head>
    <body>
        <!-- Add New Product -->
        <h1>Add Product</h1>

        <form action="<%= request.getContextPath() %>/web/product/addProduct.jsp" method="post">
            Name: <input type="text" name="name" required /><br/><br>
            
            <label for="editor">Description:</label> <br><br>
            <div id="editor">
                <textarea id="description" name="description" required></textarea>
            </div><br><br>
            
            Image: <input type="file" name="image" required /><br/><br>
            
            <label for="genreId">Genre:</label>
            <select name="genreId" id="genreId" required>
                <option value="">Select Genre</option>
                    <c:forEach var="genre" items="${genreList}">
                        <option value="${genre.genreId}">${genre.genreName}</option>
                    </c:forEach>
            </select><br><br>
            
            Price: <input type="number" min="0.01" step="0.01" name="price" required /><br/><br>
            
            Quantity: <input type="number" min="1" name="quantity" required /><br/><br>

            <input type="submit" value="Add"/><br/><br>
            <a href="product.jsp" class="btn btn-primary-light">Back to Product List</a>
            
            <%-- Editor JS --%>
            <script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.js"></script>
            <script>

            var quill = new Quill('#editor', {
                theme: 'snow'
            });

            document.querySelector('form')?.addEventListener('submit', function () {
                document.querySelector('#productDescription').value = quill.root.innerHTML;
            });
            </script>

        </form>
    </body>
</html>
