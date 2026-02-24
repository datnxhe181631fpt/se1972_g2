/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import entity.PurchaseOrder;
import entity.PurchaseOrderItem;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.time.LocalDate;
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
        String sql = """
                     select po.*, s.SupplierName, e1.FullName as CreatedByName, 
                     e2.FullName as ApprovedByName,
                     e3.FullName as CancelledByName
                     from PurchaseOrders po
                     left join Suppliers s on po.SupplierID = s.SupplierID
                     left join Employees e1 on po.CreatedBy = e1.EmployeeID
                     left join Employees e2 on po.ApprovedBy = e2.EmployeeID  
                     left join Employees e3 ON po.CancelledBy= e3.EmployeeID 
                     """;
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
        String sql = """
                      select po.*, s.SupplierName, e1.FullName as CreatedByName, 
                                          e2.FullName as ApprovedByName,
                                          e3.FullName as CancelledByName
                                          from PurchaseOrders po
                                          left join Suppliers s on po.SupplierID = s.SupplierID
                                          left join Employees e1 on po.CreatedBy = e1.EmployeeID
                                          left join Employees e2 on po.ApprovedBy = e2.EmployeeID  
                                          left join Employees e3 ON po.CancelledBy= e3.EmployeeID
                     where po.PONumber = ?
                     """;
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
        String sql = """
                      select po.*, s.SupplierName, e1.FullName as CreatedByName, 
                                          e2.FullName as ApprovedByName,
                                          e3.FullName as CancelledByName
                                          from PurchaseOrders po
                                          left join Suppliers s on po.SupplierID = s.SupplierID
                                          left join Employees e1 on po.CreatedBy = e1.EmployeeID
                                          left join Employees e2 on po.ApprovedBy = e2.EmployeeID  
                                          left join Employees e3 ON po.CancelledBy= e3.EmployeeID
                     where po.POID = ?
                     """;
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

    public List<PurchaseOrder> getPurchaseOrdersBySupplier(int supplierId) {
        String sql = "select * from PurchaseOrders where supplierId = ?";
        List<PurchaseOrder> lists = new ArrayList<>();
        Connection connection = getConnection();
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                lists.add(extractPurchaseOrderFromResultSet(rs));
            }
        } catch (Exception e) {
            System.out.println("ERR: getPurchaseOrdersBySupplier: " + e.getMessage());
        }
        return lists;
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

    public boolean createOrderWithItems(PurchaseOrder po) {
        PreparedStatement stmPO = null;
        PreparedStatement stmItems = null;
        Connection connection = null;
        ResultSet generatedKey = null;

        String sqlPO = """
                       insert into PurchaseOrders (PONumber, SupplierID, OrderDate, ExpectedDate, Subtotal, TotalDiscount, TotalAmount, Notes, CreatedBy)
                                        values(?,?,?,?,?,?,?,?,?)
                       """;
        String sqlItem = """
                         insert into PurchaseOrderItems
                                          (POID, ProductID, QuantityOrdered, UnitPrice, DiscountType, DiscountValue, LineTotal, Notes)
                                          values (?,?,?,?,?,?,?,?)
                         """;

        try {
            connection = getConnection();
            connection.setAutoCommit(false);

            //insert po header
            stmPO = connection.prepareStatement(sqlPO, Statement.RETURN_GENERATED_KEYS);
            int index = 1;
            stmPO.setString(index++, po.getPoNumber());
            stmPO.setObject(index++, po.getSupplierId());
            stmPO.setDate(index++, Date.valueOf(po.getOrderDate()));
            stmPO.setDate(index++, Date.valueOf(po.getExpectedDate()));
            stmPO.setBigDecimal(index++, po.getSubtotal());
            stmPO.setBigDecimal(index++, po.getTotalDiscount());
            stmPO.setBigDecimal(index++, po.getTotalAmount());
            stmPO.setString(index++, po.getNotes());
            stmPO.setObject(index++, po.getCreatedBy());

            int affectedRows = stmPO.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating PO failed, no rows affected.");
            }

            long generatedPoId = 0;
            try {
                generatedKey = stmPO.getGeneratedKeys();
                if (generatedKey.next()) {
                    generatedPoId = generatedKey.getLong(1);
                    po.setId(generatedPoId);
                } else {
                    throw new SQLException("Creating PO failed, no rows affected.");
                }
            } catch (Exception e) {
                System.out.println("Creating PO failed, no rows affected.");
            }

            //insert po items 
            if (po.getItems() != null && !po.getItems().isEmpty()) {
                stmItems = connection.prepareStatement(sqlItem);
                for (PurchaseOrderItem item : po.getItems()) {
                    int idx = 1;
                    stmItems.setLong(idx++, generatedPoId);
                    stmItems.setInt(idx++, item.getProductId());
                    stmItems.setInt(idx++, item.getQuantityOrdered());
                    stmItems.setBigDecimal(idx++, item.getUnitPrice());
                    stmItems.setString(idx++, item.getDiscountType());
                    stmItems.setBigDecimal(idx++, item.getDiscountValue());
                    stmItems.setBigDecimal(idx++, item.getLineTotal());
                    stmItems.setString(idx++, item.getNotes());

                    stmItems.addBatch();
                }
                stmItems.executeBatch();
            }
            connection.commit();
            return true;
        } catch (Exception e) {
            System.out.println("ERR: Transaction Create Order Failed: " + e.getMessage());
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;

        } finally {
            // Close resources
            try {
                if (generatedKey != null) {
                    generatedKey.close();
                }
                if (stmPO != null) {
                    stmPO.close();
                }
                if (stmItems != null) {
                    stmItems.close();
                }
                if (connection != null) {
                    connection.close(); // Quan trọng: Trả connection về pool
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public boolean updateOrderWithItems(PurchaseOrder po) {
        Connection connection = null;
        PreparedStatement stmUpdatePO = null;
        PreparedStatement stmDelItems = null;
        PreparedStatement stmAddItems = null;

        String sqlUpdatePO = """
                             update PurchaseOrders 
                             set SupplierID = ?, OrderDate = ?, ExpectedDate=?, Subtotal=?,
                             TotalDiscount=?, TotalAmount=?, Notes=?, UpdatedAt=GETUTCDATE()
                             where PONumber=?
                             """;

        String sqlDeleteItem = """
                             delete from PurchaseOrderItems where POID = ?
                            """;

        String sqlAddItem = """
                            insert into PurchaseOrderItems
                                             (POID, ProductID, QuantityOrdered, UnitPrice, DiscountType, DiscountValue, LineTotal, Notes)
                                             values (?,?,?,?,?,?,?,?)
                            """;
        try {
            connection = getConnection();
            connection.setAutoCommit(false);

            stmUpdatePO = connection.prepareStatement(sqlUpdatePO);
            int index = 1;
            stmUpdatePO.setLong(index++, po.getSupplierId());
            stmUpdatePO.setDate(index++, Date.valueOf(po.getOrderDate()));
            stmUpdatePO.setDate(index++, Date.valueOf(po.getExpectedDate()));
            stmUpdatePO.setBigDecimal(index++, po.getSubtotal());
            stmUpdatePO.setBigDecimal(index++, po.getTotalDiscount());
            stmUpdatePO.setBigDecimal(index++, po.getTotalAmount());
            stmUpdatePO.setString(index++, po.getNotes());
            stmUpdatePO.setString(index++, po.getPoNumber());
            stmUpdatePO.executeUpdate();

            long poId = po.getId();

            stmDelItems = connection.prepareStatement(sqlDeleteItem);
            stmDelItems.setLong(1, poId);
            stmDelItems.executeUpdate();

            if (po.getItems() != null && !po.getItems().isEmpty()) {
                stmAddItems = connection.prepareStatement(sqlAddItem);
                for (PurchaseOrderItem item : po.getItems()) {
                    int idx = 1;
                    stmAddItems.setLong(idx++, poId);
                    stmAddItems.setInt(idx++, item.getProductId());
                    stmAddItems.setInt(idx++, item.getQuantityOrdered());
                    stmAddItems.setBigDecimal(idx++, item.getUnitPrice());
                    stmAddItems.setString(idx++, item.getDiscountType());
                    stmAddItems.setBigDecimal(idx++, item.getDiscountValue());
                    stmAddItems.setBigDecimal(idx++, item.getLineTotal());
                    stmAddItems.setString(idx++, item.getNotes());
                    stmAddItems.addBatch();
                }
                stmAddItems.executeBatch();
            }

            connection.commit();
            return true;
        } catch (Exception e) {
            System.out.println("ERR: Transaction Update Order Failed: " + e.getMessage());
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;
        }
    }

    //cancel
    public boolean cancelPO(String poNumber, int by, String reason) {
        Connection connection = getConnection();
        String sql = """
                    update PurchaseOrders set CancelledBy = ?,
                                              CancellationReason = ?,
                                              Status = 'CANCELLED'
                                              where PONumber = ?
                """;
        try {
            int index = 1;
            stm = connection.prepareStatement(sql);
            stm.setInt(index++, by);
            stm.setString(index++, reason);
            stm.setString(index++, poNumber);
            return stm.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("CancelPO: " + e.getMessage());
        }
        return false;
    }

    //reject
    public boolean rejectPO(String poNumber, int by, String reason) {
        Connection connection = getConnection();
        String sql = """
                  update PurchaseOrders set ApprovedBy = ?,
                                                                     RejectionReason = ?,
                                                                     Status = 'REJECTED',
                                                                     ApprovedAt = GETUTCDATE()
                                                                 where PONumber = ?
                """;
        try {
            int index = 1;
            stm = connection.prepareStatement(sql);
            stm.setInt(index++, by);
            stm.setString(index++, reason);
            stm.setString(index++, poNumber);
            return stm.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("rejectPO: " + e.getMessage());
        }
        return false;
    }

    //approve
    public boolean approvePO(String poNumber, int by) {
        Connection connection = getConnection();
        String sql = """
                  update PurchaseOrders set ApprovedBy = ?,
                                           Status = 'APPROVED',
                                           ApprovedAt = GETUTCDATE()
                                           where PONumber = ?
                """;
        try {
            int index = 1;
            stm = connection.prepareStatement(sql);
            stm.setInt(index++, by);
            stm.setString(index++, poNumber);
            return stm.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("ApprovePO: " + e.getMessage());
        }
        return false;
    }

    public boolean updatePurchaseOrder(PurchaseOrder po) {
        String sql = """
                update PurchaseOrders 
                set SupplierID = ?, 
                    OrderDate = ?, 
                    ExpectedDate = ?, 
                    Subtotal = ?, 
                    TotalDiscount = ?, 
                    TotalAmount = ?, 
                    Notes = ?,
                    UpdatedAt = GETUTCDATE()
                where PONumber = ?
                """;
        try {
            Connection connection = getConnection();
            int index = 1;
            stm = connection.prepareStatement(sql);
            stm.setLong(index++, po.getSupplierId());
            stm.setDate(index++, Date.valueOf(po.getOrderDate()));
            stm.setDate(index++, Date.valueOf(po.getExpectedDate()));
            stm.setBigDecimal(index++, po.getSubtotal());
            stm.setBigDecimal(index++, po.getTotalDiscount());
            stm.setBigDecimal(index++, po.getTotalAmount());
            stm.setString(index++, po.getNotes());
            stm.setString(index++, po.getPoNumber());
            return stm.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("ERR: UpdatePurchaseOrder: " + e.getMessage());
        }
        return false;
    }

    //delete
    public boolean deletePurchaseOrder(String poNumber) {
        String sql = "delete from PurchaseOrders where PONumber = ?";
        try {
            Connection connection = getConnection();
            stm = connection.prepareStatement(sql);
            stm.setString(1, poNumber);
            return stm.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("ERR: DeletePurchaseOrder: " + e.getMessage());
        }
        return false;
    }

    //search
    public List<PurchaseOrder> searchPO(String keyword, String status, LocalDate fromDate, LocalDate toDate) {
        List<PurchaseOrder> lists = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("select * from PurchaseOrders where 1 = 1 ");
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (PONumber like ? OR Notes like ?) ");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND Status = ? ");
        }
        if (fromDate != null) {
            sql.append(" AND OrderDate >= ?");
        }
        if (toDate != null) {
            sql.append(" AND OrderDate <= ?");
        }

//        sql.append("order by poID desc ");
        try {
            Connection connection = getConnection();

            stm = connection.prepareStatement(sql.toString());
            int paramIndex = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchPattern = "%" + keyword + "%";
                stm.setString(paramIndex++, searchPattern);
                stm.setString(paramIndex++, searchPattern);
            }
            if (status != null && !status.trim().isEmpty()) {
                stm.setString(paramIndex++, status);
            }
            if (fromDate != null) {
                stm.setDate(paramIndex++, Date.valueOf(fromDate));
            }
            if (toDate != null) {
                stm.setDate(paramIndex++, Date.valueOf(toDate));
            }

            rs = stm.executeQuery();
            while (rs.next()) {
                lists.add(extractPurchaseOrderFromResultSet(rs));
            }
        } catch (Exception e) {
            System.out.println("ERR: SearchPurchaseOrders: " + e.getMessage());

        }
        return lists;
    }

    //search
