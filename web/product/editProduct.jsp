<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="model.product.Product"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;
              charset=UTF-8">
        <link
            href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css"
            rel="stylesheet">
        <title>Edit Product</title>
    </head>
    <body>
        <h1>Edit Product</h1>
        <%
        String err_msg = (String)
       session.getAttribute("error");
        if (err_msg != null) {
        %>
        <div class="alert alert-danger"><%= err_msg
            %></div><br>
            <%
            session.removeAttribute("error");
            }
            String successMsg = (String)
           session.getAttribute("success");
            if (successMsg != null) {
            %>
        <div class="alert alert-success"><%= successMsg
            %></div><br>
            <%
            session.removeAttribute("success");
            }
            %>

        <form method="post" action="<%= request.getContextPath()
              %>/web/product/editProduct.jsp" enctype="multipart/form-data">

            <label for="productId">Product ID:</label>
            <input type="text" name="productId"
                   value="${productData.productId}" disabled>
            <input type="hidden" name="productId"
                   value="${productData.productId}">
            <br><br>
            <label for="productName">Product Name:</label>
            <input type="text" id="productName" name="productName"
                   value="${productData.productName}" required><br><br>
            <label for="editor">Product Description:</label>
            <div id="editor">
                <c:out value="${productData.productInformation}"
                       escapeXml="false" />
            </div>
            <input type="hidden" name="productInformation"
                   id="productInformation"><br><br>
            <label for="productPicture">Product Picture:</label>
            <input type="file" id="productPicture"
                   name="productPicture"><br><br>
            <label for="genreId">Genre:</label>
            <select name="genreId" id="genreId" required>
                <option value="">Select Genre</option>
                <c:forEach var="genre" items="${genreList}">
                    <option value="${genre.genreId}"
                            <c:if test="${genre.genreId ==
                                          productData.genreId.genreId}">selected</c:if>>
                                  ${genre.genreName}
                            </option>
                    </c:forEach>
                </select><br><br>
                <label for="productPrice">Price (RM):</label>
                <input type="number" id="productPrice" name="productPrice"
                       min="0" step="0.1" value="${productData.productPrice}"
                       required><br><br>
                <label for="quantity">Quantity (Unit):</label>
                <input type="number" id="quantity" name="quantity" min="1"
                       value="${productData.quantity}" required><br><br>
                <input type="submit" value="Update">
            </form>
            <script
            src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.js"></script>
            <script>
                var quill = new Quill('#editor', {
                    theme: 'snow'
                });
                quill.root.innerHTML = `<c:out
                    value="${productData.productInformation}" escapeXml="false" />`;
                document.querySelector("form").addEventListener("submit", function
                        () {
                    document.getElementById("productInformation").value =
                            quill.root.innerHTML;
                });
            </script>
        </body>
    </html>