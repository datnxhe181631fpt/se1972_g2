package controller;

import DAO.EmployeeDAO;
import DAO.ShiftAssignmentDAO;
import DAO.ShiftDAO;
import entity.Employee;
import entity.EmployeeShiftAssignment;
import entity.Shift;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.Date;
import java.util.List;

@WebServlet("/admin/shift-management")
public class ShiftManagementController extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        EmployeeDAO empDAO = new EmployeeDAO();
        ShiftDAO shiftDAO = new ShiftDAO();
        ShiftAssignmentDAO assignDAO = new ShiftAssignmentDAO();   // thêm dòng này

        String search = request.getParameter("search");
        String status = request.getParameter("status");

        if (status == null || status.isEmpty()) {
            status = "ACTIVE";
        }

        int page = 1;
        int pageSize = 5;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        List<Employee> employees
                = empDAO.getEmployees(search, null, status, page, pageSize);

        int total = empDAO.getTotalEmployees(search, null, status);
        int totalPage = (int) Math.ceil(total * 1.0 / pageSize);

        request.setAttribute("employees", employees);
        request.setAttribute("totalPages", totalPage);
        request.setAttribute("currentPage", page);

        // ===== LẤY DANH SÁCH SHIFT =====
        List<Shift> shifts = shiftDAO.getAllShifts();
        request.setAttribute("shifts", shifts);

        // ===== THÊM PHẦN NÀY =====
        Date today = new Date(System.currentTimeMillis());

        if (request.getParameter("viewDate") != null) {
            today = Date.valueOf(request.getParameter("viewDate"));
        }

        List<EmployeeShiftAssignment> assignments
                = assignDAO.getAssignmentsByDate(today);

        request.setAttribute("assignments", assignments);
        request.setAttribute("viewDate", today);
        // ==============================

        request.getRequestDispatcher(
                "/AdminLTE-3.2.0/admin-shift-management.jsp")
                .forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int empID = Integer.parseInt(request.getParameter("employeeID"));
        int shiftID = Integer.parseInt(request.getParameter("shiftID"));
        Date workDate = Date.valueOf(request.getParameter("workDate"));

        Date today = new Date(System.currentTimeMillis());

        if (workDate.before(today)) {
            response.sendRedirect("shift-management?error=pastdate");
            return;
        }

        ShiftAssignmentDAO dao = new ShiftAssignmentDAO();
        dao.assignShift(empID, shiftID, workDate, 1); // test admin id

        response.sendRedirect("shift-management?viewDate=" + workDate + "&success=1");
    }
}
