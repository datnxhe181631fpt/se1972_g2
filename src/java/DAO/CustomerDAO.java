package DAO;

import entity.Customer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.lang.*;
import java.io.*;
/*
*
*
*/
public class CustomerDAO extends DBContext {

    /**
     * Sinh mã khách hàng tiếp theo dạng KH001, KH002, ...
     */
    public String getNextCustomerId() {
        String sql = "SELECT MAX(CustomerID) FROM Customers WHERE CustomerID LIKE 'KH%'";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                String maxId = rs.getString(1);
                if (maxId == null || maxId.isEmpty()) return "KH001";
                String numPart = maxId.length() > 2 ? maxId.substring(2) : "0";
                try {
                    int n = Integer.parseInt(numPart);
                    return String.format("KH%03d", n + 1);
                } catch (NumberFormatException e) {
                    return "KH001";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "KH001";
    }

    // CREATE
    public void insert(Customer c) {
        String sql = """
            INSERT INTO Customers(CustomerID, FullName, Email, PhoneNumber, Birthday, Status, Note)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """;
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, c.getCustomerID());
            ps.setString(2, c.getFullName());
            ps.setString(3, c.getEmail());
            ps.setString(4, c.getPhoneNumber());
            if (c.getBirthday() != null) {
                ps.setDate(5, Date.valueOf(c.getBirthday()));
            } else {
                ps.setNull(5, java.sql.Types.DATE);
            }
            ps.setString(6, c.getStatus());
            ps.setString(7, c.getNote());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // READ by ID
    public Customer getById(String id) {
        String sql = "SELECT * FROM Customers WHERE CustomerID = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return map(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // READ by Email
    public Customer getByEmail(String email) {
        String sql = "SELECT * FROM Customers WHERE Email = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return map(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // READ by PhoneNumber
    public Customer getByPhone(String phoneNumber) {
        String sql = "SELECT * FROM Customers WHERE PhoneNumber = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, phoneNumber);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return map(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // READ ALL
    public List<Customer> getAll() {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM Customers";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(map(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // UPDATE
    public void update(Customer c) {
        String sql = """
            UPDATE Customers
            SET FullName=?, Email=?, PhoneNumber=?, Birthday=?, Status=?, Note=?
            WHERE CustomerID=?
        """;
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, c.getFullName());
            ps.setString(2, c.getEmail());
            ps.setString(3, c.getPhoneNumber());
            if (c.getBirthday() != null) {
                ps.setDate(4, Date.valueOf(c.getBirthday()));
            } else {
                ps.setNull(4, java.sql.Types.DATE);
            }
            ps.setString(5, c.getStatus());
            ps.setString(6, c.getNote());
            ps.setString(7, c.getCustomerID());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // DELETE
    public void delete(String id) {
        String sql = "DELETE FROM Customers WHERE CustomerID=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Customer map(ResultSet rs) throws SQLException {
        Customer c = new Customer();
        c.setCustomerID(rs.getString("CustomerID"));
        c.setFullName(rs.getString("FullName"));
        c.setEmail(rs.getString("Email"));
        c.setPhoneNumber(rs.getString("PhoneNumber"));
        Date birthday = rs.getDate("Birthday");
        if (birthday != null) {
            c.setBirthday(birthday.toLocalDate());
        }
        Timestamp registerTs = rs.getTimestamp("RegisterDate");
        if (registerTs != null) {
            c.setRegisterDate(registerTs.toLocalDateTime());
        }
        c.setStatus(rs.getString("Status"));
        c.setNote(rs.getString("Note"));
        return c;
    }
}
