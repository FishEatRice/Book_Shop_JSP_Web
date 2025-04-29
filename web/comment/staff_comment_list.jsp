<%-- 
    Document   : staff_comment_list
    Created on : 26 Apr 2025, 9:53:29 PM
    Author     : ON YUEN SHERN
--%>

<%@ page import="model.comment.Comment" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>

<%
        List<Comment> comments = (List<Comment>) request.getAttribute("comments");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Galaxy | Comment</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

        <style>
            h2 {
                text-align: center;
                color: #34495e;
                margin-bottom: 20px;
            }

            /* Search & Filters */
            form {
                display: flex;
                justify-content: center;
                gap: 10px;
                margin-bottom: 20px;
            }

            input[type="text"] {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                width: 250px;
            }

            button {
                padding: 8px 12px;
                background-color: #2980b9;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            button:hover {
                background-color: #1f618d;
            }

            /* Filter Links */
            .filter-btn {
                text-decoration: none;
                margin: 0 10px;
                color: #2980b9;
                font-weight: 500;
            }

            .filter-btn:hover {
                text-decoration: underline;
            }

            /* Table */
            table {
                width: 100%;
                border-collapse: collapse;
                background-color: white;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            }

            th, td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: center;
                vertical-align: top;
            }

            th {
                background-color: #ecf0f1;
                font-weight: 600;
            }

            td i.fa-star {
                margin: 0 1px;
            }

            /* Actions */
            td a {
                color: #2980b9;
                margin: 0 5px;
            }

            td a:hover {
                color: #1a5276;
            }

            /* No comment row */
            td[colspan="7"] {
                font-style: italic;
                color: #7f8c8d;
                background-color: #f9f9f9;
            }

            /* Responsive */
            @media (max-width: 768px) {
                table, th, td {
                    font-size: 13px;
                }

                form {
                    flex-direction: column;
                    align-items: center;
                }

                input[type="text"] {
                    width: 100%;
                }

                td, th {
                    padding: 8px;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <h2>Comments List</h2>

        <form method="get" action="/galaxy_bookshelf/web/staff/comment_list.jsp">
            <input type="text" name="search" placeholder="Search by Product Name" required>
            <button type="submit">Search</button>
        </form>

        <br>

        <a class="filter-btn" href="/galaxy_bookshelf/web/staff/comment_list.jsp">All</a> | 
        <a class="filter-btn" href="/galaxy_bookshelf/web/staff/comment_list.jsp?sort=not+yet+reply">Not Yet Reply</a> | 
        <a class="filter-btn" href="/galaxy_bookshelf/web/staff/comment_list.jsp?sort=ignore">Ignore</a>

        <br><br>

        <table border="1">
            <tr>
                <th>No.</th>
                <th>Payment ID</th>
                <th>Product Name</th>
                <th>Rating Star</th>
                <th>Customer Comment</th>
                <th>Comment Reply</th>
                <th>Action</th>
            </tr>
            <%
                int no = 1;
                if (comments != null && !comments.isEmpty()) {
                    for (Comment c : comments) {
            %>
            <tr>
                <td><%= no++ %></td>
                <td><%= c.getPaymentId() %></td>
                <td><%= c.getProductName() %></td>
                <td>
                    <%
                        Integer rating = c.getRatingStar();
                        if (rating == null) rating = 0;
                        for (int i = 1; i <= 5; i++) {
                            if (i <= rating) {
                                out.print("<i class='fa-solid fa-star' style='color: orange;'></i>");
                            } else {
                                out.print("<i class='fa-solid fa-star' style='color: gray;'></i>");
                            }
                        }
                    %>
                </td>
                <td><%= c.getComment() %></td>
                <td><%= c.getReply() %></td>
                <td>
                    <a href="/galaxy_bookshelf/web/staff/staff_reply_page.jsp?paymentId=<%= c.getPaymentId() %>">Edit Comment</a>
                    <% if (c.getReply() == null || !"ignore".equalsIgnoreCase(c.getReply().trim())) { %>
                    | <a href="/galaxy_bookshelf/IgnoreReplyProcess?payment_id=<%= c.getPaymentId() %>" onclick="return confirm('Are you sure you want to ignore this comment?\nThe old reply will be deleted.');">Ignore</a>
                    <% } %>

                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="7">Currently No Comment</td>
            </tr>
            <% } %>
        </table>
    </body>
</html>