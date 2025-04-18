package controller.payment;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class StripePaymentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String cartId = request.getParameter("cart_id");
        String payType = request.getParameter("payType");
        if (payType == null || payType.isEmpty()) {
            payType = "CARD";
        }

        //DEMO
        String customer_id = "C1";
        
        String productName = "NULL";
        int quantity = 1;
        double price = 0.0;

        double shippingfee = 0.0;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String query = "SELECT p.product_id, p.product_name, p.product_price, c.quantity FROM galaxy.cart c JOIN galaxy.product p ON c.product_id = p.product_id WHERE c.cart_id = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, cartId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                productName = rs.getString("product_name");
                quantity = rs.getInt("quantity");
                price = rs.getDouble("product_price");
            }

            rs.close();
            ps.close();

           String fee_query = "SELECT FEE FROM GALAXY.SHIPPING_FEE SF JOIN GALAXY.SHIPPING_STATE SS ON SF.SHIPPING_ID = SS.SHIPPING_ID JOIN GALAXY.CUSTOMER CR ON SS.STATE_ID = CR.CUSTOMER_ADDRESS_STATE WHERE CR.CUSTOMER_ID = ?";
            PreparedStatement fee_ps = conn.prepareStatement(fee_query);
            fee_ps.setString(1, customer_id);
            ResultSet fee_rs = fee_ps.executeQuery();

            if (fee_rs.next()) {
                shippingfee = fee_rs.getDouble("FEE");
            }

            fee_rs.close();
            fee_ps.close();           // get shipping fee
  

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/galaxy_bookshelf/payment/payment_error.jsp");
            return;
        }

        if ("COD".equalsIgnoreCase(payType)) {
            response.sendRedirect("/galaxy_bookshelf/web/payment/done_pay.jsp?cart_id=" + cartId + "&payType=" + payType);
        }

        // Stripe API key
        Stripe.apiKey = "sk_test_51REmleRm7KPRxChXu7KJFrj852rhwY8kLoZxwyKTLN2WDFyrOFcPwd3n6CDOVlbvtFsJBP2ImrTs5ETBOgOR1U7p00QE4415Hg";

        // make all double to cents
        long unitAmount = Math.round(price * 100);
        long shippingAmount = Math.round(shippingfee * 100);

        try {
            SessionCreateParams.Builder builder = SessionCreateParams.builder()
                    .setMode(SessionCreateParams.Mode.PAYMENT)
                    .setSuccessUrl("http://localhost:8080/galaxy_bookshelf/web/payment/done_pay.jsp?cart_id=" + cartId + "&payType=" + payType)
                    .setCancelUrl("http://localhost:8080/galaxy_bookshelf/payment/payment_error.jsp")
                    .addLineItem(
                            SessionCreateParams.LineItem.builder()
                                    .setQuantity((long) quantity)
                                    .setPriceData(
                                            SessionCreateParams.LineItem.PriceData.builder()
                                                    .setCurrency("myr")
                                                    .setUnitAmount(unitAmount)
                                                    .setProductData(
                                                            SessionCreateParams.LineItem.PriceData.ProductData.builder()
                                                                    .setName(productName)
                                                                    .build()
                                                    )
                                                    .build()
                                    )
                                    .build()
                    );

            // Shipping Fee
            builder.addLineItem(
                    SessionCreateParams.LineItem.builder()
                            .setQuantity(1L)
                            .setPriceData(
                                    SessionCreateParams.LineItem.PriceData.builder()
                                            .setCurrency("myr")
                                            .setUnitAmount(shippingAmount)
                                            .setProductData(
                                                    SessionCreateParams.LineItem.PriceData.ProductData.builder()
                                                            .setName("Shipping Fee")
                                                            .build()
                                            )
                                            .build()
                            )
                            .build()
            );

            switch (payType.toUpperCase()) {
                case "CARD":
                    builder.addPaymentMethodType(SessionCreateParams.PaymentMethodType.CARD);
                    break;
                case "FPX":
                    builder.addPaymentMethodType(SessionCreateParams.PaymentMethodType.FPX);
                    break;
                case "GRABPAY":
                    builder.addPaymentMethodType(SessionCreateParams.PaymentMethodType.GRABPAY);
                    break;
                case "ALIPAY":
                    builder.addPaymentMethodType(SessionCreateParams.PaymentMethodType.ALIPAY);
                    break;
                default:
                    builder.addPaymentMethodType(SessionCreateParams.PaymentMethodType.CARD);
                    break;
            }

            Session session = Session.create(builder.build());
            response.sendRedirect(session.getUrl());
        } catch (StripeException e) {
            e.printStackTrace();
            response.sendRedirect("/galaxy_bookshelf/payment/payment_error.jsp");
        }
    }
}
