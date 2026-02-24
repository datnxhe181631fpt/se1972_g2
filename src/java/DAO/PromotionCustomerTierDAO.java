package DAO;


import java.sql.*;
import java.lang.*;
import java.util.*;
import java.io.*;
/*
*
*
*/
public class PromotionCustomerTierDAO extends DBContext {

    public void insert(int promotionId, int tierId) {
        String sql = """
            INSERT INTO PromotionCustomerTiers(PromotionID, TierID)
            VALUES (?,?)
        """;
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, promotionId);
            ps.setInt(2, tierId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteByPromotion(int promotionId) {
        String sql = "DELETE FROM PromotionCustomerTiers WHERE PromotionID=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, promotionId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

