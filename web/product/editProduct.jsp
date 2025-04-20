<%-- 
    Document   : editProduct
    Created on : 17 Apr 2025, 10:50:09
    Author     : JS
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "model.product.Product" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Product</title>
        <link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css" rel="stylesheet">
    </head>
    <body>
        <h2>Edit Product</h2>
        <form action="#" method="post">

            Name: <input type="text" name="name" value="" required /><br/><br>

            <label for="editor">Description:</label> <br><br>
            <div id="editor">
                <textarea id="description" name="description" value="" required></textarea>
            </div><br><br>

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
        <a href="product.jsp">Back to Product List</a>

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

    </body>
</html>

