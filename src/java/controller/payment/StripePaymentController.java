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
import javax.net.ssl.*;
import java.security.SecureRandom;
import java.security.cert.X509Certificate;

public class StripePaymentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Close SSL Checker
        disableSSLVerification();

        String cartIdsParam = request.getParameter("cart_ids");
        if (cartIdsParam == null || cartIdsParam.trim().isEmpty()) {
            response.sendRedirect("/galaxy_bookshelf/payment/payment_error.jsp?reason=MissingCartIDs");
            return;
        }

        String payType = request.getParameter("pay_type");
        if (payType == null || payType.trim().isEmpty()) {
            response.sendRedirect("/galaxy_bookshelf/payment/payment_error.jsp?reason=MissingPayType");
            return;
        }

        String[] cartIds = cartIdsParam.split(",");

        String customer_id = request.getParameter("customer_id");
        if (customer_id == null || customer_id.trim().isEmpty()) {
            response.sendRedirect("/galaxy_bookshelf/payment/payment_error.jsp?reason=MissingID");
            return;
        }

        // ===== Address Checker (NEW) =====
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");

            String addressQuery = "SELECT CUSTOMER_FIRSTNAME, CUSTOMER_LASTNAME, CUSTOMER_CONTACTNO, " +
                                   "CUSTOMER_ADDRESS_NO, CUSTOMER_ADDRESS_JALAN, CUSTOMER_ADDRESS_CITY, " +
                                   "CUSTOMER_ADDRESS_CODE, CUSTOMER_ADDRESS_STATE " +
                                   "FROM GALAXY.CUSTOMER WHERE CUSTOMER_ID = ?";
            PreparedStatement addressPS = conn.prepareStatement(addressQuery);
            addressPS.setString(1, customer_id);
            ResultSet addressRS = addressPS.executeQuery();

            if (addressRS.next()) {
                String[] addressFields = {
                    addressRS.getString("CUSTOMER_FIRSTNAME"),
                    addressRS.getString("CUSTOMER_LASTNAME"),
                    addressRS.getString("CUSTOMER_CONTACTNO"),
                    addressRS.getString("CUSTOMER_ADDRESS_NO"),
                    addressRS.getString("CUSTOMER_ADDRESS_JALAN"),
                    addressRS.getString("CUSTOMER_ADDRESS_CITY"),
                    addressRS.getString("CUSTOMER_ADDRESS_CODE"),
                    addressRS.getString("CUSTOMER_ADDRESS_STATE")
                };

                for (String field : addressFields) {
                    if (field == null || field.trim().isEmpty()) {
                        addressRS.close();
                        addressPS.close();
                        conn.close();
                        response.sendRedirect("/galaxy_bookshelf/web/payment/add_edit_address.jsp");
                        return;
                    }
                }
            } else {
                addressRS.close();
                addressPS.close();
                conn.close();
                response.sendRedirect("/galaxy_bookshelf/payment/payment_error.jsp?reason=CustomerNotFound");
                return;
            }

            addressRS.close();
            addressPS.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/galaxy_bookshelf/payment/payment_error.jsp?reason=AddressCheckerException");
            return;
        }
        // ===== End Address Checker =====

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

                // Check if there's discount
                double discount_price = 0.0;
                String discountSQL = "SELECT DISCOUNT_PRICE FROM GALAXY.DISCOUNT WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM GALAXY.CART WHERE CART_ID = ?) AND DISCOUNT_SWITCH = 'true'";
                PreparedStatement discountPS = conn.prepareStatement(discountSQL);
                discountPS.setString(1, rs.getString("cart_id"));
                ResultSet discountRS = discountPS.executeQuery();
                if (discountRS.next()) {
                    discount_price = discountRS.getDouble("DISCOUNT_PRICE");
                }
                discountRS.close();
                discountPS.close();

                String displayName;
                long unitAmount;

                if (discount_price > 0.0) {
                    displayName = name + " - RM" + String.format("%.2f", price);
                    unitAmount = Math.round(discount_price * 100);
                } else {
                    displayName = name;
                    unitAmount = Math.round(price * 100);
                }

                lineItems.add(SessionCreateParams.LineItem.builder()
                        .setQuantity((long) quantity)
                        .setPriceData(
                                SessionCreateParams.LineItem.PriceData.builder()
                                        .setCurrency("myr")
                                        .setUnitAmount(unitAmount)
                                        .setProductData(
                                                SessionCreateParams.LineItem.PriceData.ProductData.builder()
                                                        .setName(displayName)
                                                        .build()
                                        ).build()
                        ).build());
            }
            rs.close();
            ps.close();

            if (!hasProducts) {
                conn.close();
                response.sendRedirect("/galaxy_bookshelf/payment/payment_error.jsp?reason=NoValidCartItems");
                return;
            }

            if ("COD".equalsIgnoreCase(payType)) {
                response.sendRedirect("/galaxy_bookshelf/web/payment/done_pay.jsp?cart_ids=" + String.join(",", cartIds) + "&payType=" + payType);
                return;
            }

            // Shipping fee
            PreparedStatement fee_ps = conn.prepareStatement(
                "SELECT FEE FROM GALAXY.SHIPPING_FEE SF " +
                "JOIN GALAXY.SHIPPING_STATE SS ON SF.SHIPPING_ID = SS.SHIPPING_ID " +
                "JOIN GALAXY.CUSTOMER CR ON SS.STATE_ID = CR.CUSTOMER_ADDRESS_STATE " +
                "WHERE CR.CUSTOMER_ID = ?"
            );
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
            response.sendRedirect("/galaxy_bookshelf/payment/payment_error.jsp?reason=StripeException");
        }

    }

    public static void disableSSLVerification() {
        try {
            TrustManager[] trustAllCerts;
            trustAllCerts = new TrustManager[]{
                new X509TrustManager() {
                    @Override
                    public X509Certificate[] getAcceptedIssuers() {
                        return new X509Certificate[0];
                    }

                    @Override
                    public void checkClientTrusted(X509Certificate[] certs, String authType) {}

                    @Override
                    public void checkServerTrusted(X509Certificate[] certs, String authType) {}
                }
            };

            SSLContext sc = SSLContext.getInstance("SSL");
            sc.init(null, trustAllCerts, new SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

            HttpsURLConnection.setDefaultHostnameVerifier((hostname, session) -> true);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
