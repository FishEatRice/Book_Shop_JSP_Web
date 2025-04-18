<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Mock Payment Page</title>
    </head>
    <body>
        <h2>Select Payment Method</h2>
        <form action="/galaxy_bookshelf/web/payment/process.jsp" method="post">
            Customer ID: <input type="text" name="customer_id" required><br>
            Product ID: <input type="text" name="product_id" required><br>
            Quantity: <input type="number" name="quantity" required><br>
            Payment Method:
            <select name="pay_type">
                <option value="card">Card</option>
                <option value="fpx">FPX (Online Banking)</option>
                <option value="tng">Touch 'n Go</option>
                <option value="cod">Cash on Delivery</option>
            </select><br><br>
            <button type="submit">Pay Now</button>
        </form>

    </body>
</html>
