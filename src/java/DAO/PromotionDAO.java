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
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

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

    public List<Promotion> getAllActive() {
        List<Promotion> list = new ArrayList<>();
        String sql = "SELECT * FROM Promotions WHERE Status='ACTIVE'";
        try (Connection con = getConnection();
             ResultSet rs = con.prepareStatement(sql).executeQuery()) {

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
}
