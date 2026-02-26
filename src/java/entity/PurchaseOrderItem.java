/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.math.BigDecimal;
import java.math.RoundingMode;

/**
 *
 * @author qp
 */
public class PurchaseOrderItem {

    public static final String DISCOUNT_PERCENT = "PERCENT";
    public static final String DISCOUNT_AMOUNT = "AMOUNT";

    private Long id;
    private PurchaseOrder purchaseOrder;
    private Integer productId;
    private Integer quantityOrdered;
    private Integer quantityReceived;
    private BigDecimal unitPrice;
    private String discountType;
    private BigDecimal discountValue;
    private BigDecimal lineTotal;
    private String notes;

    private String productName; //for PO-form

    public PurchaseOrderItem() {
        this.quantityReceived = 0;
        this.discountType = DISCOUNT_AMOUNT;
        this.discountValue = BigDecimal.ZERO;
    }

    public PurchaseOrderItem(Integer productId, Integer quantityOrdered, BigDecimal unitPrice) {
        this();
        this.productId = productId;
        this.quantityOrdered = quantityOrdered;
        this.unitPrice = unitPrice;
        calculateLineTotal();
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public PurchaseOrder getPurchaseOrder() {
        return purchaseOrder;
    }

    public void setPurchaseOrder(PurchaseOrder purchaseOrder) {
        this.purchaseOrder = purchaseOrder;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getQuantityOrdered() {
        return quantityOrdered;
    }

    public void setQuantityOrdered(Integer quantityOrdered) {
        this.quantityOrdered = quantityOrdered;
    }

    public Integer getQuantityReceived() {
        return quantityReceived;
    }

    public void setQuantityReceived(Integer quantityReceived) {
        this.quantityReceived = quantityReceived;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public BigDecimal getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(BigDecimal discountValue) {
        this.discountValue = discountValue;
    }

    public BigDecimal getLineTotal() {
        return lineTotal;
    }

    public void setLineTotal(BigDecimal lineTotal) {
        this.lineTotal = lineTotal;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void calculateLineTotal() {
        BigDecimal gross = unitPrice.multiply(BigDecimal.valueOf(quantityOrdered)); //tong so tien theo don gia

        if (DISCOUNT_PERCENT.equals(discountType)) {
            BigDecimal discountAmount = gross.multiply(discountValue)
                    .divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_EVEN);//lam tron den so chan gan nhat (hay dc sd trong ngan hang)
            this.lineTotal = gross.subtract(discountAmount);
        } else {
            this.lineTotal = gross.subtract(discountValue != null ? discountValue : BigDecimal.ZERO);
        }
    }

    public Integer getRemainingQuantity() {
        return quantityOrdered - quantityReceived;
    }

    //da nhan du chua
    public boolean isFullyReceived() {
        return quantityReceived >= quantityOrdered;
    }

    public boolean isPartiallyReceived() {
        return quantityReceived > 0 && quantityReceived < quantityOrdered;
    }

    @Override
    public String toString() {
        return "PurchaseOrderItem{"
                + "id=" + id
                + ", productId=" + productId
                + ", quantityOrdered=" + quantityOrdered
                + ", quantityReceived=" + quantityReceived
                + ", lineTotal=" + lineTotal
                + '}';
    }
}
