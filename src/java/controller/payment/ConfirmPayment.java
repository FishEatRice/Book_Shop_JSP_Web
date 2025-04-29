/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.payment;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import java.util.*;
import model.cart.CustomerCart;
import model.payment.PayType;

/**
 *
 * @author ON YUEN SHERN
 */
public class ConfirmPayment extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String customer_id = (String) session.getAttribute("customer_id");

        double shipping_fee = 0.0;

        String full_name = "Not Yet Set";

        String phone_number = "Not Yet Set";

        String address = "Not Yet Set";

        String cartIdsParam = request.getParameter("cart_ids");
        if (cartIdsParam == null || cartIdsParam.isEmpty()) {
            response.sendRedirect("/galaxy_bookshelf/web/customer/list_cart.jsp");
            return;
        }

        // Pay Type
        List<PayType> payTypes = new ArrayList<>();

        String[] cartIdArray = cartIdsParam.split(",");
        List<String> cartIds = Arrays.asList(cartIdArray);
        List<CustomerCart> selectedItems = new ArrayList<>();
        double subtotal = 0.0;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String sql = "SELECT CART.CART_ID, CART.PRODUCT_ID, CART.QUANTITY AS CART_QUANTITY, PRODUCT.PRODUCT_NAME, PRODUCT.PRODUCT_PICTURE, PRODUCT.PRODUCT_PRICE, PRODUCT.QUANTITY AS STOCK_QUANTITY FROM GALAXY.CART JOIN GALAXY.PRODUCT ON CART.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE CART_ID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);

            for (String cartId : cartIds) {
                stmt.setString(1, cartId);
                ResultSet rs = stmt.executeQuery();

                boolean found = false;

                while (rs.next()) {
                    found = true;
                    String picJson = rs.getString("PRODUCT_PICTURE");
                    String imageData = "";
                    String imageType = "jpeg";

                    if (picJson != null && picJson.contains("base64Image")) {
                        int base64Start = picJson.indexOf("\"base64Image\":") + 15;
                        int base64End = picJson.indexOf("\"", base64Start);
                        if (base64Start > 14 && base64End > base64Start) {
                            imageData = picJson.substring(base64Start, base64End);
                        }

                        int typeStart = picJson.indexOf("\"fileType\":") + 12;
                        int typeEnd = picJson.indexOf("\"", typeStart);
                        if (typeStart > 11 && typeEnd > typeStart) {
                            imageType = picJson.substring(typeStart, typeEnd);
                        }
                    }

                    String base64Src = "data:" + imageType + ";base64," + imageData;

                    double discount_price = 0.0;

                    String CheckDiscountSQL = "SELECT DISCOUNT_PRICE FROM GALAXY.DISCOUNT WHERE PRODUCT_ID = ? AND DISCOUNT_SWITCH = 'true'";
                    PreparedStatement CheckDiscountSTML = conn.prepareStatement(CheckDiscountSQL);
                    CheckDiscountSTML.setString(1, rs.getString("PRODUCT_ID"));
                    ResultSet CheckDiscountRS = CheckDiscountSTML.executeQuery();

                    while (CheckDiscountRS.next()) {
                        discount_price = CheckDiscountRS.getDouble("DISCOUNT_PRICE");
                    }

                    int cartQuantity = rs.getInt("CART_QUANTITY");
                    int stockQuantity = rs.getInt("STOCK_QUANTITY");

                    if (cartQuantity > stockQuantity) {
                        session.setAttribute("stockError", "Some items in your cart are out of stock.");
                        response.sendRedirect("/galaxy_bookshelf/web/customer/list_cart.jsp");
                        rs.close();
                        stmt.close();
                        conn.close();
                        return;
                    }

                    CustomerCart cart = new CustomerCart(
                            rs.getString("CART_ID"),
                            rs.getString("PRODUCT_ID"),
                            rs.getString("PRODUCT_NAME"),
                            rs.getDouble("PRODUCT_PRICE"),
                            base64Src,
                            rs.getInt("CART_QUANTITY"),
                            rs.getInt("STOCK_QUANTITY"),
                            discount_price
                    );

                    if (cart.getDiscountPrice() <= 0.0) {
                        subtotal += cart.getProductPrice() * cart.getQuantityInCart();
                    } else {
                        subtotal += cart.getDiscountPrice() * cart.getQuantityInCart();
                    }

                    selectedItems.add(cart);
                }

                if (!found) {
                    response.sendRedirect("/galaxy_bookshelf/web/customer/list_cart.jsp");
                    return;
                }
            }

            // PayType
            String pay_sql = "SELECT * FROM GALAXY.PAY_TYPE";
            PreparedStatement pay_stmt = conn.prepareStatement(pay_sql);
            ResultSet pay_rs = pay_stmt.executeQuery();
            while (pay_rs.next()) {
                String id = pay_rs.getString("PAY_TYPE_ID");
                String name = pay_rs.getString("PAY_NAME");
                payTypes.add(new PayType(id, name));
            }

            pay_rs.close();
            pay_stmt.close();

            // Shipping fee
            PreparedStatement fee_ps = conn.prepareStatement("SELECT FEE FROM GALAXY.SHIPPING_FEE SF JOIN GALAXY.SHIPPING_STATE SS ON SF.SHIPPING_ID = SS.SHIPPING_ID JOIN GALAXY.CUSTOMER CR ON SS.STATE_ID = CR.CUSTOMER_ADDRESS_STATE WHERE CR.CUSTOMER_ID = ?");
            fee_ps.setString(1, customer_id);
            ResultSet fee_rs = fee_ps.executeQuery();
            if (fee_rs.next()) {
                shipping_fee = fee_rs.getDouble("FEE");
            }
            fee_rs.close();
            fee_ps.close();

            //Payment Address
            String AddressSQL = "SELECT C.CUSTOMER_FIRSTNAME, C.CUSTOMER_LASTNAME, C.CUSTOMER_CONTACTNO, C.CUSTOMER_ADDRESS_NO, C.CUSTOMER_ADDRESS_JALAN, C.CUSTOMER_ADDRESS_CITY, C.CUSTOMER_ADDRESS_CODE, S.STATE_NAME FROM GALAXY.CUSTOMER C JOIN GALAXY.SHIPPING_STATE S ON C.CUSTOMER_ADDRESS_STATE = S.STATE_ID WHERE CUSTOMER_ID = ?";
            PreparedStatement address_stmt = conn.prepareStatement(AddressSQL);
            address_stmt.setString(1, customer_id);
            ResultSet address_rs = address_stmt.executeQuery();
            while (address_rs.next()) {
                full_name = address_rs.getString("CUSTOMER_FIRSTNAME") + " " + address_rs.getString("CUSTOMER_LASTNAME");
                phone_number = address_rs.getString("CUSTOMER_CONTACTNO");
                address = address_rs.getString("CUSTOMER_ADDRESS_NO") + ", " + address_rs.getString("CUSTOMER_ADDRESS_JALAN") + "<br>" + address_rs.getString("CUSTOMER_ADDRESS_CODE") + " " + address_rs.getString("CUSTOMER_ADDRESS_CITY") + "<br>" + address_rs.getString("STATE_NAME");
            }

            address_rs.close();
            address_stmt.close();

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        double total = subtotal + shipping_fee;

        // For table
        request.setAttribute("SelectedItems", selectedItems);
        request.setAttribute("Subtotal", subtotal);
        request.setAttribute("ShippingFee", shipping_fee);
        request.setAttribute("Total", total);
        request.setAttribute("CartIDs", cartIdsParam);
        request.setAttribute("PayTypes", payTypes);
        request.setAttribute("FullName", full_name);
        request.setAttribute("PhoneNumber", phone_number);
        request.setAttribute("Address", address);

        // Forward to JSP
        request.getRequestDispatcher("/payment/confirm_payment.jsp").forward(request, response);
    }
}
