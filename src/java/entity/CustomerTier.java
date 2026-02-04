package entity;

import java.lang.*;
import java.util.*;
import java.io.*;

/*
*
*
 */
public class CustomerTier {

    private int tierID;
    private String tierName;
    private double minTotalSpent;
    private double pointRate;
    private double discountRate;

    public CustomerTier() {
    }

    public CustomerTier(int tierID, String tierName, double minTotalSpent, double pointRate, double discountRate) {
        this.tierID = tierID;
        this.tierName = tierName;
        this.minTotalSpent = minTotalSpent;
        this.pointRate = pointRate;
        this.discountRate = discountRate;
    }

    public int getTierID() {
        return tierID;
    }

    public void setTierID(int tierID) {
        this.tierID = tierID;
    }

    public String getTierName() {
        return tierName;
    }

    public void setTierName(String tierName) {
        this.tierName = tierName;
    }

    public double getMinTotalSpent() {
        return minTotalSpent;
    }

    public void setMinTotalSpent(double minTotalSpent) {
        this.minTotalSpent = minTotalSpent;
    }

    public double getPointRate() {
        return pointRate;
    }

    public void setPointRate(double pointRate) {
        this.pointRate = pointRate;
    }

    public double getDiscountRate() {
        return discountRate;
    }

    public void setDiscountRate(double discountRate) {
        this.discountRate = discountRate;
    }

}
