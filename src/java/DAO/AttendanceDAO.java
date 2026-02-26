package DAO;

import entity.AttendanceView;
import java.sql.*;
import java.util.*;
import java.sql.Date;

public class AttendanceDAO extends DBContext {

    public List<AttendanceView> getAttendanceByDate(
            Date workDate,
            int page,
            int pageSize) {

        List<AttendanceView> list = new ArrayList<>();

        String sql = """
        SELECT e.FullName,
               s.ShiftName,
               s.StartTime,
               s.EndTime,
               a.CheckIn,
               a.CheckOut
        FROM EmployeeShiftAssignments esa
        JOIN Employees e ON esa.EmployeeID = e.EmployeeID
        JOIN Shifts s ON esa.ShiftID = s.ShiftID
        LEFT JOIN Attendance a 
               ON esa.AssignmentID = a.AssignmentID
        WHERE esa.WorkDate = ?
        ORDER BY s.StartTime
        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
    """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, workDate);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                AttendanceView v = new AttendanceView();

                v.setFullName(rs.getString("FullName"));
                v.setShiftName(rs.getString("ShiftName"));
                v.setStartTime(rs.getTime("StartTime"));
                v.setEndTime(rs.getTime("EndTime"));
                v.setCheckIn(rs.getTime("CheckIn"));
                v.setCheckOut(rs.getTime("CheckOut"));

                list.add(v);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countAttendanceByDate(Date workDate) {

        String sql = """
        SELECT COUNT(*)
        FROM EmployeeShiftAssignments
        WHERE WorkDate = ?
    """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, workDate);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public Map<String, Integer> getDashboardStats(Date workDate) {

        Map<String, Integer> stats = new HashMap<>();

        String sql = """
        SELECT 
            COUNT(*) AS TotalAssigned,
            SUM(CASE WHEN a.CheckIn IS NOT NULL THEN 1 ELSE 0 END) AS CheckedIn,
            SUM(CASE WHEN a.CheckIn IS NULL THEN 1 ELSE 0 END) AS NotCheckedIn
        FROM EmployeeShiftAssignments esa
        LEFT JOIN Attendance a 
               ON esa.AssignmentID = a.AssignmentID
        WHERE esa.WorkDate = ?
    """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, workDate);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                stats.put("total", rs.getInt("TotalAssigned"));
                stats.put("checkedIn", rs.getInt("CheckedIn"));
                stats.put("notCheckedIn", rs.getInt("NotCheckedIn"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return stats;
    }

}
