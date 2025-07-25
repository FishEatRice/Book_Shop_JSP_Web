/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.comment;

/**
 *
 * @author ON YUEN SHERN
 */
public class Comment {

    private final String paymentId;
    private final String productName;
    private final int ratingStar;
    private final String comment;
    private final String reply;

    // Constructor
    public Comment(String paymentId, String productName, int ratingStar, String comment, String reply) {
        this.paymentId = paymentId;
        this.productName = productName;
        this.ratingStar = ratingStar;
        this.comment = comment;
        this.reply = reply;
    }

    // Getters
    public String getPaymentId() {
        return paymentId;
    }

    public String getProductName() {
        return productName;
    }

    public int getRatingStar() {
        return ratingStar;
    }

    public String getComment() {
        return comment;
    }

    public String getReply() {
        return reply;
    }
}
