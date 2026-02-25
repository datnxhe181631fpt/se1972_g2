package entity;

import java.lang.*;
import java.util.*;
import java.io.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/*
*
*
*/
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

}
