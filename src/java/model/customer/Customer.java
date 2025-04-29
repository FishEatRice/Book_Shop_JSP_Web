package model.customer;

/**
 *
 * @author yq
 */
public class Customer {

    private String customerId;
    private String customerName;
    private String customerEmail;
    private String customerPassword;
    private String customerFirstName;
    private String customerLastName;
    private String customerContactNo;
    private String customerAddressNo;
    private String customerAddressJalan;
    private String customerAddressState;
    private String customerAddressCity;
    private String customerAddressCode;

// Getter 和 Setter for customerId
    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    // Getter 和 Setter for customerName
    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    // Getter 和 Setter for customerEmail
    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    // Getter 和 Setter for customerPassword
    public String getCustomerPassword() {
        return customerPassword;
    }

    public void setCustomerPassword(String customerPassword) {
        this.customerPassword = customerPassword;
    }

    // Getter 和 Setter for customerFirstName
    public String getCustomerFirstName() {
        return customerFirstName;
    }

    public void setCustomerFirstName(String customerFirstName) {
        this.customerFirstName = customerFirstName;
    }

    // Getter 和 Setter for customerLastName
    public String getCustomerLastName() {
        return customerLastName;
    }

    public void setCustomerLastName(String customerLastName) {
        this.customerLastName = customerLastName;
    }

    // Getter 和 Setter for customerAddressNo
    public String getCustomerAddressNo() {
        return customerAddressNo;
    }

    public void setCustomerAddressNo(String customerAddressNo) {
        this.customerAddressNo = customerAddressNo;
    }

    // Getter 和 Setter for customerAddressJalan
    public String getCustomerAddressJalan() {
        return customerAddressJalan;
    }

    public void setCustomerAddressJalan(String customerAddressJalan) {
        this.customerAddressJalan = customerAddressJalan;
    }

    // Getter 和 Setter for customerAddressState
    public String getCustomerAddressState() {
        return customerAddressState;
    }

    public void setCustomerAddressState(String customerAddressState) {
        this.customerAddressState = customerAddressState;
    }

    // Getter 和 Setter for customerAddressCity
    public String getCustomerAddressCity() {
        return customerAddressCity;
    }

    public void setCustomerAddressCity(String customerAddressCity) {
        this.customerAddressCity = customerAddressCity;
    }

    // Getter 和 Setter for customerAddressCode
    public String getCustomerAddressCode() {
        return customerAddressCode;
    }

    public void setCustomerAddressCode(String customerAddressCode) {
        this.customerAddressCode = customerAddressCode;
    }

    public String getCustomerContactNo() {
        return customerContactNo;
    }

    public void setCustomerContactNo(String customerContactNo) {
        this.customerContactNo = customerContactNo;
    }

    public static String getStateName(String addressState) {
        switch (addressState) {
            case "ST1":
                return "Selangor";
            case "ST2":
                return "Kuala Lumpur";
            case "ST3":
                return "Johor";
            case "ST4":
                return "Penang";
            case "ST5":
                return "Kedah";
            case "ST6":
                return "Perak";
            case "ST7":
                return "Melaka";
            case "ST8":
                return "Pahang";
            case "ST9":
                return "Negeri Sembilan";
            case "ST10":
                return "Putrajaya";
            case "ST11":
                return "Kelantan";
            case "ST12":
                return "Terengganu";
            case "ST13":
                return "Perlis";
            case "ST14":
                return "Sabah";
            case "ST15":
                return "Labuan";
            case "ST16":
                return "Sarawak";
            default:
                return "";
        }
    }
}
