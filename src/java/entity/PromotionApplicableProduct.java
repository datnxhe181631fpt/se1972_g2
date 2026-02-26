package entity;

import java.lang.*;
import java.util.*;
import java.io.*;

/*
*
*
*/
public class PromotionApplicableProduct {

    private int id;
    private int promotionID;
    private int productID;

    public PromotionApplicableProduct() {
    }

    public PromotionApplicableProduct(int id, int promotionID, int productID) {
        this.id = id;
        this.promotionID = promotionID;
        this.productID = productID;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPromotionID() {
        return promotionID;
    }

    public void setPromotionID(int promotionID) {
        this.promotionID = promotionID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

}
