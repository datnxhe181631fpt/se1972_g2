

package DAO;

import entity.Shift;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;


public class ShiftDAO extends DBContext {

    public List<Shift> getAllShifts() {
        List<Shift> list = new ArrayList<>();
        String sql = "SELECT * FROM Shifts";

        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Shift s = new Shift();
                s.setShiftID(rs.getInt("ShiftID"));
                s.setShiftName(rs.getString("ShiftName"));
                s.setStartTime(rs.getString("StartTime"));
                s.setEndTime(rs.getString("EndTime"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}