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
        String sql = """
                     select i.*, p.ProductName 
                                      from PurchaseOrderItems i
                                      join Products p on i.ProductID = p.ProductID
                                      where i.POID = ? 
                                      order by i.LineItemID""";
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
        String sql = "select * from PurchaseOrderItems where LineItemID = ?";
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
//
//    public boolean addItem(PurchaseOrderItem item, long poId) {
//        Connection connection = getConnection();
//        String sql = """
//                     insert into PurchaseOrderItems
//                     (POID, ProductID, QuantityOrdered, UnitPrice, DiscountType, DiscountValue, LineTotal, Notes)
//                     values (?,?,?,?,?,?,?,?,?)
//                     """;
//
//        try {
//            int index = 1;
//            stm = connection.prepareStatement(sql);
//            stm.setLong(index++, poId);
//            stm.setInt(index++, item.getProductId());
//            stm.setInt(index++, item.getQuantityOrdered());
//            stm.setBigDecimal(index++, item.getUnitPrice());
//            stm.setString(index++, item.getDiscountType());
//            stm.setBigDecimal(index++, item.getDiscountValue());
//            stm.setBigDecimal(index++, item.getLineTotal());
//            stm.setString(index++, item.getNotes());
//            return stm.executeUpdate() > 0;
//        } catch (Exception e) {
//            System.out.println("ERR: addItem: " + e.getMessage());
//        }
//        return false;
//    }
//
//    public boolean updateItem(PurchaseOrderItem item) {
//        Connection connection = getConnection();
//        String sql = """
//                update PurchaseOrderItems 
//                set ProductID = ?, 
//                    QuantityOrdered = ?, 
//                    UnitPrice = ?, 
//                    DiscountType = ?, 
//                    DiscountValue = ?, 
//                    LineTotal = ?, 
//                    Notes = ?
//                where POItemID = ?
//                """;
//        try {
//            int index = 1;
//            stm = connection.prepareStatement(sql);
//            stm.setInt(index++, item.getProductId());
//            stm.setInt(index++, item.getQuantityOrdered());
//            stm.setBigDecimal(index++, item.getUnitPrice());
//            stm.setString(index++, item.getDiscountType());
//            stm.setBigDecimal(index++, item.getDiscountValue());
//            stm.setBigDecimal(index++, item.getLineTotal());
//            stm.setString(index++, item.getNotes());
//            stm.setLong(index++, item.getId());
//            return stm.executeUpdate() > 0;
//        } catch (Exception e) {
//            System.out.println("ERR: updateItem: " + e.getMessage());
//        }
//        return false;
//    }
//
//    public boolean deleteItem(long itemId) {
//        String sql = "delete from PurchaseOrderItems where POItemID = ?";
//        Connection connection = getConnection();
//        try {
//            stm = connection.prepareStatement(sql);
//            stm.setLong(1, itemId);
//            return stm.executeUpdate() > 0;
//        } catch (Exception e) {
//            System.out.println("ERR: deleteItem: " + e.getMessage());
//        }
//        return false;
//    }
//
//    public boolean deleteItemsByPOId(long poId) {
//        Connection connection = getConnection();
//        String sql = "delete from PurchaseOrderItems where POID = ?";
//        try {
//            stm = connection.prepareStatement(sql);
//            stm.setLong(1, poId);
//            return stm.executeUpdate() >= 0; // Can be 0 if no items
//        } catch (Exception e) {
//            System.out.println("ERR: deleteItemsByPOId: " + e.getMessage());
//        }
//        return false;
//    }
//
//    //batch insert items
//    public boolean addItemsBatch(List<PurchaseOrderItem> items, long poId) throws SQLException {
//        Connection connection = getConnection();
//        String sql = """
//                       insert into PurchaseOrderItems
//                                          (POID, ProductID, QuantityOrdered, UnitPrice, DiscountType, DiscountValue, LineTotal, Notes)
//                                          values (?,?,?,?,?,?,?,?,?)
//                     """;
//        try {
//            stm = connection.prepareStatement(sql);
//            connection.setAutoCommit(false);
//
//            for (PurchaseOrderItem item : items) {
//                int index = 1;
//                stm.setLong(index++, poId);
//                stm.setInt(index++, item.getProductId());
//                stm.setInt(index++, item.getQuantityOrdered());
//                stm.setBigDecimal(index++, item.getUnitPrice());
//                stm.setString(index++, item.getDiscountType());
//                stm.setBigDecimal(index++, item.getDiscountValue());
//                stm.setBigDecimal(index++, item.getLineTotal());
//                stm.setString(index++, item.getNotes());
//                stm.addBatch();
//            }
//            int results[] = stm.executeBatch();
//            connection.commit();
//            return results.length == items.size();
//        } catch (Exception e) {
//            System.out.println("ERR: addItem: " + e.getMessage());
//            connection.rollback();
//        }
//        return false;
//    }

    private PurchaseOrderItem extractItemFromResultSet(ResultSet rs) throws Exception {
        PurchaseOrderItem item = new PurchaseOrderItem();
        item.setId(rs.getLong("LineItemID"));
        item.setProductId(rs.getInt("ProductID"));
        item.setQuantityOrdered(rs.getInt("QuantityOrdered"));
        item.setQuantityReceived(rs.getInt("QuantityReceived"));
        item.setUnitPrice(rs.getBigDecimal("UnitPrice"));
        item.setDiscountType(rs.getString("DiscountType"));
        item.setDiscountValue(rs.getBigDecimal("DiscountValue"));
        item.setLineTotal(rs.getBigDecimal("LineTotal"));
        item.setNotes(rs.getString("Notes"));
        
        item.setProductName(rs.getString("ProductName"));
        return item;
    }
}
