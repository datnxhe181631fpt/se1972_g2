

package entity;

import java.util.Date;


public class ShiftSwapRequest {
    private int swapRequestID;
    private int fromEmployeeID;
    private int fromAssignmentID;
    private String reason;
    private String status;

    private String fullName;
    private String shiftName;
    private Date workDate;
    private int toEmployeeID; 
    private int toAssignmentID;

    public ShiftSwapRequest() {
    }

    public ShiftSwapRequest(int swapRequestID, int fromEmployeeID, int fromAssignmentID, String reason, String status, String fullName, String shiftName, Date workDate, int toEmployeeID, int toAssignmentID) {
        this.swapRequestID = swapRequestID;
        this.fromEmployeeID = fromEmployeeID;
        this.fromAssignmentID = fromAssignmentID;
        this.reason = reason;
        this.status = status;
        this.fullName = fullName;
        this.shiftName = shiftName;
        this.workDate = workDate;
        this.toEmployeeID = toEmployeeID;
        this.toAssignmentID = toAssignmentID;
    }

    public int getSwapRequestID() {
        return swapRequestID;
    }

    public void setSwapRequestID(int swapRequestID) {
        this.swapRequestID = swapRequestID;
    }

    public int getFromEmployeeID() {
        return fromEmployeeID;
    }

    public void setFromEmployeeID(int fromEmployeeID) {
        this.fromEmployeeID = fromEmployeeID;
    }

    public int getFromAssignmentID() {
        return fromAssignmentID;
    }

    public void setFromAssignmentID(int fromAssignmentID) {
        this.fromAssignmentID = fromAssignmentID;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getShiftName() {
        return shiftName;
    }

    public void setShiftName(String shiftName) {
        this.shiftName = shiftName;
    }

    public Date getWorkDate() {
        return workDate;
    }

    public void setWorkDate(Date workDate) {
        this.workDate = workDate;
    }

    public int getToEmployeeID() {
        return toEmployeeID;
    }

    public void setToEmployeeID(int toEmployeeID) {
        this.toEmployeeID = toEmployeeID;
    }

    public int getToAssignmentID() {
        return toAssignmentID;
    }

    public void setToAssignmentID(int toAssignmentID) {
        this.toAssignmentID = toAssignmentID;
    }
    
    

}