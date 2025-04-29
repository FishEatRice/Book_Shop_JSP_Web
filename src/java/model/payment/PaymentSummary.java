/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.payment;

/**
 *
 * @author ON YUEN SHERN
 */
import java.sql.Timestamp;

public class PaymentSummary {

    private String mainPaymentId;
    private String customerId;
    private Timestamp payDatetime;
    private String payTypeId;
    private double totalAmount;
    private int totalItems;

    // Getters and Setters
    public String getMainPaymentId() {
        return mainPaymentId;
    }

    public void setMainPaymentId(String mainPaymentId) {
        this.mainPaymentId = mainPaymentId;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public Timestamp getPayDatetime() {
        return payDatetime;
    }

    public void setPayDatetime(Timestamp payDatetime) {
        this.payDatetime = payDatetime;
    }

    public String getPayTypeId() {
        return payTypeId;
    }

    public void setPayTypeId(String payTypeId) {
        this.payTypeId = payTypeId;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public int getTotalItems() {
        return totalItems;
    }

    public void setTotalItems(int totalItems) {
        this.totalItems = totalItems;
    }
}
