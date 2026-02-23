package DAO;

import entity.Employee;
import entity.Role;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO extends DBContext {

    // Get employees with search, filter, paging
    public List<Employee> getEmployees(String search, Integer roleId, String status,
            int page, int pageSize) {

        List<Employee> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("""
            SELECT e.*, r.RoleName
            FROM Employees e
            JOIN Roles r ON e.RoleID = r.RoleID
            WHERE 1=1
        """);

        // Search
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (e.FullName LIKE ? OR e.Email LIKE ?)");
        }

        // Filter role
        if (roleId != null && roleId > 0) {
            sql.append(" AND e.RoleID = ?");
        }

        // Filter status
        if (status != null && !status.isEmpty()) {
            sql.append(" AND e.Status = ?");
        }

        sql.append(" ORDER BY e.EmployeeID DESC ");
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int index = 1;

            if (search != null && !search.trim().isEmpty()) {
                String keyword = "%" + search + "%";
                ps.setString(index++, keyword);
                ps.setString(index++, keyword);
            }

            if (roleId != null && roleId > 0) {
                ps.setInt(index++, roleId);
            }

            if (status != null && !status.isEmpty()) {
                ps.setString(index++, status);
            }

            ps.setInt(index++, (page - 1) * pageSize);
            ps.setInt(index++, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Employee e = new Employee();
                e.setEmployeeId(rs.getInt("EmployeeID"));
                e.setFullName(rs.getString("FullName"));
                e.setEmail(rs.getString("Email"));
                e.setPhone(rs.getString("Phone"));
                e.setHireDate(rs.getDate("HireDate"));
                e.setStatus(rs.getString("Status"));

                Role r = new Role();
                r.setRoleId(rs.getInt("RoleID"));
                r.setRoleName(rs.getString("RoleName"));
                e.setRole(r);

                list.add(e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // Count employees for pagination
    public int getTotalEmployees(String search, Integer roleId, String status) {
        StringBuilder sql = new StringBuilder("""
            SELECT COUNT(*)
            FROM Employees
            WHERE 1=1
        """);

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (FullName LIKE ? OR Email LIKE ?)");
        }

        if (roleId != null && roleId > 0) {
            sql.append(" AND RoleID = ?");
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND Status = ?");
        }

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int index = 1;

            if (search != null && !search.trim().isEmpty()) {
                String keyword = "%" + search + "%";
                ps.setString(index++, keyword);
                ps.setString(index++, keyword);
            }

            if (roleId != null && roleId > 0) {
                ps.setInt(index++, roleId);
            }

            if (status != null && !status.isEmpty()) {
                ps.setString(index++, status);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get employee by ID
    public Employee getEmployeeByID(int id) {
        String sql = """
            SELECT e.*, r.RoleName
            FROM Employees e
            JOIN Roles r ON e.RoleID = r.RoleID
            WHERE e.EmployeeID = ?
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Employee e = new Employee();
                e.setEmployeeId(id);
                e.setFullName(rs.getString("FullName"));
                e.setEmail(rs.getString("Email"));
                e.setPhone(rs.getString("Phone"));
                e.setHireDate(rs.getDate("HireDate"));
                e.setStatus(rs.getString("Status"));

                Role r = new Role();
                r.setRoleId(rs.getInt("RoleID"));
                r.setRoleName(rs.getString("RoleName"));
                e.setRole(r);

                return e;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Insert employee
    public boolean insertEmployee(Employee e) {
        String sql = """
            INSERT INTO Employees
            (FullName, Email, Phone, RoleID, HireDate, Status)
            VALUES (?, ?, ?, ?, ?, 'Active')
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, e.getFullName());
            ps.setString(2, e.getEmail());
            ps.setString(3, e.getPhone());
            ps.setInt(4, e.getRole().getRoleId());
            // HireDate (nullable)
            if (e.getHireDate() != null) {
                ps.setDate(5, e.getHireDate());
            } else {
                ps.setNull(5, java.sql.Types.DATE);
            }

            ps.setString(6, e.getStatus());

            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Update employee
    public boolean updateEmployee(Employee e) {
        String sql = """
            UPDATE Employees
            SET FullName=?, Email=?, Phone=?, RoleID=?, HireDate=?
            WHERE EmployeeID=?
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, e.getFullName());
            ps.setString(2, e.getEmail());
            ps.setString(3, e.getPhone());
            ps.setInt(4, e.getRole().getRoleId());
            ps.setDate(5, e.getHireDate());
            ps.setInt(6, e.getEmployeeId());

            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Soft delete
    public boolean deactivateEmployee(int id) {
        String sql = "UPDATE Employees SET Status = 'Inactive' WHERE EmployeeID = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }
}
