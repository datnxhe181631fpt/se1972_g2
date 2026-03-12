package DAO;

import entity.PromotionApplicableProduct;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PromotionApplicableProductDAO extends DBContext {

    public void insert(PromotionApplicableProduct pap) {
        String sql = "INSERT INTO PromotionApplicableProducts (PromotionID, ProductID) VALUES (?, ?)";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, pap.getPromotionID());
            ps.setInt(2, pap.getProductID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<PromotionApplicableProduct> getByPromotionId(int promotionId) {
        List<PromotionApplicableProduct> list = new ArrayList<>();
        String sql = "SELECT * FROM PromotionApplicableProducts WHERE PromotionID = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, promotionId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PromotionApplicableProduct pap = new PromotionApplicableProduct();
                    pap.setId(rs.getInt("id"));
                    pap.setPromotionID(rs.getInt("PromotionID"));
                    pap.setProductID(rs.getInt("ProductID"));
                    list.add(pap);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void deleteByPromotionId(int promotionId) {
        String sql = "DELETE FROM PromotionApplicableProducts WHERE PromotionID = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, promotionId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
