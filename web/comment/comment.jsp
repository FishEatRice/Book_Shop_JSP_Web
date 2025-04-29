<%@ page import="model.comment.Comment" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Galaxy | Comment</title>
        <link rel="icon" href="/galaxy_bookshelf/picture/web_logo.png" type="image/x-icon">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Quill Editor -->
        <link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css" rel="stylesheet">

        <style>
            .container {
                max-width: 800px;
                margin: auto;
                background-color: #ffffff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            }

            h1 {
                text-align: center;
                color: #34495e;
                margin-bottom: 20px;
            }

            p {
                font-size: 16px;
                color: #333;
                margin-bottom: 20px;
                text-align: center;
            }

            .rating {
                text-align: center;
                margin-bottom: 20px;
            }

            .star {
                font-size: 32px;
                color: #ccc;
                cursor: pointer;
                transition: color 0.3s ease;
            }

            .star:hover, .star.selected {
                color: gold;
            }

            #editor {
                height: 150px;
                margin-bottom: 20px;
                background-color: #fff;
            }

            button, .btn {
                background-color: #3498db;
                color: #fff;
                border: none;
                padding: 12px 20px;
                border-radius: 8px;
                font-size: 16px;
                cursor: pointer;
                transition: background 0.3s ease;
            }

            .back-button {
                margin-bottom: 15px;
                display: inline-block;
                text-decoration: none;
                color: #2980b9;
                font-weight: bold;
                border: none;
                background: none;
                font-size: 14px;
                cursor: pointer;
            }


            @media (max-width: 600px) {
                .star {
                    font-size: 24px;
                }
            }

            .submit-btn:hover{
                background-color: #8cc5eb;
            }
        </style>
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <div class="container">
            <button class="back-button" onclick="goBack()">← Back to Payment Details</button>

            <h1>Thank You for Your Comment</h1>

            <%
                List<Comment> comments = (List<Comment>) request.getAttribute("comments");
                String paymentId = (String) request.getAttribute("paymentId");

                if (comments != null && !comments.isEmpty()) {
                    Comment comment = comments.get(0);
            %>
            <p><strong>Product Name:</strong> <%= comment.getProductName() %></p>

            <form action="/galaxy_bookshelf/submit_comment" method="post">
                <div class="rating">
                    Rating:
                    <br>
                    <span class="star" data-value="1">&#9733;</span>
                    <span class="star" data-value="2">&#9733;</span>
                    <span class="star" data-value="3">&#9733;</span>
                    <span class="star" data-value="4">&#9733;</span>
                    <span class="star" data-value="5">&#9733;</span>
                    <input type="hidden" name="ratingStar" id="ratingStar" value="0">
                </div>

                <div id="editor"><br></div>

                <input type="hidden" name="paymentId" value="<%= paymentId %>">
                <textarea name="comment" id="comment" style="display:none;"></textarea>

                <div style="text-align: center;">
                    <button class="submit-btn" type="submit">Submit Comment</button>
                </div>
            </form>
            <% } else { %>
            <p>Invalid payment ID or payment details not found.</p>
            <% } %>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.js"></script>
        <script>
                const quill = new Quill('#editor', {theme: 'snow'});
                const form = document.querySelector('form');
                const stars = document.querySelectorAll('.star');
                const ratingInput = document.getElementById('ratingStar');

                form.onsubmit = function (event) {
                    const content = quill.root.innerHTML.trim();
                    if (ratingInput.value === "0" || content === "" || content === "<p><br></p>") {
                        event.preventDefault();
                        alert("(╥﹏╥) Please provide a rating and a comment!");
                    } else {
                        document.getElementById('comment').value = content;
                    }
                };

                stars.forEach(star => {
                    star.addEventListener('click', function () {
                        const rating = this.getAttribute('data-value');
                        ratingInput.value = rating;
                        updateStars(rating);
                    });

                    star.addEventListener('mouseover', function () {
                        updateStars(this.getAttribute('data-value'));
                    });

                    star.addEventListener('mouseout', function () {
                        updateStars(ratingInput.value);
                    });
                });

                function updateStars(rating) {
                    stars.forEach((s, index) => {
                        s.classList.toggle('selected', index < rating);
                    });
                }

                function goBack() {
                    if (confirm("Are you sure you want to go back? Your changes may not be saved.")) {
                        window.history.back();
                    }
                }
        </script>
    </body>
</html>
