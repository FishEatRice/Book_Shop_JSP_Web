<%-- 
    Document   : index
    Created on : 11 Apr 2025, 10:20:03 PM
    Author     : Galaxy Brain
--%>

<%@ page import="java.util.List" %>
<%@page import="model.product.Product"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
    <head>
        <title>Galaxy BookShelf | Product Management</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
        integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
    </head>
    <body>

    <%@ include file="/header/main_header.jsp" %>

        <!-- Product Table -->
        <h1>Product Listing</h1>

        <%
            int count = 1;
        %>

    <%-- Notification Message --%>
    <%-- Display Success Message --%>
    <% 
        String success_msg = (String) session.getAttribute("success"); 
        if (success_msg != null) {
    %>
        <div class="alert alert-success">
            <%= success_msg %>
        </div> <br>
    <%
        session.removeAttribute("success"); //clear after display
        }
    %>

    <%-- Display Error Message --%>
    <% 
        String err_msg = (String) session.getAttribute("error");
        if (err_msg != null) {
    %>
        <div class="alert alert-success">
            <%= err_msg %>
        </div> <br>
    <%
        session.removeAttribute("error"); //clear after display
        }
    %>

    <a href="<%= request.getContextPath() %>/web/product/addProduct.jsp" class="btn btn-primary-light"><i class="fas fa-plus"></i> Add Product</a>

    <!-- Search Form -->
    <form action="<%= request.getContextPath() %>/web/product/search" method="get">
        <input type="text" name="query" value="<%= request.getParameter("query") == null ? "" : request.getParameter("query") %>">
        <button type="submit"><i class="fa fa-search"></i> Search</button>
    </form>

    <table border="1" cellpadding="5">
        <tr>
            <th>No.</th>
            <th>ID</th>

            <th>
                <a href="?sortBy=productName&sortOrder=<%="productName".equals(request.getAttribute("sortBy")) && "asc".equals(request.getAttribute("sortOrder")) ? "desc" : "asc" %>">
                    Name
                <i class="<%="productName".equals(request.getAttribute("sortBy")) ? ("asc".equals(request.getAttribute("sortOrder")) ? "fa-solid fa-sort-up" : "fa-solid fa-sort-down") : "fa-solid fa-sort" %>"></i>
                </a>
            </th>
            
            <th>Description</th>
            <th>Image</th>

            <th>
                <a href="?sortBy=genreId&sortOrder=<%= "genreId".equals(request.getAttribute("sortBy")) && "asc".equals(request.getAttribute("sortOrder")) ? "desc" : "asc" %>">
                    Genre
                <i class="<%="genreId".equals(request.getAttribute("sortBy")) ? ("asc".equals(request.getAttribute("sortOrder")) ? "fa-solid fa-sort-up" : "fa-solid fa-sort-down") : "fa-solid fa-sort" %>"></i>
                </a>
            </th>

            <th>Price</th>

            <th>
                <a href="?sortBy=quantity&sortOrder=<%="quantity".equals(request.getAttribute("sortBy")) && "asc".equals(request.getAttribute("sortOrder")) ? "desc" : "asc" %>">
                    Quantity
                <i class="<%="quantity".equals(request.getAttribute("sortBy")) ? ("asc".equals(request.getAttribute("sortOrder")) ? "fa-solid fa-sort-up" : "fa-solid fa-sort-down") : "fa-solid fa-sort" %>"></i>
                </a>   
            </th>
            
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
                <td><fmt:formatNumber value="${product.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
                <td>${product.quantity}</td>
                
                <td>
                    <c:choose> <%-- if --%>
                        <c:when test="${product.quantity <= 9}">
                            <span style="color: red;" title="Low stock">
                                <i class="fa fa-exclamation-triangle"></i>
                            </span>
                        </c:when>

                        <%-- else if --%>
                        <c:when test="${product.quantity <= 19}">
                            <span style="color: yellow;" title="Moderate stock">
                                <i class="fa fa-exclamation-triangle"></i>
                            </span>
                        </c:when>

                        <%-- else --%>
                        <c:otherwise>
                            <span style="color: green;" title="In stock">
                                <i class="fa fa-check-circle"></i>
                            </span>
                        </c:otherwise>
                    </c:choose>             
                </td>

                <td><a href="editProduct.jsp?id=${product.productId}" class="btn btn-success-light"><i class="fas fa-edit"></i> Edit</a></td>
                
                <td>
                    <form action="${pageContext.request.contextPath}/web/product/delete" method="POST" onsubmit="return confirm('Are you sure you want to delete this product?');">
                        <input type="hidden" name="id" value="${product.productId}">
                            <a href="#" class="btn btn-alert-light" onclick="if(confirm('Are you sure you want to delete this product?')) this.closest('form').submit();">
                                <i class="fas fa-trash-alt"></i> Delete
                            </a>
                    </form>
                </td>

            </tr>
        </c:forEach>
    </c:if>
    
    <%-- If product is empty or result not found --%>
    <c:if test="${empty productData}">
        <tr>
            <td colspan="9">No products found.</td>
        </tr>
    </c:if>
    
    </table>
    </body>
</html>
