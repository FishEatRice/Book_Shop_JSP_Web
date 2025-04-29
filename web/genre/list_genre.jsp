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
        /* Global Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            margin: 20px;
            color: #2c3e50;
        }

        h1 {
            text-align: center;
            color: #34495e;
            margin-bottom: 25px;
        }

        /* Alerts */
        .alert {
            padding: 10px 20px;
            border-radius: 6px;
            margin-bottom: 20px;
            display: inline-block;
        }

        .alert-success {
            background-color: #e0f7e9;
            color: #2e7d32;
            border: 1px solid #2e7d32;
        }

        .alert-alert-warning {
            background-color: #fff8e1;
            color: #f39c12;
            font-weight: bold;
            padding: 10px;
            text-align: center;
        }

        /* Buttons */
        .btn {
            padding: 8px 14px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn i {
            margin-right: 4px;
        }

        .btn-primary-light {
            background-color: #2980b9;
            color: white;
        }

        .btn-success-light {
            background-color: #27ae60;
            color: white;
        }

        .btn-alert-light {
            background-color: #c0392b;
            color: white;
        }

        /* Search Form */
        form {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        form input[type="text"] {
            padding: 6px 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        form button {
            background-color: #34495e;
            color: white;
            padding: 7px 12px;
            border: none;
            border-radius: 4px;
        }

        /* Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
            vertical-align: middle;
        }

        th {
            background-color: #ecf0f1;
            font-weight: 600;
        }

        td {
            background-color: #ffffff;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            table, th, td {
                font-size: 12px;
            }

            form {
                flex-direction: column;
                align-items: flex-start;
            }

            .btn {
                font-size: 12px;
                padding: 6px 10px;
            }
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

        <br><br>

        <!-- Search Feature -->
        <form action="<%= request.getContextPath() %>/web/genre/search" method="get">
            <input type="text" name="query" value="<%= request.getParameter("query") == null ? "" : request.getParameter("query") %>">
            <button type="submit"><i class="fa fa-search"></i> Search</button>
        </form>

        <table>
            <tr>
                <th>No. </th>
                <th>Genre ID</th>
                <th>Genre Name</th>
                <th>Actions</th>
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
                            <div style="display: flex; gap: 6px; justify-content: center;">
                                <a href="edit_genre.jsp?id=${genre.genreId}" class="btn btn-success-light">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <form action="${pageContext.request.contextPath}/web/genre/delete" method="POST" onsubmit="return checkDeleteGenre('${sessionScope.userRole}');" style="margin: 0;">
                                    <input type="hidden" name="id" value="${genre.genreId}">
                                    <button type="submit" class="btn btn-alert-light">
                                        <i class="fas fa-trash-alt"></i> Delete
                                    </button>
                                </form>
                            </div>
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
        <script>
            function checkDeleteGenre(accountType) {
                if (accountType !== 'admin') {
                    alert('Low permission. You cannot delete this genre.');
                    return false;
                }
                return confirm('Please remove all products with this genre type before deleting.\n\nAre you sure you want to delete this genre?');
            }
        </script>

    </body>

</html>
