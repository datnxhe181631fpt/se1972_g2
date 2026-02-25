package DAO;

import entity.PromotionDiscountValue;
import java.sql.*;

public class PromotionDiscountValueDAO extends DBContext {

    public void insert(PromotionDiscountValue dv) {
        String sql = "INSERT INTO PromotionDiscountValues (PromotionID, DiscountType, DiscountValue) VALUES (?, ?, ?)";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, dv.getPromotionID());
            ps.setString(2, dv.getDiscountType());
            ps.setDouble(3, dv.getDiscountValue());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public PromotionDiscountValue getByPromotionId(int promotionId) {
        String sql = "SELECT * FROM PromotionDiscountValues WHERE PromotionID = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, promotionId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new PromotionDiscountValue(
                            rs.getInt("DiscountID"),
                            rs.getInt("PromotionID"),
                            rs.getString("DiscountType"),
                            rs.getDouble("DiscountValue"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateByPromotionId(PromotionDiscountValue dv) {
        String sql = "UPDATE PromotionDiscountValues SET DiscountType = ?, DiscountValue = ? WHERE PromotionID = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, dv.getDiscountType());
            ps.setDouble(2, dv.getDiscountValue());
            ps.setInt(3, dv.getPromotionID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteByPromotionId(int promotionId) {
        String sql = "DELETE FROM PromotionDiscountValues WHERE PromotionID = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, promotionId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
