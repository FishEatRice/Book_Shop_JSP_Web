package model.payment;

import java.sql.*;

public class PaymentDetail {

    private String paymentId;
    private String customerId;
    private int quantity;
    private String payDatetime;
    private String payTypeId;
    private int ratingStar;
    private String comment;
    private int shippingStatus;
    private String shipDatetime;
    private String staffId;
    private double payPrice;
    private String productName;
    private String productId;

    // Getters and Setters
    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getPayDatetime() {
        return payDatetime;
    }

    public void setPayDatetime(String payDatetime) {
        this.payDatetime = payDatetime;
    }

    public String getPayTypeId() {
        return payTypeId;
    }

    public void setPayTypeId(String payTypeId) {
        this.payTypeId = payTypeId;
    }

    public int getRatingStar() {
        return ratingStar;
    }

    public void setRatingStar(int ratingStar) {
        this.ratingStar = ratingStar;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getShippingStatus() {
        return shippingStatus;
    }

    public void setShippingStatus(int shippingStatus) {
        this.shippingStatus = shippingStatus;
    }

    public String getShipDatetime() {
        return shipDatetime;
    }

    public void setShipDatetime(String shipDatetime) {
        this.shipDatetime = shipDatetime;
    }

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public double getPayPrice() {
        return payPrice;
    }

    public void setPayPrice(double payPrice) {
        this.payPrice = payPrice;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getShippingStatusName() {
        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");
            String sql = "SELECT * FROM GALAXY.SHIPPING_STATUS WHERE SHIPPING_STATUS_ID = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, shippingStatus);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getString("SHIPPING_STATUS_NAME");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Unknown";
    }

    public String getPayTypeName() {
        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/db_galaxy_bookshelf", "GALAXY", "GALAXY");
            String sql = "SELECT * FROM GALAXY.PAY_TYPE WHERE PAY_TYPE_ID = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, payTypeId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getString("PAY_NAME");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Unknown";
    }
}