//    public List<PurchaseOrder> searchPOWithPaginated(String keyword, String status, LocalDate fromDate, LocalDate toDate, int page, int pageSize) {
//        List<PurchaseOrder> lists = new ArrayList<>();
//        StringBuilder sql = new StringBuilder();
//        int offset = (page - 1) * pageSize;
//        sql.append("select * from PurchaseOrders where 1 = 1 ");
//        if (keyword != null && !keyword.trim().isEmpty()) {
//            sql.append("AND (PONumber like ? OR Notes like ?) ");
//        }
//        if (status != null && !status.trim().isEmpty()) {
//            sql.append("AND Status = ? ");
//        }
//        if (fromDate != null) {
//            sql.append(" AND OrderDate >= ?");
//        }
//        if (toDate != null) {
//            sql.append(" AND OrderDate <= ?");
//        }
//
//        sql.append("order by poID desc ");
//        sql.append("offset ? rows fetch next ? rows only");
//        try {
//            Connection connection = getConnection();
//
//            stm = connection.prepareStatement(sql.toString());
//            int paramIndex = 1;
//
//            if (keyword != null && !keyword.trim().isEmpty()) {
//                String searchPattern = "%" + keyword + "%";
//                stm.setString(paramIndex++, searchPattern);
//                stm.setString(paramIndex++, searchPattern);
//            }
//            if (status != null && !status.trim().isEmpty()) {
//                stm.setString(paramIndex++, status);
//            }
//            if (fromDate != null) {
//                stm.setDate(paramIndex++, Date.valueOf(fromDate));
//            }
//            if (toDate != null) {
//                stm.setDate(paramIndex++, Date.valueOf(toDate));
//            }
//
//            stm.setInt(paramIndex++, offset);
//            stm.setInt(paramIndex++, pageSize);
//
//            rs = stm.executeQuery();
//            while (rs.next()) {
//                lists.add(extractPurchaseOrderFromResultSet(rs));
//            }
//        } catch (Exception e) {
//            System.out.println("ERR: SearchPurchaseOrdersWithPaginated: " + e.getMessage());
//
//        }
//        return lists;
//    }
    //add supplierName + userName
    public List<PurchaseOrder> searchPOWithPaginated(String keyword, String status, LocalDate fromDate, LocalDate toDate, int page, int pageSize) {
        List<PurchaseOrder> lists = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        int offset = (page - 1) * pageSize;
        sql.append("select p.*, s.SupplierName, e.FullName as CreatedByName ");
        sql.append("from PurchaseOrders p ");
        sql.append("left join Suppliers s on p.SupplierId = s.SupplierId ");
        sql.append("left join Employees e on p.CreatedBy = e.EmployeeID ");
        sql.append("where 1 = 1 ");
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (PONumber like ? OR Notes like ?) ");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND Status = ? ");
        }
        if (fromDate != null) {
            sql.append(" AND OrderDate >= ?");
        }
        if (toDate != null) {
            sql.append(" AND OrderDate <= ?");
        }

        sql.append("order by poID desc ");
        sql.append("offset ? rows fetch next ? rows only");
        try {
            Connection connection = getConnection();

            stm = connection.prepareStatement(sql.toString());
            int paramIndex = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchPattern = "%" + keyword + "%";
                stm.setString(paramIndex++, searchPattern);
                stm.setString(paramIndex++, searchPattern);
            }
            if (status != null && !status.trim().isEmpty()) {
                stm.setString(paramIndex++, status);
            }
            if (fromDate != null) {
                stm.setDate(paramIndex++, Date.valueOf(fromDate));
            }
            if (toDate != null) {
                stm.setDate(paramIndex++, Date.valueOf(toDate));
            }

            stm.setInt(paramIndex++, offset);
            stm.setInt(paramIndex++, pageSize);

            rs = stm.executeQuery();
            while (rs.next()) {
                PurchaseOrder po = extractPurchaseOrderFromResultSet(rs);
                po.setSupplierName(rs.getString("SupplierName"));
                po.setCreatedByName(rs.getString("CreatedByName"));
                lists.add(po);
            }
        } catch (Exception e) {
            System.out.println("ERR: SearchPurchaseOrdersWithPaginated: " + e.getMessage());

        }
        return lists;
    }

    //count (for pagination)
    public int countPOs() {
        String sql = "Select COUNT(*) from PurchaseOrders ";
        try {
            Connection connection = getConnection();

            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("ERR: countPOs: " + e.getMessage());
        }
        return 0;
    }

    //count by conditions
    public int countPOs(String keyword, String status, LocalDate fromDate, LocalDate toDate) {
        StringBuilder sql = new StringBuilder();
        sql.append("select COUNT(*) from PurchaseOrders where 1 = 1 ");
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (PONumber like ? OR Notes like ?) ");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND Status = ? ");
        }
        if (fromDate != null) {
            sql.append(" AND OrderDate >= ?");
        }
        if (toDate != null) {
            sql.append(" AND OrderDate <= ?");
        }

