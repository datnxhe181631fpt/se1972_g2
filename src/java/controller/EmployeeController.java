package controller;

import DAO.EmployeeDAO;
import DAO.RoleDAO;
import DAO.HRAuditLogDAO;
import entity.Employee;
import entity.Role;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "EmployeeController", urlPatterns = {"/admin/employees"})
public class EmployeeController extends HttpServlet {

    private EmployeeDAO employeeDAO;
    private RoleDAO roleDAO;
    private HRAuditLogDAO auditLogDAO;

    @Override
    public void init() {
        employeeDAO = new EmployeeDAO();
        roleDAO = new RoleDAO();
        auditLogDAO = new HRAuditLogDAO();
    }

    // ================= DO GET =================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listEmployees(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deactivateEmployee(request, response);
                break;
            case "toggle":
                toggleEmployeeStatus(request, response);
                break;
            default:
                listEmployees(request, response);
        }
    }

    // ================= DO POST =================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addEmployee(request, response);
        } else if ("edit".equals(action)) {
            updateEmployee(request, response);
        }
    }

    // ================= LIST =================
    private void listEmployees(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        String roleParam = request.getParameter("roleId");
        String status = request.getParameter("status");
        String pageParam = request.getParameter("page");
        String pageSizeParam = request.getParameter("pageSize");

        int page = 1;
        int pageSize = 10;
        Integer roleId = null;

        try {
            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
            }
            if (pageSizeParam != null) {
                pageSize = Integer.parseInt(pageSizeParam);
            }
            if (roleParam != null && !roleParam.isEmpty()) {
                roleId = Integer.parseInt(roleParam);
            }
        } catch (Exception ignored) {
        }

        List<Employee> employees = employeeDAO.getEmployees(
                search, roleId, status, page, pageSize
        );

        int totalRecords = employeeDAO.getTotalEmployees(search, roleId, status);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        request.setAttribute("employees", employees);
        request.setAttribute("roles", roleDAO.getAllRoles());
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalRecords", totalRecords);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search);
        request.setAttribute("roleId", roleId);
        request.setAttribute("status", status);

        request.getRequestDispatcher("/AdminLTE-3.2.0/admin-employee-list.jsp")
                .forward(request, response);
    }

    // ================= SHOW ADD =================
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("roles", roleDAO.getAllRoles());
        request.getRequestDispatcher("/AdminLTE-3.2.0/admin-employee-detail.jsp")
                .forward(request, response);
    }

    // ================= SHOW EDIT =================
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Employee employee = employeeDAO.getEmployeeByID(id);

        request.setAttribute("employee", employee);
        request.setAttribute("roles", roleDAO.getAllRoles());
        request.getRequestDispatcher("/AdminLTE-3.2.0/admin-employee-detail.jsp")
                .forward(request, response);
    }

    // ================= ADD =================
    private void addEmployee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Employee e = buildEmployeeFromRequest(request);
        boolean success = employeeDAO.insertEmployee(e);

        if (success) {
            auditLogDAO.insertLog(
                    e.getEmployeeId(),
                    "CREATE",
                    "ADMIN" // TODO: lấy từ session
            );
            response.sendRedirect(request.getContextPath()
                    + "/admin/employees?msg=add_success");
        } else {
            request.setAttribute("error", "Thêm nhân viên thất bại!");
            request.setAttribute("employee", e);
            request.setAttribute("roles", roleDAO.getAllRoles());
            request.getRequestDispatcher("/AdminLTE-3.2.0/admin-employee-detail.jsp")
                    .forward(request, response);
        }
    }

    // ================= UPDATE =================
    private void updateEmployee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Employee e = buildEmployeeFromRequest(request);
        e.setEmployeeId(Integer.parseInt(request.getParameter("employeeId")));

        boolean success = employeeDAO.updateEmployee(e);

        if (success) {
            auditLogDAO.insertLog(
                    e.getEmployeeId(),
                    "UPDATE",
                    "ADMIN"
            );
            response.sendRedirect(request.getContextPath()
                    + "/admin/employees?msg=update_success");
        } else {
            request.setAttribute("error", "Cập nhật nhân viên thất bại!");
            request.setAttribute("employee", e);
            request.setAttribute("roles", roleDAO.getAllRoles());
            request.getRequestDispatcher("/AdminLTE-3.2.0/admin-employee-detail.jsp")
                    .forward(request, response);
        }
    }

    // ================= DEACTIVATE =================
    private void deactivateEmployee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = employeeDAO.deactivateEmployee(id);

        if (success) {
            auditLogDAO.insertLog(id, "DEACTIVATE", "ADMIN");
            response.sendRedirect(request.getContextPath()
                    + "/admin/employees?msg=delete_success");
        } else {
            response.sendRedirect(request.getContextPath()
                    + "/admin/employees?msg=delete_error");
        }
    }

    // ================= TOGGLE =================
    private void toggleEmployeeStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Employee e = employeeDAO.getEmployeeByID(id);

        if (e != null) {
            String newStatus = e.getStatus().equalsIgnoreCase("Active")
                    ? "Inactive" : "Active";

            e.setStatus(newStatus);
            employeeDAO.updateEmployee(e);

            auditLogDAO.insertLog(
                    id,
                    newStatus.equals("Active") ? "ACTIVATE" : "DEACTIVATE",
                    "ADMIN"
            );

            response.sendRedirect(request.getContextPath()
                    + "/admin/employees?msg=toggle_success");
        } else {
            response.sendRedirect(request.getContextPath()
                    + "/admin/employees?msg=toggle_error");
        }
    }

    // ================= UTIL =================
    private Employee buildEmployeeFromRequest(HttpServletRequest request) {

        Employee e = new Employee();
        e.setFullName(request.getParameter("fullName"));
        e.setEmail(request.getParameter("email"));
        e.setPhone(request.getParameter("phone"));

        // Hire date (nullable)
        String hireDate = request.getParameter("hireDate");
        if (hireDate != null && !hireDate.isEmpty()) {
            e.setHireDate(Date.valueOf(hireDate));
        }

        // Role
        String roleIdRaw = request.getParameter("roleId");
        if (roleIdRaw == null || roleIdRaw.isEmpty()) {
            throw new IllegalArgumentException("Role không được để trống");
        }

        Role r = new Role();
        r.setRoleId(Integer.parseInt(roleIdRaw));
        e.setRole(r);

        // Status
        String status = request.getParameter("status");
        e.setStatus(status != null ? status : "Active");

        return e;
    }

}
