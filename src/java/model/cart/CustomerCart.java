/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.cart;

/**
 *
 * @author ON YUEN SHERN
 */
// Model only for customer view cart
public class CustomerCart {

    private final String cartId;
    private final String productId;
    private final String productName;
    private final String productPic;
    private final double productPrice;
    private final int quantityInCart;
    private final int quantityInStock;
    private final double discountPrice;

    public CustomerCart(String cartId, String productId, String productName, double productPrice, String productPic, int quantityInCart, int quantityInStock, double discountPrice) {
        this.cartId = cartId;
        this.productId = productId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productPic = productPic;
        this.quantityInCart = quantityInCart;
        this.quantityInStock = quantityInStock;
        this.discountPrice = discountPrice;
    }

    // Get Method
    public String getCartId() {
        return cartId;
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
    public double getProductPrice() {
        return productPrice;
    }
    
    // Get Method
    public String getProductPic() {
        return productPic;
    }

    // Get Method
    public int getQuantityInCart() {
        return quantityInCart;
    }

    // Get Method
    public int getQuantityInStock() {
        return quantityInStock;
    }
    
    // Get Method
    public double getDiscountPrice() {
        return discountPrice;
    }
}
