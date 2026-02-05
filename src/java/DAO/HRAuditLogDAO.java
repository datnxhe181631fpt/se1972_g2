package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class HRAuditLogDAO extends DBContext {

    public boolean insertLog(int employeeId, String action, String performedBy) {
        String sql = """
            INSERT INTO HRAuditLogs
            (EmployeeID, Action, PerformedBy, LogTime)
            VALUES (?, ?, ?, CURRENT_TIMESTAMP)
        """;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, employeeId);
            ps.setString(2, action);
            ps.setString(3, performedBy);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
