<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.genre.Genre" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>

<%
    String title = "Galaxy BookShelf | Genre Management";
    String heading = "Genre Listing";
%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
    <title><%= title %></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
        integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>

<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }
</style>

<body>

    <%@ include file="/header/main_header.jsp" %>

    <h1><%= heading %></h1>

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
    
    <!-- Add Genre Button -->
    <a href="<%= request.getContextPath() %>/web/genre/add_genre.jsp" class="btn btn-primary-light"><i class="fas fa-plus"></i> Add Genre</a>

    <!-- Search Feature -->
    <form action="<%= request.getContextPath() %>/web/genre/search" method="get">
        <input type="text" name="query" value="<%= request.getParameter("query") == null ? "" : request.getParameter("query") %>">
        <button type="submit"><i class="fa fa-search"></i> Search</button>
    </form>

    <br><br>

    <table>
        <tr>
            <th>No. </th>
            <th>Genre ID</th>
            <th>Genre Name</th>
            <th colspan="2">Actions</th>
        </tr>

        <%
            int count = 1;
        %>

        <!-- Display data -->
        
        <%-- If result found --%>
        <c:if test="${not empty genreData}">
            <c:forEach var="genre" items="${genreData}">
                <tr>
                    <td><%= count++  %></td>
                    <td>${genre.genreId}</td>
                    <td>${genre.genreName}</td>

                    <td>
                        <a href="edit_genre.jsp?id=${genre.genreId}" class="btn btn-success-light">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                    </td>

                    <td>
                        <form action="${pageContext.request.contextPath}/web/genre/delete" method="POST" onsubmit="return confirm('Are you sure you want to delete this genre?');">
                            <input type="hidden" name="id" value="${genre.genreId}">
                                <a href="#" class="btn btn-alert-light" onclick="if(confirm('Please remove all the product that having this genre type before delete the genre.\n\nAre you sure you want to delete this genre?')) this.closest('form').submit();">
                                    <i class="fas fa-trash-alt"></i> Delete
                                </a>
                        </form>
                    </td>

                </tr>
            </c:forEach>
        </c:if>

        <!-- If genre is empty or result not found -->
        <c:if test="${empty genreData}">
            <tr>
                <td colspan="5" class="alert-alert-warning">No genres found.</td>
            </tr>
        </c:if>
    </table>
</body>

</html>
