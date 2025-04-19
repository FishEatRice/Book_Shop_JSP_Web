<%-- 
    Document   : editProduct
    Created on : 17 Apr 2025, 10:50:09
    Author     : JS
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
    <head>
        <title>Edit Product</title>
    </head>
    <body>
        <h2>Edit Product</h2>
        <form action="ProductController" method="get">
            <input type="hidden" name="action" value="update" />
            <input type="hidden" name="id" value="" />

            Name: <input type="text" name="name" value="" required /><br/>
            Description: <input type="text" name="description" value="" required /><br/>
            Image: <input type="file" name="image" required /><br/>
            <label for="genreId">Genre:</label>
            <select name="genreId" id="genreId" required>
                <option value="">Select Genre</option>
                    <c:forEach var="genre" items="${genreList}">
                        <option value="${genre.genreId}"
                            <c:if test="${genre.genreId == productData.genreId.genreId}">selected</c:if>>
                            ${genre.genreName}
                        </option>
                    </c:forEach>
            </select><br><br>
            Price: <input type="number" min="0.00" step="0.01" name="price" required /><br/>
            Quantity: <input type="number" min="1" name="quantity" required /><br/>

            <button type="submit">Update</button>
        </form>


        <br/>
        <a href="ProductController">Back to Product List</a>
    </body>
</html>

