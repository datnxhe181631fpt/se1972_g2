package entity;

import java.lang.*;
import java.util.*;
import java.io.*;

/*
*
*
*/
public class PromotionApplicableCategory {

    private int id;
    private int promotionID;
    private int categoryID;

    public PromotionApplicableCategory() {
    }

    public PromotionApplicableCategory(int id, int promotionID, int categoryID) {
        this.id = id;
        this.promotionID = promotionID;
        this.categoryID = categoryID;
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

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

}
