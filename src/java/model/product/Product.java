 /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.product;

import java.io.Serializable;
import java.math.BigDecimal;
import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedNativeQueries;
import jakarta.persistence.NamedNativeQuery;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import javax.xml.bind.annotation.XmlRootElement;
import model.genre.Genre;

/**
 *
 * @author JS
 */
@Entity
@Table(name = "PRODUCT")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Product.findAll", query = "SELECT p FROM Product p"),
    @NamedQuery(name = "Product.findByProductId", query = "SELECT p FROM Product p WHERE LOWER(p.productId) LIKE LOWER(:productId)"),
    @NamedQuery(name = "Product.findByProductName", query = "SELECT p FROM Product p WHERE LOWER(p.productName) LIKE LOWER(:productName)"),
    @NamedQuery(name = "Product.findByProductPrice", query = "SELECT p FROM Product p WHERE p.productPrice = :productPrice"),
    @NamedQuery(name = "Product.findByQuantity", query = "SELECT p FROM Product p WHERE p.quantity = :quantity")})
    @NamedNativeQueries({
        @NamedNativeQuery(name = "Product.findAllByOrder", query = "SELECT * FROM Product ORDER BY CAST(SUBSTR(product_id, 2) AS INT) ", resultClass = Product.class), }) 
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    // @Basic(optional = false)
    @Column(name = "PRODUCT_ID")
    private String productId;
    // @Basic(optional = false)
    @Column(name = "PRODUCT_NAME")
    private String productName;
    // @Basic(optional = false)
    @Lob
    @Column(name = "PRODUCT_INFORMATION")
    private String productInformation;
    // @Basic(optional = false)
    @Lob
    @Column(name = "PRODUCT_PICTURE")
    private String productPicture;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    // @Basic(optional = false)
    @Column(name = "PRODUCT_PRICE")
    private BigDecimal productPrice;
    @Column(name = "QUANTITY")
    private Integer quantity;
    @ManyToOne(optional = false)
    @JoinColumn(name = "GENRE_ID", referencedColumnName = "GENRE_ID")
    private Genre genreId;

    @Transient
    private double discountPrice;

    public Product() {
    }

    public Product(String productId) {
        this.productId = productId;
    }

    public Product(String productId, String productName, String productInformation, String productPicture, BigDecimal productPrice, double discountPrice) {
        this.productId = productId;
        this.productName = productName;
        this.productInformation = productInformation;
        this.productPicture = productPicture;
        this.productPrice = productPrice;
        this.discountPrice = discountPrice;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductInformation() {
        return productInformation;
    }

    public void setProductInformation(String productInformation) {
        this.productInformation = productInformation;
    }

    public String getProductPicture() {
        return productPicture;
    }

    public void setProductPicture(String productPicture) {
        this.productPicture = productPicture;
    }

    public BigDecimal getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(BigDecimal productPrice) {
        this.productPrice = productPrice;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Genre getGenreId() {
        return genreId;
    }

    public void setGenreId(Genre genreId) {
        this.genreId = genreId;
    }

    public double getDiscountPrice() {
        return discountPrice;
    }
    
    public void setDiscountPrice(double discountPrice) {
        this.discountPrice = discountPrice;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (productId != null ? productId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Product)) {
            return false;
        }
        Product other = (Product) object;
        if ((this.productId == null && other.productId != null) || (this.productId != null && !this.productId.equals(other.productId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.genre.Product[ productId=" + productId + " ]";
    }
    
}