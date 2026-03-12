package entity;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.ArrayList;

public class Promotion {

    private int promotionID;
    private String promotionCode;
    private String promotionName;
    private String promotionType;
    private LocalDate startDate;
    private LocalDate endDate;
    private int priority;
    private String status;
    private Boolean isStackable;
    private PromotionDiscountValue discount;
    private List<PromotionCondition> conditions;
    private List<PromotionApplicableCategory> applicableCategories;
    private List<PromotionApplicableProduct> applicableProducts;
    private List<PromotionCustomerTier> applicableCustomerTiers;

    public Promotion() {
    }

    public Promotion(int promotionID, String promotionCode, String promotionName, String promotionType,
            LocalDate startDate, LocalDate endDate, int priority, String status, Boolean isStackable) {
        this.promotionID = promotionID;
        this.promotionCode = promotionCode;
        this.promotionName = promotionName;
        this.promotionType = promotionType;
        this.startDate = startDate;
        this.endDate = endDate;
        this.priority = priority;
        this.status = status;
        this.isStackable = isStackable;
    }

    public int getPromotionID() {
        return promotionID;
    }

    public void setPromotionID(int promotionID) {
        this.promotionID = promotionID;
    }

    public String getPromotionCode() {
        return promotionCode;
    }

    public void setPromotionCode(String promotionCode) {
        this.promotionCode = promotionCode;
    }

    public String getPromotionName() {
        return promotionName;
    }

    public void setPromotionName(String promotionName) {
        this.promotionName = promotionName;
    }

    public String getPromotionType() {
        return promotionType;
    }

    public void setPromotionType(String promotionType) {
        this.promotionType = promotionType;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public int getPriority() {
        return priority;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Boolean getIsStackable() {
        return isStackable;
    }

    public void setIsStackable(Boolean isStackable) {
        this.isStackable = isStackable;
    }

    public PromotionDiscountValue getDiscount() {
        return discount;
    }

    public void setDiscount(PromotionDiscountValue discount) {
        this.discount = discount;
    }

    public List<PromotionCondition> getConditions() {
        return conditions;
    }

    public void setConditions(List<PromotionCondition> conditions) {
        this.conditions = conditions;
    }

    public List<PromotionApplicableCategory> getApplicableCategories() {
        return applicableCategories;
    }

    public void setApplicableCategories(List<PromotionApplicableCategory> applicableCategories) {
        this.applicableCategories = applicableCategories;
    }

    public List<PromotionApplicableProduct> getApplicableProducts() {
        return applicableProducts;
    }

    public void setApplicableProducts(List<PromotionApplicableProduct> applicableProducts) {
        this.applicableProducts = applicableProducts;
    }

    public List<PromotionCustomerTier> getApplicableCustomerTiers() {
        return applicableCustomerTiers;
    }

    public void setApplicableCustomerTiers(List<PromotionCustomerTier> applicableCustomerTiers) {
        this.applicableCustomerTiers = applicableCustomerTiers;
    }

    public String getStartDateFormatted() {
        if (startDate == null)
            return "";
        return startDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

    public String getEndDateFormatted() {
        if (endDate == null)
            return "";
        return endDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

    public String getStartDateForm() {
        if (startDate == null)
            return "";
        return startDate.format(DateTimeFormatter.ofPattern("MM/dd/yyyy"));
    }

    public String getEndDateForm() {
        if (endDate == null)
            return "";
        return endDate.format(DateTimeFormatter.ofPattern("MM/dd/yyyy"));
    }

}
