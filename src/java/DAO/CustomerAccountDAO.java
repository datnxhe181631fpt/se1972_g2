package DAO;

import entity.CustomerAccount;
import java.sql.*;
import java.time.LocalDateTime;

public class CustomerAccountDAO extends DBContext {

    public CustomerAccount getAccountById(String customerID) {
        String sql = "SELECT * FROM CustomerAccount WHERE CustomerID = ?";
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, customerID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return map(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insert(CustomerAccount acc) {
        String sql = "INSERT INTO CustomerAccount (CustomerID, Password) VALUES (?, ?)";
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, acc.getCustomerID());
            ps.setString(2, acc.getPassword());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public CustomerAccount login(String customerID, String password) {
        String sql = "SELECT * FROM CustomerAccount WHERE CustomerID = ? AND Password = ?";
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, customerID);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                CustomerAccount acc = map(rs);
                updateLastLogin(customerID);
                return acc;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateLastLogin(String customerID) {
        String sql = "UPDATE CustomerAccount SET LastLogin = ? WHERE CustomerID = ?";
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            ps.setString(2, customerID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updatePassword(String customerID, String newPassword) {
        String sql = "UPDATE CustomerAccount SET Password = ? WHERE CustomerID = ?";
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, customerID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private CustomerAccount map(ResultSet rs) throws SQLException {
        CustomerAccount acc = new CustomerAccount();
        acc.setCustomerID(rs.getString("CustomerID"));
        acc.setPassword(rs.getString("Password"));
        

        
        Timestamp lastLogin = rs.getTimestamp("LastLogin");
        if (lastLogin != null) {
            acc.setLastLogin(lastLogin.toLocalDateTime());
        }
        
        return acc;
    }
}
