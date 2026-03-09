/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import DAO.EmployeeDAO;
import entity.Employee;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author xuand
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login", "/logout"})
public class LoginController extends HttpServlet {
    
    private EmployeeDAO employeeDAO;
    
    @Override
    public void init() {
        employeeDAO = new EmployeeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        if ("/logout".equals(path)) {
            handleLogout(request, response);
        } else {
            // Show login page
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("employee") != null) {
                // Already logged in, redirect to dashboard
                response.sendRedirect(request.getContextPath() + "/admin/brands");
            } else {
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");
        
        // Validate input
        if (email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ email và mật khẩu!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        // Trim input
        email = email.trim();
        password = password.trim();
        
        // Check login
        Employee employee = employeeDAO.login(email, password);
        
        if (employee != null) {
            // Login successful
            HttpSession session = request.getSession(true);
            session.setAttribute("employee", employee);
            session.setAttribute("employeeId", employee.getEmployeeId());
            session.setAttribute("employeeName", employee.getFullName());
            session.setAttribute("employeeRole", employee.getRole().getRoleName());
            
            // Set session timeout (30 minutes)
            session.setMaxInactiveInterval(30 * 60);
            
            // Remember me (optional - using cookie)
            if ("on".equals(remember)) {
                // TODO: Implement remember me with secure cookie
                // For now, just extend session timeout to 7 days
                session.setMaxInactiveInterval(7 * 24 * 60 * 60);
            }
            
            // Redirect to dashboard or requested page
            String redirectUrl = request.getParameter("redirect");
            if (redirectUrl != null && !redirectUrl.isEmpty()) {
                response.sendRedirect(redirectUrl);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/brands");
            }
        } else {
            // Login failed
            request.setAttribute("error", "Email hoặc mật khẩu không đúng!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
    
    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/login?msg=logout_success");
    }
}
