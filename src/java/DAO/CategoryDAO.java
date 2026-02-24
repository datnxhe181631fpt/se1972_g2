/*
 * Category DAO - reads from Categories table
 */
package DAO;

import entity.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO extends DBContext {

    private PreparedStatement stm;
    private ResultSet rs;

    /**
     * Lấy tất cả danh mục đang active, sắp xếp theo DisplayOrder.
     */
    public List<Category> getAllActiveCategories() {
        List<Category> list = new ArrayList<>();
        String sql = """
                     SELECT CategoryID, CategoryName, Description, Icon, DisplayOrder, IsActive
                     FROM Categories
                     WHERE IsActive = 1
                     ORDER BY DisplayOrder ASC, CategoryID ASC
                     """;
        try {
            Connection conn = getConnection();
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(extractCategoryFromResultSet(rs));
            }
        } catch (Exception e) {
            System.out.println("ERR: getAllActiveCategories: " + e.getMessage());
        }
        return list;
    }

    private Category extractCategoryFromResultSet(ResultSet rs) throws Exception {
        Category c = new Category();
        c.setCategoryID(rs.getInt("CategoryID"));
        c.setCategoryName(rs.getString("CategoryName"));
        c.setDescription(rs.getString("Description"));
        c.setIcon(rs.getString("Icon"));
        c.setDisplayOrder(rs.getObject("DisplayOrder") != null ? rs.getInt("DisplayOrder") : null);
        c.setIsActive(rs.getBoolean("IsActive"));
        return c;
    }
}
