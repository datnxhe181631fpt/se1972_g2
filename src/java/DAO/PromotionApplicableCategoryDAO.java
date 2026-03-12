package DAO;

import entity.PromotionApplicableCategory;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PromotionApplicableCategoryDAO extends DBContext {

    public void insert(PromotionApplicableCategory pac) {
        String sql = "INSERT INTO PromotionApplicableCategories (PromotionID, CategoryID) VALUES (?, ?)";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, pac.getPromotionID());
            ps.setInt(2, pac.getCategoryID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<PromotionApplicableCategory> getByPromotionId(int promotionId) {
        List<PromotionApplicableCategory> list = new ArrayList<>();
        String sql = "SELECT * FROM PromotionApplicableCategories WHERE PromotionID = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, promotionId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PromotionApplicableCategory pac = new PromotionApplicableCategory();
                    pac.setId(rs.getInt("id"));
                    pac.setPromotionID(rs.getInt("PromotionID"));
                    pac.setCategoryID(rs.getInt("CategoryID"));
                    list.add(pac);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void deleteByPromotionId(int promotionId) {
        String sql = "DELETE FROM PromotionApplicableCategories WHERE PromotionID = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, promotionId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
