/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.payment;

import java.util.List;
import model.payment.ShippingState;

/**
 *
 * @author ON YUEN SHERN
 */
public class PaymentAddress {

    private String firstName;
    private String lastName;
    private String contactNo;
    private String addressNo;
    private String addressJalan;
    private String addressCity;
    private String addressCode;
    private String addressState;
    private List<ShippingState> shippingStates;

    // Getters and setters
    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public String getAddressNo() {
        return addressNo;
    }

    public void setAddressNo(String addressNo) {
        this.addressNo = addressNo;
    }

    public String getAddressJalan() {
        return addressJalan;
    }

    public void setAddressJalan(String addressJalan) {
        this.addressJalan = addressJalan;
    }

    public String getAddressCity() {
        return addressCity;
    }

    public void setAddressCity(String addressCity) {
        this.addressCity = addressCity;
    }

    public String getAddressCode() {
        return addressCode;
    }

    public void setAddressCode(String addressCode) {
        this.addressCode = addressCode;
    }

    public String getAddressState() {
        return addressState;
    }

    public void setAddressState(String addressState) {
        this.addressState = addressState;
    }

    public List<ShippingState> getShippingStates() {
        return shippingStates;
    }

    public void setShippingStates(List<ShippingState> shippingStates) {
        this.shippingStates = shippingStates;
    }
}
