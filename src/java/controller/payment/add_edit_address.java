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
import model.payment.PaymentAddress;
import model.payment.ShippingState;

/**
 *
 * @author ON YUEN SHERN
 */
public class add_edit_address extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String customer_id = "C1";
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String sql = "SELECT CUSTOMER_FIRSTNAME, CUSTOMER_LASTNAME, CUSTOMER_CONTACTNO, CUSTOMER_ADDRESS_NO, CUSTOMER_ADDRESS_JALAN, CUSTOMER_ADDRESS_CITY, CUSTOMER_ADDRESS_CODE, CUSTOMER_ADDRESS_STATE FROM GALAXY.CUSTOMER WHERE CUSTOMER_ID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, customer_id);
            ResultSet rs = stmt.executeQuery();

            PaymentAddress PaymentAddressData = new PaymentAddress();
            if (rs.next()) {
                PaymentAddressData.setFirstName(rs.getString("CUSTOMER_FIRSTNAME"));
                PaymentAddressData.setLastName(rs.getString("CUSTOMER_LASTNAME"));
                PaymentAddressData.setContactNo(rs.getString("CUSTOMER_CONTACTNO"));
                PaymentAddressData.setAddressNo(rs.getString("CUSTOMER_ADDRESS_NO"));
                PaymentAddressData.setAddressJalan(rs.getString("CUSTOMER_ADDRESS_JALAN"));
                PaymentAddressData.setAddressCity(rs.getString("CUSTOMER_ADDRESS_CITY"));
                PaymentAddressData.setAddressCode(rs.getString("CUSTOMER_ADDRESS_CODE"));
                PaymentAddressData.setAddressState(rs.getString("CUSTOMER_ADDRESS_STATE"));
            }

            String StateSQL = "SELECT s.STATE_ID, s.STATE_NAME, f.SHIPPING_NAME, f.FEE FROM GALAXY.SHIPPING_STATE s JOIN GALAXY.SHIPPING_FEE f ON s.SHIPPING_ID = f.SHIPPING_ID";
            PreparedStatement Statestmt = conn.prepareStatement(StateSQL);
            ResultSet StateRS = Statestmt.executeQuery();

            List<ShippingState> shippingList = new ArrayList<>();
            while (StateRS.next()) {
                ShippingState shipping = new ShippingState();
                shipping.setStateId(StateRS.getString("STATE_ID"));
                shipping.setStateName(StateRS.getString("STATE_NAME"));
                shipping.setShippingName(StateRS.getString("SHIPPING_NAME"));
                shipping.setFee(StateRS.getString("FEE"));
                shippingList.add(shipping);
            }

            StateRS.close();
            Statestmt.close();
            rs.close();
            stmt.close();
            conn.close();

            request.setAttribute("shippingStates", shippingList);
            request.setAttribute("PaymentAddress", PaymentAddressData);
            request.getRequestDispatcher("/payment/add_edit_address.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
