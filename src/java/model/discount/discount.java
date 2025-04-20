package model.discount;

import java.sql.Timestamp;

public class discount {

    private final String discount_id;
    private final String product_id;
    private final String productName;
    private final String productPic;
    private final double productPrice;
    private final double discount_price;
    private final Timestamp expired_datetime;
    private final boolean discount_switch;

    public discount(String discount_id, String product_id, double productPrice, double discount_price, Timestamp expired_datetime, boolean discount_switch, String productName, String productPic) {
        this.discount_id = discount_id;
        this.product_id = product_id;
        this.productPrice = productPrice;
        this.discount_price = discount_price;
        this.expired_datetime = expired_datetime;
        this.discount_switch = discount_switch;
        this.productName = productName;
        this.productPic = productPic;
    }

    public String getDiscountId() {
        return discount_id;
    }

    public String getProductId() {
        return product_id;
    }

    public double getproductPrice() {
        return productPrice;
    }
    
    public double getDiscountPrice() {
        return discount_price;
    }

    public Timestamp getExpiredDatetime() {
        return expired_datetime;
    }

    public boolean getDiscountSwitch() {
        return discount_switch;
    }

    public String getProductPic() {
        return productPic;
    }

    public String getProductName() {
        return productName;
    }
}
