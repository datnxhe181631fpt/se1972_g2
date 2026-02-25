/*
 * Product DAO for POS module
 */
package DAO;

import entity.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO extends DBContext {

    private PreparedStatement stm;
    private ResultSet rs;

    public Product getProductBySku(String sku) {
        String sql = "SELECT TOP 1 * FROM Products WHERE SKU = ? AND IsActive = 1";
        try {
            Connection conn = getConnection();
            stm = conn.prepareStatement(sql);
            stm.setString(1, sku);
            rs = stm.executeQuery();
            if (rs.next()) {
                return extractProductFromResultSet(rs);
            }
        } catch (Exception e) {
            System.out.println("ERR: getProductBySku: " + e.getMessage());
        }
        return null;
    }

    /**
     * Lấy sản phẩm từ DB: lọc theo từ khóa (tên/SKU) và/hoặc CategoryID, giới hạn số dòng.
     *
     * @param keyword  từ khóa tìm kiếm (null hoặc rỗng = không lọc theo tên/SKU)
     * @param categoryId ID danh mục (null = tất cả danh mục)
     * @param limit   số sản phẩm tối đa
     */
    public List<Product> getProducts(String keyword, Integer categoryId, int limit) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT * FROM Products WHERE IsActive = 1 ");
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (ProductName LIKE ? OR SKU LIKE ?) ");
        }
        if (categoryId != null) {
            sql.append("AND CategoryID = ? ");
        }
        sql.append("ORDER BY ProductID DESC OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY");
        try {
            Connection conn = getConnection();
            stm = conn.prepareStatement(sql.toString());
            int idx = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String pattern = "%" + keyword.trim() + "%";
                stm.setString(idx++, pattern);
                stm.setString(idx++, pattern);
            }
            if (categoryId != null) {
                stm.setInt(idx++, categoryId);
            }
            stm.setInt(idx, limit);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(extractProductFromResultSet(rs));
            }
        } catch (Exception e) {
            System.out.println("ERR: getProducts: " + e.getMessage());
        }
        return list;
    }

    private Product extractProductFromResultSet(ResultSet rs) throws Exception {
        Product p = new Product();
        p.setProductID(rs.getInt("ProductID"));
        p.setProductName(rs.getString("ProductName"));
        p.setCategoryID(rs.getInt("CategoryID"));
        p.setBrandID(rs.getInt("BrandID"));
        p.setSupplierID(rs.getInt("SupplierID"));
        p.setSku(rs.getString("SKU"));
        p.setDescription(rs.getString("Description"));
        p.setCostPrice(rs.getDouble("CostPrice"));
        p.setSellingPrice(rs.getDouble("SellingPrice"));
        p.setStock(rs.getInt("Stock"));
        p.setReorderLevel(rs.getInt("ReorderLevel"));
        p.setIsActive(rs.getBoolean("IsActive"));
        return p;
    }
}

