<%-- 
    Document   : cart_responds
    Created on : 13 Apr 2025, 6:40:45 PM
    Author     : ON YUEN SHERN
--%>

<%
    String cartResponds = (String) session.getAttribute("cartResponds");

    if (cartResponds != null) {
        if (cartResponds.equals("old_cart")) {
%>
<script>
    alert("The same product is detected in the cart and has been automatically added.");
</script>
<%
        } else if (cartResponds.equals("new_cart")) {
%>
<script>
    alert("Successfully added to cart.");
</script>
<%
        } else if (cartResponds.equals("failed")) {
%>
<script>
    alert("Failed to add to cart.");
</script>
<%
        }
        session.removeAttribute("cartResponds");
    }
%>

