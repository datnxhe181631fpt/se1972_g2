

package DAO;
import entity.ShiftSwapRequest;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class ShiftSwapDAO extends DBContext {

    public void requestSwap(int empID, int assignmentID, String reason) {
        String sql = "INSERT INTO ShiftSwapRequests "
                + "(FromEmployeeID, FromAssignmentID, Reason) "
                + "VALUES (?, ?, ?)";

        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, empID);
            ps.setInt(2, assignmentID);
            ps.setString(3, reason);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void approveSwap(int requestID, int managerID) {
        String sql = "UPDATE ShiftSwapRequests "
                + "SET Status='APPROVED', ApprovedBy=?, ApprovedAt=GETDATE() "
                + "WHERE SwapRequestID=?";

        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, managerID);
            ps.setInt(2, requestID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<ShiftSwapRequest> getPendingRequests() {
        List<ShiftSwapRequest> list = new ArrayList<>();

        String sql = "SELECT r.*, e.FullName, s.ShiftName, a.WorkDate "
                + "FROM ShiftSwapRequests r "
                + "JOIN Employees e ON r.FromEmployeeID = e.EmployeeID "
                + "JOIN EmployeeShiftAssignments a ON r.FromAssignmentID = a.AssignmentID "
                + "JOIN Shifts s ON a.ShiftID = s.ShiftID "
                + "WHERE r.Status = 'PENDING' "
                + "ORDER BY r.RequestedAt DESC";

        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ShiftSwapRequest r = new ShiftSwapRequest();

                r.setSwapRequestID(rs.getInt("SwapRequestID"));
                r.setFullName(rs.getString("FullName"));
                r.setShiftName(rs.getString("ShiftName"));
                r.setWorkDate(rs.getDate("WorkDate"));
                r.setReason(rs.getString("Reason"));
                r.setStatus(rs.getString("Status"));

                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public void rejectSwap(int requestID, int managerID) {

        String sql = "UPDATE ShiftSwapRequests "
                + "SET Status='REJECTED', ApprovedBy=?, ApprovedAt=GETDATE() "
                + "WHERE SwapRequestID=?";

        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, managerID);
            ps.setInt(2, requestID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public String getEmailByRequestID(int requestID) {

        String sql = "SELECT e.Email "
                + "FROM ShiftSwapRequests r "
                + "JOIN Employees e ON r.FromEmployeeID = e.EmployeeID "
                + "WHERE r.SwapRequestID = ?";

        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, requestID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getString("Email");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
