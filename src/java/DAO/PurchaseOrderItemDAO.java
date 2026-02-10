/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import entity.PurchaseOrderItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author qp
 */
public class PurchaseOrderItemDAO extends DBContext {

    PreparedStatement stm;
    ResultSet rs;

    public List<PurchaseOrderItem> getItemsByPOId(long poId) {
        Connection connection = getConnection();
        List<PurchaseOrderItem> items = new ArrayList<>();
        String sql = "select * from PurchaseOrderItems where POID = ? order by POItemID";
        try {
            stm = connection.prepareStatement(sql);
            stm.setLong(1, poId);
            rs = stm.executeQuery();
            while (rs.next()) {
                items.add(extractItemFromResultSet(rs));
            }
        } catch (Exception e) {
            System.out.println("ERR: getItemsByPOId: " + e.getMessage());
        }
        return items;
    }

    public PurchaseOrderItem getItemById(long itemId) {
        Connection connection = getConnection();
        String sql = "select * from PurchaseOrderItems where POItemID = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setLong(1, itemId);
            rs = stm.executeQuery();
            if (rs.next()) {
                return extractItemFromResultSet(rs);
            }
        } catch (Exception e) {
            System.out.println("ERR: getItemById: " + e.getMessage());
        }
        return null;
    }

    private PurchaseOrderItem extractItemFromResultSet(ResultSet rs) throws Exception {
        PurchaseOrderItem item = new PurchaseOrderItem();
        item.setId(rs.getLong("POItemID"));
        item.setProductId(rs.getInt("ProductID"));
        item.setQuantityOrdered(rs.getInt("QuantityOrdered"));
        item.setQuantityReceived(rs.getInt("QuantityReceived"));
        item.setUnitPrice(rs.getBigDecimal("UnitPrice"));
        item.setDiscountType(rs.getString("DiscountType"));
        item.setDiscountValue(rs.getBigDecimal("DiscountValue"));
        item.setLineTotal(rs.getBigDecimal("LineTotal"));
        item.setNotes(rs.getString("Notes"));
        return item;
    }
}
