package entity;


import java.lang.*;
import java.util.*;
import java.io.*;
/*
*
*
*/
public class CustomerPoint {

    private String customerID;
    private int totalPoints;

    public CustomerPoint() {
    }

    public CustomerPoint(String customerID, int totalPoints) {
        this.customerID = customerID;
        this.totalPoints = totalPoints;
    }

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public int getTotalPoints() {
        return totalPoints;
    }

    public void setTotalPoints(int totalPoints) {
        this.totalPoints = totalPoints;
    }
    
    
}
