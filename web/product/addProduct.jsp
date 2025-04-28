<!DOCTYPE html>
<html>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <head>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <title>Galaxy BookShelf | Add Product </title>
    </head>

    <body>
        <%@ include file="/header/main_header.jsp" %>

        <h1>Add Product</h1>

        <a href="/galaxy_bookshelf/web/product/product.jsp">Back to Product List</a>

        <br><br>

        <%
          String err_msg = (String) session.getAttribute("error");
          if (err_msg != null) {
        %>
        <div class="alert alert-danger"><%= err_msg %></div><br>
        <%
        session.removeAttribute("error");
        }
      String successMsg = (String) session.getAttribute("success");
      if (successMsg != null) {
        %>
        <div class="alert alert-success"><%= successMsg %></div><br>
        <%
          session.removeAttribute("success");
        }
        %>

        <form action="<%= request.getContextPath() %>/web/product/addProduct.jsp" method="post" enctype="multipart/form-data">

            <label for="productName">Name:</label>
            <input type="text" id="productName" name="productName"><br><br>

            <label for="editor">Description:</label>
            <div id="editor"></div>
            <input type="hidden" name="productInformation" id="productInformation"><br><br>

            <label for="productPicture">Picture:</label>
            <input type="file" id="productPicture" name="productPicture" accept="image/jpeg"><br><br>

            <label for="genreId">Genre:</label>
            <select name="genreId" id="genreId">
                <option value="">Select Genre</option>
                <c:forEach var="genre" items="${genreList}">
                    <option value="${genre.genreId}">${genre.genreName}</option>
                </c:forEach>
            </select><br><br>

            <label for="price">Price (RM):</label>
            <input type="number" id="productPrice" name="productPrice" min="0" step="0.01"><br><br>

            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity" min="1"><br><br>

            <input type="submit" value="Add">
        </form>

        <!-- Quill JS -->
        <link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.min.js"></script>
        <script>
            var quill = new Quill('#editor', {
                theme: 'snow'
            });

            document.querySelector('form').addEventListener('submit', function () {
                document.querySelector('#productInformation').value = quill.root.innerHTML;
            });
        </script>

    </body>
</html>