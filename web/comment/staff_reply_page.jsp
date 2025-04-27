<%-- 
    Document   : staff_reply_page
    Created on : 27 Apr 2025, 2:11:05 AM
    Author     : ON YUEN SHERN
--%>

<%@ page import="model.comment.Comment" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Galaxy | Reply</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <!-- Include Quill stylesheet -->
        <link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <button onclick="goBack()">Back to Comment List</button>

        <% 
            List<Comment> comments = (List<Comment>) request.getAttribute("comments");
            for (Comment c : comments) { 
        %>

        <p>Payment ID : <%= c.getPaymentId() %></p>
        <p>Product Name : <%= c.getProductName() %></p>
        <p>Rating Star : <%
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
        </p>
        <p>Customer Comment : <%= c.getComment() %></p>

        <form action="/galaxy_bookshelf/SubmitReplyProcess" method="post" onsubmit="return prepareReplySubmit()">
            <input type="hidden" name="payment_id" value="<%= c.getPaymentId() %>">

            <h3>Staff Reply:</h3>

            <button type="button" onclick="insertText(1)">Insert 'Thank You'</button>
            <button type="button" onclick="insertText(2)">Insert 'Sorry'</button>

            <br><br>

            <div id="editor"></div>

            <input type="hidden" name="replyMsg" id="replyMsg">

            <br>

            <button type="submit">Submit Reply</button>
        </form>

        <% } %>

        <!-- Text Editor -->
        <script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.js"></script>
        <script>
                const quill = new Quill('#editor', {
                    theme: 'snow'
                });

                function insertText(type) {
                    let text = '';
                    if (type === 1) {
                        text = "Thank you for your feedback! Galaxy will always welcome you.";
                    } else if (type === 2) {
                        text = "Sorry for the inconvenience, Galaxy will work on improving further.";
                    }

                    const range = quill.getSelection();
                    if (range) {
                        // If in key in mode
                        quill.insertText(range.index, text);
                    } else {
                        // If no in key in mode
                        quill.clipboard.dangerouslyPasteHTML(quill.getLength() - 1, text);
                    }
                }

                function prepareReplySubmit() {
                    const content = quill.getText().trim(); // Get plain text and trim whitespace
                    if (content.length === 0) {
                        alert("Reply cannot be empty!");
                        return false;
                    }

                    document.getElementById('replyMsg').value = quill.root.innerHTML;
                    return true;
                }
        </script>

        <!-- Back Button -->
        <script>
            function goBack() {
                if (window.confirm("Are you sure you want to go back? Your changes may not be saved.")) {
                    window.history.back();
                }
            }
        </script>
    </body>
</html>
