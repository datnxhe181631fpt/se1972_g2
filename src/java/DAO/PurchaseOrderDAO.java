/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import entity.PurchaseOrder;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.time.LocalDateTime;

/**
 *
 * @author qp
 */
public class PurchaseOrderDAO extends DBContext {

    PreparedStatement stm;
    ResultSet rs;

    //view
    public List<PurchaseOrder> getAllPurchaseOrders() {
        List<PurchaseOrder> lists = new ArrayList<>();
        Connection connection = getConnection();
        String sql = "select * from PurchaseOrders";
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                lists.add(extractPurchaseOrderFromResultSet(rs));
            }
        } catch (Exception e) {
            System.out.println("ERR: getAllPurchaseOrders: " + e.getMessage());
        }
        return lists;
    }

    public PurchaseOrder getPurchaseOrderByCode(String purchaseNumber) {
        String sql = "select * from PurchaseOrder where PONumber = ?";
        Connection connection = getConnection();
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, purchaseNumber);
            rs = stm.executeQuery();
            if (rs.next()) {
                return extractPurchaseOrderFromResultSet(rs);
            }
        } catch (Exception e) {
            System.out.println("ERR: getPO by Code: " + e.getMessage());
        }
        return null;
    }

    public PurchaseOrder getPurchaseOrderById(long id) {
        String sql = "select * from PurchaseOrders where POID = ?";
        Connection connection = getConnection();
        try {
            stm = connection.prepareStatement(sql);
            stm.setLong(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                return extractPurchaseOrderFromResultSet(rs);
            }
        } catch (Exception e) {
            System.out.println("ERR: getPOById: " + e.getMessage());
        }
        return null;
    }

    //add
    public boolean addPurchaseOrder(PurchaseOrder po) {
        String sql = """
                INSERT INTO PurchaseOrders (PONumber, SupplierID, OrderDate, ExpectedDate, Subtotal, TotalDiscount, TotalAmount, Notes, CreatedBy)
               VALUES(?,?,?,?,?,?,?,?,?)
                    """;
        Connection connection = getConnection();
        try {
            int index = 1;
            stm = connection.prepareStatement(sql);
            stm.setString(index++, po.getPoNumber());
            stm.setLong(index++, po.getSupplierId());
            stm.setDate(index++, Date.valueOf(po.getOrderDate()));
            stm.setDate(index++, Date.valueOf(po.getExpectedDate()));
            stm.setBigDecimal(index++, po.getSubtotal());
            stm.setBigDecimal(index++, po.getTotalDiscount());
            stm.setBigDecimal(index++, po.getTotalAmount());
            stm.setString(index++, po.getNotes());
            stm.setInt(index++, po.getCreatedBy());
            return stm.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("ERR: Add :" + e.getMessage());
        }
        return false;
    }

    //cancel
    public boolean cancelPO() {
        Connection connection = getConnection();
        String sql = """
                    update PurchaseOrders set CancelledBy = ?,
                                              CancellationReason = ?,
                                              Status = 'CANCELLED'
                                              where PONumber = ?
                """;
        try {
            stm = connection.prepareStatement(sql);
            return stm.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("CancelPO: " + e.getMessage());
        }
        return false;
    }
    
    

    private PurchaseOrder extractPurchaseOrderFromResultSet(ResultSet rs) throws Exception {
        PurchaseOrder po = new PurchaseOrder();
        po.setId(rs.getLong("POID"));
        po.setPoNumber(rs.getString("PONumber"));
        po.setSupplierId(rs.getInt("SupplierID"));

        po.setOrderDate(rs.getDate("OrderDate").toLocalDate());
        po.setExpectedDate(rs.getDate("ExpectedDate").toLocalDate());
        po.setStatus(rs.getString("Status"));

        po.setSubtotal(rs.getBigDecimal("Subtotal"));
        po.setTotalDiscount(rs.getBigDecimal("TotalDiscount"));
        po.setTotalAmount(rs.getBigDecimal("TotalAmount"));

        po.setApprovedBy(rs.getInt("ApprovedBy"));
        po.setApprovedAt(getLocalDateTime(rs, "ApprovedAt"));
        po.setRejectionReason(rs.getString("RejectionReason"));

        po.setCancelledBy(rs.getInt("CancelledBy"));
        po.setCancelledAt(getLocalDateTime(rs, "CancelledAt"));
        po.setCancellationReason(rs.getString("CancellationReason"));

        po.setCreatedBy(rs.getInt("CreatedBy"));
        po.setCreatedAt(getLocalDateTime(rs, "CreatedAt"));

        po.setUpdatedAt(getLocalDateTime(rs, "UpdatedAt"));
        po.setNotes(rs.getString("Notes"));

        return po;
    }

    private LocalDateTime getLocalDateTime(ResultSet rs, String columnName) throws SQLException {
        Timestamp ts = rs.getTimestamp(columnName);
        return (ts != null) ? ts.toLocalDateTime() : null;
    }
}
