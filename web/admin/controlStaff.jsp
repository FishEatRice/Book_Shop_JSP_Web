<%@ page import="java.util.ArrayList" %>
<%@ page import="model.staff.Staff" %>
<%@ page import="controller.admin.crudStaff" %>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Galaxy | Staff List</title>
        <link rel="icon" type="image/x-icon" href="/galaxy_bookshelf/picture/web_logo.png" />

        <style>
            h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 20px;
            }

            /* Table layout */
            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            }

            th, td {
                border: 1px solid #ccc;
                padding: 12px;
                text-align: center;
            }

            th {
                background-color: #2c3e50;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            /* Buttons */
            input[type="submit"] {
                background-color: #2980b9;
                color: white;
                padding: 6px 12px;
                border: none;
                border-radius: 4px;
                margin: 2px;
                cursor: pointer;
                font-size: 14px;
                transition: background-color 0.3s ease;
            }

            input[type="submit"]:hover {
                background-color: #1f6391;
            }

            /* Special message for Admin */
            span {
                font-weight: bold;
                color: #555;
            }

            /* Empty or error messages */
            td[colspan="6"], td[colspan="5"] {
                font-style: italic;
                text-align: center;
                color: #888;
            }
        </style>
    </head>
    <body>
        <%@ include file="/header/main_header.jsp" %>

        <h2>Management Staff List</h2>
        <form method="post" action="../crudStaff">
            <input type="hidden" name="action" value="create"> 
            <input type="hidden" name="firstName" value="New" />
            <input type="hidden" name="lastName" value="Staff" />
            <input type="submit" value="Create New Staff" />
        </form>
        <table border="1">
            <tr>
                <th>#</th>
                <th>STAFF_ID</th>
                <th>STAFF_FIRSTNAME</th>
                <th>STAFF_LASTNAME</th>
                <th>STAFF_PASSWORD</th>
                <th>Control</th>
            </tr>

            <%
        try {
            ArrayList<Staff> staffList = crudStaff.getAllStaff();
            int count = 1;
            if (staffList != null && !staffList.isEmpty()) {
                for (Staff s : staffList) {
            %>
            <tr>
                <td><%= count++ %></td>
                <td><%= s.getStaffId() %></td>
                <td><%= s.getFirstName() %></td>
                <td><%= s.getLastName() %></td>
                <td><%= s.getStaffPassword() %></td>
                <td>
                    <% if (!"A1".equals(s.getStaffId())) { %>
                    <form action="/galaxy_bookshelf/admin/editStaff.jsp" method="post" style="display:inline;">
                        <input type="hidden" name="staffId" value="<%= s.getStaffId() %>" />
                        <input type="submit" value="Edit" />
                    </form>
                    <form action="../crudStaff" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete" />
                        <input type="hidden" name="id" value="<%= s.getStaffId() %>" />
                        <input type="submit" value="Delete" onclick="return confirm('Are you sure to delete this staff?');" />
                    </form>
                    <% } else { %>
                    <span>Admin</span>
                    <% } %>
                </td>




            </tr>
            <%
             }
         } else {
            %>
            <tr><td colspan="6">No staff found.</td></tr>
            <%
                    }
                } catch (Exception e) {
            %>
            <tr><td colspan="5">Error loading staff: <%= e.getMessage() %></td></tr>
            <%
                }
            %>

        </table>
    </body>
</html>