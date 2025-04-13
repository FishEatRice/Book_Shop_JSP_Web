<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.genre.Genre" %>
<!DOCTYPE html>
<html>

<%
    String title = "Genre Management | Galaxy BookShelf";
    String heading = "Genre Listing";
%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
    <h1><%= heading %></h1>

    <!-- Add Genre Button -->
    <a href="add_genre.jsp" class="btn btn-primary-light"><i class="fas fa-plus"></i> Add Genre</a> <br><br>

    <table>
        <tr>
            <th>No. </th>
            <th>Genre ID</th>
            <th>Genre Name</th>
            <th colspan="2">Actions</th>
        </tr>
        
        <!-- Display data -->
        <%
            int count = 1; // Initialize count variable
            List<Genre> genre_dataList = (List<Genre>) request.getAttribute("genreData");
            if (genre_dataList != null) {
                for (Genre genre : genre_dataList) {
        %>
                    <tr>
                        <td><%= count++ %></td>
                        <td><%= genre.getGenreId() %></td>
                        <td><%= genre.getGenreName() %></td>
                        <td><a href="edit_genre.jsp?id=<%= genre.getGenreId() %>" class="btn btn-success-light"><i class="fas fa-edit"></i> Edit</a></td>
                        <td>
                        <a href="#" onclick="if(confirm('Are you sure you want to delete this genre ? ')) 
                        { window.location.href='<%= request.getContextPath() %>/web/genre/delete?id=<%= genre.getGenreId() %>'; }" 
                            class="btn btn-alert-light">
                            <i class="fas fa-trash-alt"></i> Delete
                            </a>
                        </td>
</td>
                    </tr>   
        <%
                }
            } else {
        %>
                <tr>
                    <td colspan="5">No genres found.</td>
                </tr>
        <%
            }
        %>
    
</body>

</html>
