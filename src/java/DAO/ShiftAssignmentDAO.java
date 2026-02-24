package DAO;

import entity.EmployeeShiftAssignment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShiftAssignmentDAO extends DBContext {

    public void assignShift(int empID, int shiftID, Date workDate, int assignedBy) {

        String sql = "INSERT INTO EmployeeShiftAssignments "
                + "(EmployeeID, ShiftID, WorkDate, AssignedBy, Status) "
                + "VALUES (?, ?, ?, ?, 'ASSIGNED')";

        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, empID);
            ps.setInt(2, shiftID);
            ps.setDate(3, workDate);
            ps.setInt(4, assignedBy);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<EmployeeShiftAssignment> getHistoryByEmployee(int empID) {
        List<EmployeeShiftAssignment> list = new ArrayList<>();
        String sql = "SELECT a.*, s.ShiftName "
                + "FROM EmployeeShiftAssignments a "
                + "JOIN Shifts s ON a.ShiftID = s.ShiftID "
                + "WHERE a.EmployeeID = ? "
                + "ORDER BY WorkDate DESC";

        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, empID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                EmployeeShiftAssignment a = new EmployeeShiftAssignment();
                a.setAssignmentID(rs.getInt("AssignmentID"));
                a.setShiftName(rs.getString("ShiftName"));
                a.setWorkDate(rs.getDate("WorkDate"));
                a.setStatus(rs.getString("Status"));
                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<EmployeeShiftAssignment> getAssignmentsByDate(Date date) {

        List<EmployeeShiftAssignment> list = new ArrayList<>();

        String sql
                = "SELECT a.AssignmentID, a.EmployeeID, a.ShiftID, a.WorkDate, a.Status, "
                + "e.FullName, r.RoleName, "
                + "s.ShiftName, s.StartTime, s.EndTime "
                + "FROM EmployeeShiftAssignments a "
                + "LEFT JOIN Employees e ON a.EmployeeID = e.EmployeeID "
                + "LEFT JOIN Roles r ON e.RoleID = r.RoleID "
                + "LEFT JOIN Shifts s ON a.ShiftID = s.ShiftID "
                + "WHERE a.WorkDate = ?";

        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setDate(1, date);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                EmployeeShiftAssignment a = new EmployeeShiftAssignment();

                a.setAssignmentID(rs.getInt("AssignmentID"));
                a.setEmployeeId(rs.getInt("EmployeeID"));
                a.setShiftID(rs.getInt("ShiftID"));
                a.setWorkDate(rs.getDate("WorkDate"));
                a.setStatus(rs.getString("Status"));

                a.setFullName(rs.getString("FullName"));
                a.setRole(rs.getString("RoleName"));
                a.setShiftName(rs.getString("ShiftName"));
                a.setStartTime(rs.getString("StartTime"));
                a.setEndTime(rs.getString("EndTime"));

                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
