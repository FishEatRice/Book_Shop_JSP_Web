<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Galaxy | Cart</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <h2>Cart List</h2>

        <c:choose>
            <c:when test="${not empty Cart_Item}">
                <table border="1">
                    <tr>
                        <th><input type="checkbox" id="selectAll" onclick="SelectAllCart(this)" /></th>
                        <th colspan="2">Product</th>
                        <th>Unit Price</th>
                        <th>Quantity</th>
                        <th>Total Price</th>
                        <th>Action</th>
                    </tr>

                    <c:forEach var="item" items="${Cart_Item}">
                        <tr>
                            <td>
                                <input type="checkbox" name="selectedItems" value="${item.cartId}" class="itemCheckbox" />
                            </td>
                            <td><img src="${item.productPic}" alt="${item.productName}" width="100" /></td>
                            <td>${item.productName}</td>
                            <td>RM <fmt:formatNumber value="${item.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
                            <td>
                                Max Quantity Stock: ${item.quantityInStock}
                                <br>
                                <form action="/galaxy_bookshelf/CartQuantityChangeProcess" method="get" style="display: flex; gap: 5px;">
                                    <input type="hidden" name="cart_id" value="${item.cartId}">
                                    <input type="number" name="quantity" value="${item.quantityInCart}" max="${item.quantityInStock}" min="1" required>
                                    <button type="submit">Update</button>
                                </form>
                            </td>
                            <td>
                                RM <fmt:formatNumber value="${item.productPrice * item.quantityInCart}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                            </td>
                            <td>
                                <button type="button" onclick="DeleteCart('${item.cartId}')">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>

                <br>
                <button type="button" onclick="PaySelected()">Pay Selected</button>
            </c:when>

            <c:otherwise>
                <p>Your cart is currently empty.</p>
                <a href="/galaxy_bookshelf/web/product/add_to_cart.jsp">
                    <button>Browse Products</button>
                </a>
            </c:otherwise>
        </c:choose>

        <script>
            function SelectAllCart(source) {
                const checkboxes = document.querySelectorAll('.itemCheckbox');
                checkboxes.forEach(cb => cb.checked = source.checked);
            }

            function DeleteCart(cartId) {
                if (confirm("Are you sure you want to delete this item?")) {
                    window.location.href = '/galaxy_bookshelf/delete_cart?cart_id=' + cartId;
                }
            }

            function PaySelected() {
                const selected = Array.from(document.querySelectorAll('.itemCheckbox'))
                        .filter(cb => cb.checked)
                        .map(cb => cb.value);

                if (selected.length === 0) {
                    alert("Please select at least one item.");
                    return;
                }

                // Debugging: log to console
                console.log("Selected cart IDs:", selected.join(','));

                window.location.href = '/galaxy_bookshelf/web/payment/confirm_payment.jsp?cart_ids=' + encodeURIComponent(selected.join(','));

            }

            // Sync Select All state
            document.addEventListener('DOMContentLoaded', () => {
                const selectAllCheckbox = document.getElementById('selectAll');
                const itemCheckboxes = document.querySelectorAll('.itemCheckbox');

                itemCheckboxes.forEach(cb => {
                    cb.addEventListener('change', () => {
                        const allChecked = Array.from(itemCheckboxes).every(box => box.checked);
                        selectAllCheckbox.checked = allChecked;
                    });
                });
            });
        </script>

    </body>
</html>
