<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

    <table>
        <tr>
            <th>No. </th>
            <th>Genre ID</th>
            <th>Genre Name</th>
            <th colspan="2">Actions</th>
        </tr>
        
        <%-- Display data --%>
        <tr>
            <td>1</td>
            <td>1</td>
            <td>Adventure Book</td>
            <td><a href="#" class="btn btn-success-light"><i class="fas fa-edit"></i> Edit</a></td>
            <td><a href="#" class="btn btn-alert-light"><i class="fas fa-trash-alt"></i> Delete</a></td>
        </tr>
</body>

</html>
