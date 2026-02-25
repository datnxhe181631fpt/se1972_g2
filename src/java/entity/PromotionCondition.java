package entity;

import java.lang.*;
import java.util.*;
import java.io.*;

/*
*
*
*/
public class PromotionCondition {

    private int conditionID;
    private int promotionID;
    private String conditionType;
    private String operator;
    private String conditionValue;
    private String logicalGroup;

    public PromotionCondition() {
    }

    public PromotionCondition(int conditionID, int promotionID, String conditionType, String operator,
            String conditionValue, String logicalGroup) {
        this.conditionID = conditionID;
        this.promotionID = promotionID;
        this.conditionType = conditionType;
        this.operator = operator;
        this.conditionValue = conditionValue;
        this.logicalGroup = logicalGroup;
    }

    public int getConditionID() {
        return conditionID;
    }

    public void setConditionID(int conditionID) {
        this.conditionID = conditionID;
    }

    public int getPromotionID() {
        return promotionID;
    }

    public void setPromotionID(int promotionID) {
        this.promotionID = promotionID;
    }

    public String getConditionType() {
        return conditionType;
    }

    public void setConditionType(String conditionType) {
        this.conditionType = conditionType;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public String getConditionValue() {
        return conditionValue;
    }

    public void setConditionValue(String conditionValue) {
        this.conditionValue = conditionValue;
    }

    public String getLogicalGroup() {
        return logicalGroup;
    }

    public void setLogicalGroup(String logicalGroup) {
        this.logicalGroup = logicalGroup;
    }

}
