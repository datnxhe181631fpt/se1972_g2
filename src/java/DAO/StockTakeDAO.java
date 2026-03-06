/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import entity.StockTake;
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
public class StockTakeDAO extends DBContext {

    public List<StockTake> searchWithPaginated(String keyword, String status,
            LocalDate from, LocalDate to, int page, int pageSize) {
        List<StockTake> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        StringBuilder sql = new StringBuilder();
        sql.append("""
                    select st.*,
                                          e1.FullName AS CreatedByName,
                                          e2.FullName AS ApprovedByName,
                                          e3.FullName AS RecountByName
                                   from   StockTakes st
                                   left join Employees e1 ON st.CreatedBy      = e1.EmployeeID
                                   left join Employees e2 ON st.ApprovedBy     = e2.EmployeeID
                                   left join Employees e3 ON st.RecountRequestedBy = e3.EmployeeID
                                   where 1 = 1
                   """);

        appendFilters(sql, keyword, status, from, to);
        sql.append(" ORDER BY st.StockTakeID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        try (Connection connection = getConnection(); PreparedStatement stm = connection.prepareStatement(sql.toString())) {
            int idx = bindFilters(stm, 1, keyword, status, from, to);
            stm.setInt(idx++, offset);
            stm.setInt(idx, pageSize);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    list.add(extractSTFromResultSet(rs));
                }
            }
        } catch (Exception e) {
            System.out.println("ERR: StockTakeDAO.searchWithPaginated: " + e.getMessage());
        }
        return list;

    }
    
    public int count(String keyword, String status, LocalDate from, LocalDate to) {
        StringBuilder sql = new StringBuilder("select COUNT(*) from StockTakes st WHERE 1=1");
        appendFilters(sql, keyword, status, from, to);
        try (Connection connection = getConnection();PreparedStatement stm = connection.prepareStatement(sql.toString())) {
            bindFilters(stm, 1, keyword, status, from, to);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("ERR: StockTakeDAO.count: " + e.getMessage());
        }
        return 0;
    }
    

    private void appendFilters(StringBuilder sql, String keyword, String status,
            LocalDate from, LocalDate to) {
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (st.StockTakeNumber LIKE ?) ");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND st.Status = ? ");
        }
        if (from != null) {
            sql.append(" AND st.StockTakeDate >= ? ");
        }
        if (to != null) {
            sql.append(" AND st.StockTakeDate <= ? ");
        }
    }

    private int bindFilters(PreparedStatement stm, int idx,
            String keyword, String status, LocalDate from, LocalDate to) throws SQLException {
        if (keyword != null && !keyword.trim().isEmpty()) {
            stm.setString(idx++, "%" + keyword + "%");
        }
        if (status != null && !status.trim().isEmpty()) {
            stm.setString(idx++, status);
        }
        if (from != null) {
            stm.setDate(idx++, Date.valueOf(from));
        }
        if (to != null) {
            stm.setDate(idx++, Date.valueOf(to));
        }
        return idx;
    }

    private StockTake extractSTFromResultSet(ResultSet rs) throws SQLException {
        StockTake st = new StockTake();
        st.setId(rs.getLong("StockTakeID"));
        st.setStockTakeNumber(rs.getString("StockTakeNumber"));
        st.setScopeType(rs.getString("ScopeType"));
        st.setScopeValue(rs.getString("ScopeValue"));
        Date d = rs.getDate("StockTakeDate");
        if (d != null) {
            st.setStockTakeDate(d.toLocalDate());
        }
        st.setStatus(rs.getString("Status"));
        st.setTotalItems(rs.getInt("TotalItems"));
        st.setTotalVarianceQty(rs.getInt("TotalVarianceQty"));
        BigDecimal totalVarianceValue = rs.getBigDecimal("TotalVarianceValue");
        st.setTotalVarianceValue(totalVarianceValue != null ? totalVarianceValue : BigDecimal.ZERO);
        st.setNotes(rs.getString("Notes"));

        st.setCreatedBy(rs.getInt("CreatedBy"));
        st.setCreatedAt(getLocalDateTime(rs, "CreatedAt"));

        st.setSubmittedAt(getLocalDateTime(rs, "SubmittedAt"));

        st.setApprovedBy(rs.getInt("ApprovedBy"));
        st.setApprovedAt(getLocalDateTime(rs, "ApprovedAt"));

        st.setRecountRequestedBy(rs.getInt("RecountRequestedBy"));
        st.setRecountRequestedAt(getLocalDateTime(rs, "RecountRequestedAt"));
        st.setRecountReason(rs.getString("RecountReason"));

        try {
            st.setCreatedByName(rs.getString("CreatedByName"));
        } catch (Exception ignored) {
        }
        try {
            st.setApprovedByName(rs.getString("ApprovedByName"));
        } catch (Exception ignored) {
        }
        try {
            st.setRecountByName(rs.getString("RecountByName"));
        } catch (Exception ignored) {
        }

        return st;
    }

    private LocalDateTime getLocalDateTime(ResultSet rs, String columnName) throws SQLException {
        Timestamp ts = rs.getTimestamp(columnName);
        return (ts != null) ? ts.toLocalDateTime() : null;
    }
}
