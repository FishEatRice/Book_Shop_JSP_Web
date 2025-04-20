/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.cart;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

/**
 *
 * @author ON YUEN SHERN
 */
public class Cart {

    private final String cartId;
    private final String customerId;
    private final String currentTime;

    public Cart(String customerId) {
        this.customerId = customerId;
        this.currentTime = generateCurrentTime();
        this.cartId = generateCartId();
    }

    // Get Time
    private String generateCurrentTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        sdf.setTimeZone(TimeZone.getTimeZone("GMT+8"));
        return sdf.format(new Date());
    }

    // Cart ID
    private String generateCartId() {
        return customerId + "T" + currentTime;
    }

    // Method Get
    public String getCartId() {
        return cartId;
    }

    // Method Get
    public String getCustomerId() {
        return customerId;
    }

    // Method Get
    public String getCurrentTime() {
        return currentTime;
    }
}
