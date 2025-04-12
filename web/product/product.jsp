<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
        integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <title>Product Management | Galaxy BookShelf</title>
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
    <h1>Product Listing</h1>

    <table>
        <tr>
            <th>No. </th>
            <th>Product ID</th>
            <th>Image</th>
            <th>Product Name</th>
            <th>Genre</th>
            <th>Price (RM)</th>
            <th>Quantity (Unit) </th>
            <th colspan="3">Actions</th>
        </tr>
        <tr>
            <td>1</td>
            <td>1</td>
            <td><img src="#" alt="Product Image"></td>
            <td>Galaxy Book 1</td>
            <td>Adventure Book</td>
            <td>999.99</td>
            <td>50</td>
            <td><a href="#" class="btn btn-success-light"><i class="fas fa-edit"></i> Edit</a></td>
            <td><a href="#" class="btn btn-alert-light"><i class="fas fa-trash-alt"></i> Delete</a></td>
        </tr>
        <tr>
            <td>1</td>
            <td>1</td>
            <td><img src="#" alt="Product Image"></td>
            <td>Galaxy Book 1</td>
            <td>Adventure Book</td>
            <td>999.99</td>
            <td>50</td>
            <td><a href="#" class="btn btn-success-light"><i class="fas fa-edit"></i> Edit</a></td>
            <td><a href="#" class="btn btn-alert-light"><i class="fas fa-trash-alt"></i> Delete</a></td>
        </tr>
    </table>
</body>

</html>
