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
