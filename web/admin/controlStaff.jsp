<%@ page import="java.util.ArrayList" %>
<%@ page import="model.staff.Staff" %>
<%@ page import="controller.admin.crudStaff" %>
<%@ include file="/header/main_header.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Management Staff List</title>
        <style>
            table, th, td {
                border: 1px solid black;
                padding: 5px;
            }
        </style>
    </head>
    <body>
        <h2>Management Staff List</h2>
        <table border="1">
            <tr>
                <th>#</th>
                <th>STAFF_ID</th>
                <th>STAFF_FIRSTNAME</th>
                <th>STAFF_LASTNAME</th>
                <th>STAFF_PASSWORD</th>
                <th>POSITION</th>
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
                <td><%= s.getPosition() %></td>
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
            <tr><td colspan="5">No staff found.</td></tr>
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