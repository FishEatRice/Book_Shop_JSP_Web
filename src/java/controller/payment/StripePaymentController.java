// StripePaymentController.java (Multi-Item Stripe Payment with Debug and Error Recovery)
package controller.payment;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

public class StripePaymentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cartIdsParam = request.getParameter("cart_ids");
        if (cartIdsParam == null || cartIdsParam.trim().isEmpty()) {
            System.err.println("ERROR: Missing cart_ids parameter.");
            response.sendRedirect("/galaxy_bookshelf/payment/payment_error.jsp?reason=MissingCartIDs");
            return;
        }

        String[] cartIds = cartIdsParam.split(",");
        String payType = Optional.ofNullable(request.getParameter("payType")).orElse("CARD");
        String customer_id = "C1"; // DEMO

        List<SessionCreateParams.LineItem> lineItems = new ArrayList<>();
        double totalShippingFee = 0.0;
        boolean hasProducts = false;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            // Load cart items
            String placeholders = String.join(",", Collections.nCopies(cartIds.length, "?"));
            String query = "SELECT c.cart_id, p.product_name, p.product_price, c.quantity FROM galaxy.cart c JOIN galaxy.product p ON c.product_id = p.product_id WHERE c.cart_id IN (" + placeholders + ")";
            PreparedStatement ps = conn.prepareStatement(query);
            for (int i = 0; i < cartIds.length; i++) {
                ps.setString(i + 1, cartIds[i]);
            }
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                hasProducts = true;
                String name = rs.getString("product_name");
                int quantity = rs.getInt("quantity");
                double price = rs.getDouble("product_price");

                long unitAmount = Math.round(price * 100);
                lineItems.add(SessionCreateParams.LineItem.builder()
                        .setQuantity((long) quantity)
                        .setPriceData(
                                SessionCreateParams.LineItem.PriceData.builder()
                                        .setCurrency("myr")
                                        .setUnitAmount(unitAmount)
                                        .setProductData(
                                                SessionCreateParams.LineItem.PriceData.ProductData.builder()
                                                        .setName(name)
                                                        .build()
                                        ).build()
                        ).build());
            }
            rs.close();
            ps.close();

            if (!hasProducts) {
                System.err.println("ERROR: No cart items found for given cart_ids.");
                conn.close();
                response.sendRedirect("/galaxy_bookshelf/payment/payment_error.jsp?reason=NoValidCartItems");
                return;
            }

            // Shipping fee
            PreparedStatement fee_ps = conn.prepareStatement("SELECT FEE FROM GALAXY.SHIPPING_FEE SF JOIN GALAXY.SHIPPING_STATE SS ON SF.SHIPPING_ID = SS.SHIPPING_ID JOIN GALAXY.CUSTOMER CR ON SS.STATE_ID = CR.CUSTOMER_ADDRESS_STATE WHERE CR.CUSTOMER_ID = ?");
            fee_ps.setString(1, customer_id);
            ResultSet fee_rs = fee_ps.executeQuery();
            if (fee_rs.next()) {
                totalShippingFee = fee_rs.getDouble("FEE");
            }
            fee_rs.close();
            fee_ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/galaxy_bookshelf/payment/payment_error.jsp?reason=Exception");
            return;
        }

        long shippingAmount = Math.round(totalShippingFee * 100);
        lineItems.add(SessionCreateParams.LineItem.builder()
                .setQuantity(1L)
                .setPriceData(
                        SessionCreateParams.LineItem.PriceData.builder()
                                .setCurrency("myr")
                                .setUnitAmount(shippingAmount)
                                .setProductData(SessionCreateParams.LineItem.PriceData.ProductData.builder().setName("Shipping Fee").build())
                                .build()
                ).build());

        Stripe.apiKey = "sk_test_51REmleRm7KPRxChXu7KJFrj852rhwY8kLoZxwyKTLN2WDFyrOFcPwd3n6CDOVlbvtFsJBP2ImrTs5ETBOgOR1U7p00QE4415Hg";

        try {
            SessionCreateParams.Builder builder = SessionCreateParams.builder()
                    .setMode(SessionCreateParams.Mode.PAYMENT)
                    .setSuccessUrl("http://localhost:8080/galaxy_bookshelf/web/payment/done_pay.jsp?cart_ids=" + String.join(",", cartIds) + "&payType=" + payType)
                    .setCancelUrl("http://localhost:8080/galaxy_bookshelf/payment/payment_error.jsp?reason=StripeCancel");

            lineItems.forEach(builder::addLineItem);

            switch (payType.toUpperCase()) {
                case "FPX":
                    builder.addPaymentMethodType(SessionCreateParams.PaymentMethodType.FPX);
                    break;
                case "GRABPAY":
                    builder.addPaymentMethodType(SessionCreateParams.PaymentMethodType.GRABPAY);
                    break;
                default:
                    builder.addPaymentMethodType(SessionCreateParams.PaymentMethodType.CARD);
                    break;
            }

            Session session = Session.create(builder.build());
            response.sendRedirect(session.getUrl());
        } catch (StripeException e) {
            e.printStackTrace();
            response.sendRedirect("/galaxy_bookshelf/payment/payment_error.jsp?reason=StripeException");
        }
    }
}
