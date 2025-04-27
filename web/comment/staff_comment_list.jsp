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
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <h2>Comments List</h2>

        <form method="get" action="/galaxy_bookshelf/web/staff/comment_list.jsp">
            <input type="text" name="search" placeholder="Search by Product Name" required>
            <button type="submit">Search</button>
        </form>

        <br>

        <a href="/galaxy_bookshelf/web/staff/comment_list.jsp">All</a> | 
        <a href="/galaxy_bookshelf/web/staff/comment_list.jsp?sort=not+yet+reply">Not Yet Reply</a> | 
        <a href="/galaxy_bookshelf/web/staff/comment_list.jsp?sort=ignore">Ignore</a>

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