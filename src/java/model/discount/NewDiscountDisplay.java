/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.discount;

/**
 *
 * @author ON YUEN SHERN
 */
public class NewDiscountDisplay {
    
    private final String productId;
    private final String productName;
    private final String productPic;
    private final double productPrice;
    private final boolean DiscountStatus;
    private final double DiscountPrice;
    private final String Details;

    public NewDiscountDisplay(String productId, String productName, double productPrice, String productPic, boolean DiscountStatus, double DiscountPrice, String Details) {
        this.productId = productId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productPic = productPic;
        this.DiscountStatus = DiscountStatus;
        this.DiscountPrice = DiscountPrice;
        this.Details = Details;
    }

    // Get Method
    public String getProductId() {
        return productId;
    }

    // Get Method
    public String getProductName() {
        return productName;
    }
    
    // Get Method
    public String getDetails() {
        return Details;
    }
    
// Get Method
    public double getProductPrice() {
        return productPrice;
    }
    
    // Get Method
    public String getProductPic() {
        return productPic;
    }

    // Get Method
    public boolean getDiscountStatus(){
        return DiscountStatus;
    }

    // Get Method
    public double getDiscountPrice(){
        return DiscountPrice;
    }
}

