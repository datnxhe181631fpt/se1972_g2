package DAO;

import entity.Promotion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.lang.*;
import java.io.*;

/*
*
*
 */
public class PromotionDAO extends DBContext {

    public void insert(Promotion p) {
        String sql = """
                    INSERT INTO Promotions
                    (PromotionCode, PromotionName, PromotionType, StartDate, EndDate, Priority, Status, IsStackable)
                    VALUES (?,?,?,?,?,?,?,?)
                """;
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getPromotionCode());
            ps.setString(2, p.getPromotionName());
            ps.setString(3, p.getPromotionType());
            ps.setDate(4, Date.valueOf(p.getStartDate()));
            ps.setDate(5, Date.valueOf(p.getEndDate()));
            ps.setInt(6, p.getPriority());
            ps.setString(7, p.getStatus());
            ps.setBoolean(8, p.getIsStackable());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Promotion> getAll() {
        List<Promotion> list = new ArrayList<>();
        String sql = "SELECT * FROM Promotions";
        try (Connection con = getConnection(); ResultSet rs = con.prepareStatement(sql).executeQuery()) {

            while (rs.next()) {
                Promotion p = new Promotion();
                p.setPromotionID(rs.getInt("PromotionID"));
                p.setPromotionCode(rs.getString("PromotionCode"));
                p.setPromotionName(rs.getString("PromotionName"));
                p.setPromotionType(rs.getString("PromotionType"));
                p.setStartDate(rs.getDate("StartDate").toLocalDate());
                p.setEndDate(rs.getDate("EndDate").toLocalDate());
                p.setPriority(rs.getInt("Priority"));
                p.setStatus(rs.getString("Status"));
                p.setIsStackable(rs.getBoolean("IsStackable"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Promotion> getAllActive() {
        List<Promotion> list = new ArrayList<>();
        String sql = "SELECT * FROM Promotions WHERE Status='ACTIVE'";
        try (Connection con = getConnection(); ResultSet rs = con.prepareStatement(sql).executeQuery()) {

            while (rs.next()) {
                Promotion p = new Promotion();
                p.setPromotionID(rs.getInt("PromotionID"));
                p.setPromotionCode(rs.getString("PromotionCode"));
                p.setPromotionName(rs.getString("PromotionName"));
                p.setPromotionType(rs.getString("PromotionType"));
                p.setStartDate(rs.getDate("StartDate").toLocalDate());
                p.setEndDate(rs.getDate("EndDate").toLocalDate());
                p.setPriority(rs.getInt("Priority"));
                p.setStatus(rs.getString("Status"));
                p.setIsStackable(rs.getBoolean("IsStackable"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lọc promotion linh hoạt: có thể truyền null/rỗng để bỏ qua điều kiện đó.
     */
    public List<Promotion> getByFilter(String status, String type) {
        List<Promotion> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Promotions WHERE 1=1");
        if (status != null && !status.isEmpty())
            sql.append(" AND Status = ?");
        if (type != null && !type.isEmpty())
            sql.append(" AND PromotionType = ?");
        sql.append(" ORDER BY Priority ASC");

        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int idx = 1;
            if (status != null && !status.isEmpty())
                ps.setString(idx++, status);
            if (type != null && !type.isEmpty())
                ps.setString(idx++, type);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy promotion theo ID.
     */
    public Promotion getById(int id) {
        String sql = "SELECT * FROM Promotions WHERE PromotionID = ?";
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next())
                    return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Cập nhật trạng thái (ACTIVE / INACTIVE).
     */
    public void updateStatus(int id, String newStatus) {
        String sql = "UPDATE Promotions SET Status = ? WHERE PromotionID = ?";
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Cập nhật thông tin promotion (tên, loại, ngày, trạng thái).
     */
    public void update(Promotion p) {
        String sql = """
                    UPDATE Promotions SET
                        PromotionName = ?,
                        PromotionType = ?,
                        StartDate     = ?,
                        EndDate       = ?,
                        Priority      = ?,
                        Status        = ?,
                        IsStackable   = ?
                    WHERE PromotionID = ?
                """;
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getPromotionName());
            ps.setString(2, p.getPromotionType());
            ps.setDate(3, java.sql.Date.valueOf(p.getStartDate()));
            ps.setDate(4, java.sql.Date.valueOf(p.getEndDate()));
            ps.setInt(5, p.getPriority());
            ps.setString(6, p.getStatus());
            ps.setBoolean(7, p.getIsStackable());
            ps.setInt(8, p.getPromotionID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ── helper ──────────────────────────────────────────────────────────────
    private Promotion mapRow(ResultSet rs) throws SQLException {
        Promotion p = new Promotion();
        p.setPromotionID(rs.getInt("PromotionID"));
        p.setPromotionCode(rs.getString("PromotionCode"));
        p.setPromotionName(rs.getString("PromotionName"));
        p.setPromotionType(rs.getString("PromotionType"));
        p.setStartDate(rs.getDate("StartDate").toLocalDate());
        p.setEndDate(rs.getDate("EndDate").toLocalDate());
        p.setPriority(rs.getInt("Priority"));
        p.setStatus(rs.getString("Status"));
        p.setIsStackable(rs.getBoolean("IsStackable"));
        return p;
    }

}
