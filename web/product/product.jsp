<%-- 
    Document   : index
    Created on : 11 Apr 2025, 10:20:03 PM
    Author     : Galaxy Brain
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.product.Product" %>
<%@ page import="java.util.List" %>
<%@page import="model.product.Product"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
    <head>
        <title>Product Management</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
        integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
        <h2>Product List - Role: </h2>

        <!-- Search Form -->
        <form action="ProductController" method="get">
            <input type="text" name="keyword" placeholder="Search by name" />
            <input type="hidden" name="action" value="search" />
            <button type="submit">Search</button>
        </form>

        

        <%
            int count = 1;
        %>
        <!-- Product Table -->
        <h1>Product Listing</h1>

    <%-- Notification Message --%>


    <a href="<%= request.getContextPath() %>/web/product/addProduct.jsp" class="btn btn-primary-light"><i class="fas fa-plus"></i> Add Product</a>



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
            <th colspan="2">Actions</th>  
        </tr>

    <c:if test="${not empty productData}">
        <c:forEach var="product" items="${productData}">
            <tr>
                <td><%= count++ %></td>
                <td>${product.productId}</td>
                <td>${product.productName}</td>

                <%-- Limit thw word to 100 (length) --%>
                <c:choose>
                    <c:when test="${fn:length(product.productInformation) > 100}">
                        <td>${fn:substring(product.productInformation, 0, 100)}...</td>
                    </c:when>
                <c:otherwise>
                    <td>${product.productInformation}</td>
                </c:otherwise>
                </c:choose>

                <td>
                    <c:if test="${not empty product.productPicture}">
                        <img src="${product.productPicture}" width="100" height="100" alt="Product Image"/>
                    </c:if>
                </td>

                <td>${product.genreId.genreName}</td>
                <td>${product.productPrice}</td>
                <td>${product.quantity}</td>
                
                <td>
                    <c:choose>
                        <c:when test="${product.quantity < 10}">
                            <span style="color: red;">
                                <i class="fa fa-exclamation-triangle"></i>
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span style="color: green;">
                                <i class="fa fa-check-circle"></i>
                            </span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <td><a href="editProduct.jsp?id=${product.productId}" class="btn btn-success-light"><i class="fas fa-edit"></i> Edit</a></td>
                <td><a href="#" class="btn btn-alert-light"><i class="fas fa-trash-alt"></i> Delete</a></td>
            </tr>
        </c:forEach>
    </c:if>
    
    <c:if test="${empty productData}">
        <tr>
            <td colspan="9">No products found.</td>
        </tr>
    </c:if>
    
    </table>
    </body>
</html>
