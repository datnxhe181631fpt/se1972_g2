package entity;

public class PromotionDiscountValue {
    private int discountID;
    private int promotionID;
    private String discountType;
    private double discountValue;

    public PromotionDiscountValue() {
    }

    public PromotionDiscountValue(int discountID, int promotionID, String discountType, double discountValue) {
        this.discountID = discountID;
        this.promotionID = promotionID;
        this.discountType = discountType;
        this.discountValue = discountValue;
    }

    public int getDiscountID() {
        return discountID;
    }

    public void setDiscountID(int discountID) {
        this.discountID = discountID;
    }

    public int getPromotionID() {
        return promotionID;
    }

    public void setPromotionID(int promotionID) {
        this.promotionID = promotionID;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public double getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(double discountValue) {
        this.discountValue = discountValue;
    }
}