//        sql.append("order by poID desc ");
        try {
            Connection connection = getConnection();

            stm = connection.prepareStatement(sql.toString());
            int paramIndex = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchPattern = "%" + keyword + "%";
                stm.setString(paramIndex++, searchPattern);
                stm.setString(paramIndex++, searchPattern);
            }
            if (status != null && !status.trim().isEmpty()) {
                stm.setString(paramIndex++, status);
            }
            if (fromDate != null) {
                stm.setDate(paramIndex++, Date.valueOf(fromDate));
            }
            if (toDate != null) {
                stm.setDate(paramIndex++, Date.valueOf(toDate));
            }

            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("ERR: countPurchaseOrders: " + e.getMessage());
        }
        return 0;
    }

    //check exist
    public boolean isCodeExist(String code) {
        String sql = "select 1 from PurchaseOrders where PONumber = ?";
        try {
            Connection connection = getConnection();

            stm = connection.prepareStatement(sql);
            stm.setString(1, code);
            rs = stm.executeQuery();
            return rs.next();
        } catch (Exception e) {
            System.out.println("ERR: isPONumberExists: " + e.getMessage());
        }
        return false;
    }

    //generate poNumber : PO-nam-so : PO-2026-0001
    public String generateNextPONumber() {
        String sql = """
                     select top 1 PONumber
                     from PurchaseOrders
                     where PONumber like ?
                     order by PONumber desc
                     """;
        int currentYear = java.time.Year.now().getValue();
        try {
            Connection connection = getConnection();
            String yearPrefix = "PO-" + currentYear + '-';

            stm = connection.prepareStatement(sql);
            stm.setString(1, yearPrefix + "%");
            rs = stm.executeQuery();

            if (rs.next()) {
                String lastPONumber = rs.getString("PONumber");
                String numberPart = lastPONumber.substring(lastPONumber.lastIndexOf("-") + 1);
                int nextNumber = Integer.parseInt(numberPart) + 1;
                return String.format("PO-%d-%04d", currentYear, nextNumber);
            } else {
                return String.format("PO-%d-%04d", currentYear, 1);
            }
        } catch (Exception e) {
            System.out.println("ERR: GeneratePONumber: " + e.getMessage());
            return String.format("PO-%d-%04d", currentYear, 1);
        }
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

        try {
            po.setSupplierName(rs.getString("SupplierName"));
        } catch (SQLException e) {
        }
        try {
            po.setCreatedByName(rs.getString("CreatedByName"));
        } catch (SQLException e) {
        }
        try {
            po.setApprovedByName(rs.getString("ApprovedByName"));
        } catch (SQLException e) {
        }
        try {
            po.setCancelledByName(rs.getString("CancelledByName"));
        } catch (SQLException e) {
        }
        return po;
    }

    private LocalDateTime getLocalDateTime(ResultSet rs, String columnName) throws SQLException {
        Timestamp ts = rs.getTimestamp(columnName);
        return (ts != null) ? ts.toLocalDateTime() : null;
    }
}
