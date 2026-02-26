/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import entity.Product;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

/**
 *
 * @author qp
 */
public class ProductDAO extends DBContext {

    PreparedStatement stm;
    ResultSet rs;
    Connection connection;

    public List<Product> getAllActiveProducts() {
        List<Product> products = new ArrayList<>();

        String sql = "select ProductID, ProductName, SellingPrice from Products where IsActive = 'true' order by ProductName";
        try {
            connection = getConnection();
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("ProductId"));
                p.setProductName(rs.getString("ProductName"));
                p.setSellingPrice(rs.getDouble("SellingPrice"));
                products.add(p);
            }
        } catch (Exception e) {
            System.out.println("ERR: getAllActiveProducts: " + e.getMessage());
        }
        return products;
    }
}
