<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.genre.Genre" %>
<!DOCTYPE html>
<html>

<%
    String title = "Edit Genre | Galaxy BookShelf";
    String heading = "Edit Genre";

    Genre genre_data = (Genre) request.getAttribute("genreData");
%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= title %></title>
</head>

<body>
    <h1><%= heading %></h1>

    <%-- Display error Message --%>
    <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="alert alert-danger">
                <%= error %>
            </div> <br>
    <% } %>

    <form action="<%= request.getContextPath() %>/web/genre/edit_genre.jsp" method="post">
        <label for="genre_id">Genre ID:</label>
        <input type="text" value="<%= genre_data.getGenreId() %>" disabled>
        <input type="hidden" name="genre_id" value="<%= genre_data.getGenreId() %>">
        <br><br>

        <label for="genre_name">Genre Name:</label>
        <input type="text" id="genre_name" name="genre_name" value="<%= genre_data.getGenreName() %>">
        <br><br>
        
        <input type="submit" value="Update">
        <a href="list_genre.jsp" class="btn btn-primary-light">Back to Genre List</a>
</body>

</html>
