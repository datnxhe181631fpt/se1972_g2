package DAO;

import entity.PromotionCondition;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PromotionConditionDAO extends DBContext {

    public void insert(PromotionCondition pc) {
        String sql = "INSERT INTO PromotionConditions (PromotionID, ConditionType, Operator, ConditionValue, LogicalGroup) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, pc.getPromotionID());
            ps.setString(2, pc.getConditionType());
            ps.setString(3, pc.getOperator());
            ps.setString(4, pc.getConditionValue());
            ps.setString(5, pc.getLogicalGroup());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<PromotionCondition> getByPromotionId(int promotionId) {
        List<PromotionCondition> list = new ArrayList<>();
        String sql = "SELECT * FROM PromotionConditions WHERE PromotionID = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, promotionId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PromotionCondition pc = new PromotionCondition();
                    pc.setConditionID(rs.getInt("ConditionID"));
                    pc.setPromotionID(rs.getInt("PromotionID"));
                    pc.setConditionType(rs.getString("ConditionType"));
                    pc.setOperator(rs.getString("Operator"));
                    pc.setConditionValue(rs.getString("ConditionValue"));
                    pc.setLogicalGroup(rs.getString("LogicalGroup"));
                    list.add(pc);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void deleteByPromotionId(int promotionId) {
        String sql = "DELETE FROM PromotionConditions WHERE PromotionID = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, promotionId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
