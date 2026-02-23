package DAO;

import entity.Role;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoleDAO extends DBContext {

    public List<Role> getAllRoles() {
        List<Role> list = new ArrayList<>();
        String sql = "SELECT * FROM Roles ORDER BY RoleName";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Role r = new Role();
                r.setRoleId(rs.getInt("RoleID"));
                r.setRoleName(rs.getString("RoleName"));
                r.setPermissions(rs.getString("Permissions"));
                r.setCreatedAt(rs.getTimestamp("CreatedAt"));
                list.add(r);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}