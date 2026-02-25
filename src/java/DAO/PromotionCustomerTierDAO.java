package DAO;

import java.sql.*;
import java.lang.*;
import java.util.*;
import java.io.*;
import entity.PromotionCustomerTier;

/*
*
*
*/
public class PromotionCustomerTierDAO extends DBContext {

    public void insert(PromotionCustomerTier pct) {
        String sql = "INSERT INTO PromotionCustomerTiers(PromotionID, TierID) VALUES (?,?)";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, pct.getPromotionID());
            ps.setInt(2, pct.getTierID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<entity.PromotionCustomerTier> getByPromotionId(int promotionId) {
        List<entity.PromotionCustomerTier> list = new ArrayList<>();
        String sql = "SELECT * FROM PromotionCustomerTiers WHERE PromotionID = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, promotionId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    entity.PromotionCustomerTier pct = new entity.PromotionCustomerTier();
                    pct.setPromotionID(rs.getInt("PromotionID"));
                    pct.setTierID(rs.getInt("TierID"));
                    list.add(pct);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void deleteByPromotionId(int promotionId) {
        String sql = "DELETE FROM PromotionCustomerTiers WHERE PromotionID=?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, promotionId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
