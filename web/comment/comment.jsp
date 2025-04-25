<%@ page import="model.comment.Comment" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Galaxy | Comment</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
        <!-- Include Quill stylesheet -->
        <link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css" rel="stylesheet" />

        <!-- Rating Star CSS -->
        <style>
            .rating {
                display: inline-block;
                font-size: 30px;
            }

            .star {
                color: #ccc;
                cursor: pointer;
                transition: color 0.3s ease;
            }

            .star:hover, .star.selected {
                color: gold;
            }
        </style>
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <button onclick="goBack()">Back to Payment Details</button>

        <h1>Thank you for your Comment</h1>

        <% 
            // Get the comments list or a single comment if present
            List<Comment> comments = (List<Comment>) request.getAttribute("comments");
            String paymentId = (String) request.getAttribute("paymentId");

            // Check if there's at least one comment
            if (comments != null && !comments.isEmpty()) {
                Comment comment = comments.get(0); // Get the first comment if available
        %>

        <p>Product Name: <%= comment.getProductName() %></p>

        <form action="/galaxy_bookshelf/submit_comment" method="post">
            <!-- Rating stars -->
            Rating Star :
            <div class="rating">
                <span class="star" data-value="1">&#9733;</span>
                <span class="star" data-value="2">&#9733;</span>
                <span class="star" data-value="3">&#9733;</span>
                <span class="star" data-value="4">&#9733;</span>
                <span class="star" data-value="5">&#9733;</span>
            </div>
            <input type="hidden" name="ratingStar" id="ratingStar" value="0" />

            <br><br>

            <div id="editor">
                <br>
            </div>

            <input type="hidden" name="paymentId" value="<%= paymentId %>" />

            <textarea name="comment" id="comment" style="display:none;"></textarea>

            <br>

            <button type="submit">Submit Comment</button>
        </form>

        <!-- Include Quill library -->
        <script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.js"></script>

        <!-- Text editor -->
        <script>
            const quill = new Quill('#editor', {
                theme: 'snow'
            });

            // When the form is submitted, capture the HTML content of the editor and insert it into the hidden textarea
            const form = document.querySelector('form');
            const submitButton = form.querySelector('button[type="submit"]');

            form.onsubmit = function (event) {
                const commentContent = quill.root.innerHTML;
                const rating = document.querySelector('input[name="ratingStar"]').value;

                // Check if the rating is 0 (not selected) or if the comment is empty
                if (rating === "0" || commentContent.trim() === "") {
                    event.preventDefault(); // Prevent form submission
                    alert("(╥﹏╥) At least one rating star, please...");
                } else {
                    // Set the comment content to the hidden textarea before submitting
                    document.querySelector('textarea[name="comment"]').value = commentContent;
                }
            };

            // Handle star clicks and update the hidden input
            const stars = document.querySelectorAll('.star');
            const ratingInput = document.getElementById('ratingStar');

            stars.forEach(star => {
                star.addEventListener('click', function () {
                    const rating = this.getAttribute('data-value');
                    ratingInput.value = rating;

                    // Update the selected stars
                    stars.forEach(s => s.classList.remove('selected'));
                    for (let i = 0; i < rating; i++) {
                        stars[i].classList.add('selected');
                    }
                });
            });

            // Hover
            stars.forEach(star => {
                star.addEventListener('mouseover', function () {
                    const rating = this.getAttribute('data-value');
                    stars.forEach(s => s.classList.remove('selected'));
                    for (let i = 0; i < rating; i++) {
                        stars[i].classList.add('selected');
                    }
                });

                star.addEventListener('mouseout', function () {
                    const rating = ratingInput.value;
                    stars.forEach(s => s.classList.remove('selected'));
                    for (let i = 0; i < rating; i++) {
                        stars[i].classList.add('selected');
                    }
                });
            });

            function goBack() {
                if (window.confirm("Are you sure you want to go back? Your changes may not be saved.")) {
                    window.history.back();
                }
            }

        </script>

        <% } else { %>
        <p>Invalid payment ID or payment details not found.</p>
        <% } %>

    </body>
</html>
