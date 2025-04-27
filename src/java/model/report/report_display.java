/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.report;

/**
 *
 * @author ON YUEN SHERN
 */
public class report_display {

    private final String product_name;
    private int quantity;
    private double sale;

    public report_display(String product_name, int quantity, double sale) {
        this.product_name = product_name;
        this.quantity = quantity;
        this.sale = sale;
    }

    public String getProductName() {
        return product_name;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getSale() {
        return sale;
    }

    public void setSale(double sale) {
        this.sale = sale;
    }
}
