<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
    String title = "Galaxy BookShelf | Add Genre ";
    String heading = "Add Genre";
%>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><%= title %></title>
    </head>
    <body>

        <%@ include file="/header/main_header.jsp" %>

        <h1><%= heading %></h1>

        <%-- Display error Message --%>
        <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
                <div class="alert alert-danger">
                    <%= error %>
                </div> <br>
        <% } %>

        <form action="<%= request.getContextPath() %>/web/genre/add_genre.jsp" method="post">
            <label for="genre_name">Genre Name:</label>
            <input type="text" id="genre_name" name="genre_name">
            <br><br>
            
            <input type="submit" value="Add Genre">          
            <a href="list_genre.jsp" class="btn btn-primary-light">Back to Genre List</a>
        </form>
    </body>
</html>
