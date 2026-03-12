package entity;

import java.util.Date;

public class EmployeeShiftAssignment {

    private int assignmentID;
    private int employeeId;
    private int shiftID;
    private Date workDate;
    private String status;

    private String shiftName;
    private String fullName;
    private String role;

    private String startTime;
    private String endTime;

    public EmployeeShiftAssignment() {
    }

    public EmployeeShiftAssignment(int assignmentID, int employeeId, int shiftID, Date workDate, String status, String shiftName, String fullName, String role, String startTime, String endTime) {
        this.assignmentID = assignmentID;
        this.employeeId = employeeId;
        this.shiftID = shiftID;
        this.workDate = workDate;
        this.status = status;
        this.shiftName = shiftName;
        this.fullName = fullName;
        this.role = role;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public int getAssignmentID() {
        return assignmentID;
    }

    public void setAssignmentID(int assignmentID) {
        this.assignmentID = assignmentID;
    }

    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public int getShiftID() {
        return shiftID;
    }

    public void setShiftID(int shiftID) {
        this.shiftID = shiftID;
    }

    public Date getWorkDate() {
        return workDate;
    }

    public void setWorkDate(Date workDate) {
        this.workDate = workDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getShiftName() {
        return shiftName;
    }

    public void setShiftName(String shiftName) {
        this.shiftName = shiftName;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    
}