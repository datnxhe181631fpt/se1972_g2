package entity;

import java.lang.*;
import java.util.*;
import java.io.*;

/*
*
*
*/
public class PromotionCustomerTier {

    private int id;
    private int promotionID;
    private int tierID;

    public PromotionCustomerTier() {
    }

    public PromotionCustomerTier(int id, int promotionID, int tierID) {
        this.id = id;
        this.promotionID = promotionID;
        this.tierID = tierID;
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

    public int getTierID() {
        return tierID;
    }

    public void setTierID(int tierID) {
        this.tierID = tierID;
    }

}
