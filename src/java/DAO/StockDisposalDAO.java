/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import entity.StockDisposal;
import entity.StockDisposalDetail;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.time.LocalDateTime;

/**
 *
 * @author qp
 */
public class StockDisposalDAO extends DBContext {

    public List<StockDisposal> searchSDWithPaginated(String keyword, String status, String reason,
            LocalDate from, LocalDate to, int page, int pageSize) {
        List<StockDisposal> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        StringBuilder sql = new StringBuilder("""
                select sd.*,
                    e1.FullName AS CreatedByName,
                    e2.FullName AS ApprovedByName,
                    e3.FullName AS DisposedByName
                from StockDisposals sd
                left join Employees e1 ON sd.CreatedBy  = e1.EmployeeID
                left join Employees e2 ON sd.ApprovedBy = e2.EmployeeID
                left join Employees e3 ON sd.DisposedBy = e3.EmployeeID
                where 1=1
                """);
        appendFilters(sql, keyword, status, reason, from, to);
        sql.append(" ORDER BY sd.DisposalID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        try (Connection con = getConnection(); PreparedStatement stm = con.prepareStatement(sql.toString())) {
            int idx = bindFilters(stm, 1, keyword, status, reason, from, to);
            stm.setInt(idx++, offset);
            stm.setInt(idx++, pageSize);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    list.add(extractSDFromRS(rs));
                }
            }
        } catch (Exception e) {
            System.out.println("ERR: searchSDWithPaginated: " + e.getMessage());
        }
        return list;
    }

    public int countSD(String keyword, String status, String reason, LocalDate from, LocalDate to) {
        StringBuilder sql = new StringBuilder("select COUNT(*) from StockDisposals sd WHERE 1=1");
        appendFilters(sql, keyword, status, reason, from, to);
        try (Connection con = getConnection(); PreparedStatement stm = con.prepareStatement(sql.toString())) {
            bindFilters(stm, 1, keyword, status, reason, from, to);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            System.out.println("ERR : countSD: " + e.getMessage());
        }
        return 0;
    }

    private void appendFilters(StringBuilder sql, String keyword, String status, String reason, LocalDate from, LocalDate to) {
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (sd.DisposalNumber LIKE ? OR sd.Notes LIKE ?)");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND sd.Status = ?");
        }
        if (reason != null && !reason.trim().isEmpty()) {
            sql.append(" AND sd.DisposalReason = ?");
        }
        if (from != null) {
            sql.append(" AND CAST(sd.DisposalDate AS DATE) >= ?");
        }
        if (to != null) {
            sql.append(" AND CAST(sd.DisposalDate AS DATE) <= ?");
        }
    }

private int bindFilters(PreparedStatement stm, int idx, String keyword, String status,
            String reason, LocalDate from, LocalDate to) throws SQLException {
        if (keyword != null && !keyword.trim().isEmpty()) {
            stm.setString(idx++, "%" + keyword + "%");
            stm.setString(idx++, "%" + keyword + "%");
        }
        if (status != null && !status.trim().isEmpty()) {
            stm.setString(idx++, status);
        }
        if (reason != null && !reason.trim().isEmpty()) {
            stm.setString(idx++, reason);
        }
        if (from != null) {
            stm.setDate(idx++, Date.valueOf(from));
        }
        if (to != null) {
            stm.setDate(idx++, Date.valueOf(to));
        }
        return idx;
    }

    private StockDisposal extractSDFromRS(ResultSet rs) throws SQLException {
        StockDisposal sd = new StockDisposal();
        sd.setId(rs.getLong("DisposalID"));
        sd.setDisposalNumber(rs.getString("DisposalNumber"));
        sd.setDisposalDate(getLocalDateTime(rs, "DisposalDate"));
        sd.setDisposalReason(rs.getString("DisposalReason"));
        sd.setStatus(rs.getString("Status"));
        sd.setTotalQuantity(rs.getInt("TotalQuantity"));
        BigDecimal tv = rs.getBigDecimal("TotalValue");
        sd.setTotalValue(tv != null ? tv : BigDecimal.ZERO);
        sd.setApprovedBy(rs.getInt("ApprovedBy"));
        sd.setApprovedAt(getLocalDateTime(rs, "ApprovedAt"));
        sd.setRejectionReason(rs.getString("RejectionReason"));
        sd.setPhysicalDisposalConfirmed(rs.getBoolean("PhysicalDisposalConfirmed"));
        sd.setDisposedBy(rs.getInt("DisposedBy"));
        sd.setDisposedAt(getLocalDateTime(rs, "DisposedAt"));
        sd.setNotes(rs.getString("Notes"));
        sd.setCreatedBy(rs.getInt("CreatedBy"));
        sd.setCreatedAt(getLocalDateTime(rs, "CreatedAt"));
        try {
            sd.setCreatedByName(rs.getString("CreatedByName"));
        } catch (Exception ignored) {
        }
        try {
            sd.setApprovedByName(rs.getString("ApprovedByName"));
        } catch (Exception ignored) {
        }
        try {
            sd.setDisposedByName(rs.getString("DisposedByName"));
        } catch (Exception ignored) {
        }
        return sd;
    }

    private StockDisposalDetail extractSDDetailFromRS(ResultSet rs) throws SQLException {
        StockDisposalDetail d = new StockDisposalDetail();
        d.setId(rs.getLong("DisposalDetailID"));
        d.setProductId(rs.getInt("ProductID"));
        d.setQuantity(rs.getInt("Quantity"));
        BigDecimal uc = rs.getBigDecimal("UnitCost");
        d.setUnitCost(uc != null ? uc : BigDecimal.ZERO);
        BigDecimal lt = rs.getBigDecimal("LineTotal");
        d.setLineTotal(lt != null ? lt : BigDecimal.ZERO);
        d.setSpecificReason(rs.getString("SpecificReason"));
        d.setNotes(rs.getString("Notes"));
        try {
            d.setProductName(rs.getString("ProductName"));
        } catch (Exception ignored) {
        }
        try {
            d.setProductSku(rs.getString("SKU"));
        } catch (Exception ignored) {
        }
        try {
            d.setCurrentStock(rs.getInt("CurrentStock"));
        } catch (Exception ignored) {
        }
        return d;
    }

    private LocalDateTime getLocalDateTime(ResultSet rs, String col) throws SQLException {
        Timestamp ts = rs.getTimestamp(col);
        return ts != null ? ts.toLocalDateTime() : null;
    }

}
