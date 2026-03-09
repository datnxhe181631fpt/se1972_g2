package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "DashboardController", urlPatterns = {"/admin/dashboard"})
public class DashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("employee") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get user info from session
        String employeeName = (String) session.getAttribute("employeeName");
        String employeeRoleName = (String) session.getAttribute("employeeRoleName");
        Integer employeeRoleId = (Integer) session.getAttribute("employeeRoleId");
        
        // Set attributes for JSP
        request.setAttribute("employeeName", employeeName);
        request.setAttribute("employeeRoleName", employeeRoleName);
        request.setAttribute("employeeRoleId", employeeRoleId);
        
        // Forward to dashboard JSP
        request.getRequestDispatcher("/AdminLTE-3.2.0/dashboard.jsp").forward(request, response);
    }
}
