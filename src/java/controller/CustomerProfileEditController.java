package controller;

import DAO.CustomerDAO;
import entity.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

@WebServlet("/customer-profile-edit")
public class CustomerProfileEditController extends HttpServlet {

    private CustomerDAO customerDAO;

    @Override
    public void init() {
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Customer currentCustomer = (Customer) session.getAttribute("customer");
        Customer detail = customerDAO.getById(currentCustomer.getCustomerID());
        
        request.setAttribute("customer", detail);
        request.getRequestDispatcher("/AdminLTE-3.2.0/public-customer-profile-edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Customer current = (Customer) session.getAttribute("customer");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String birthdayStr = request.getParameter("birthday");

        // Basic validation
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Họ tên không được để trống");
            request.setAttribute("customer", current);
            request.getRequestDispatcher("/AdminLTE-3.2.0/public-customer-profile-edit.jsp").forward(request, response);
            return;
        }

        try {
            Customer updated = customerDAO.getById(current.getCustomerID());
            updated.setCustomerName(fullName);
            updated.setEmail(email);
            if (birthdayStr != null && !birthdayStr.isEmpty()) {
                updated.setBirthday(LocalDate.parse(birthdayStr));
            }
            
            customerDAO.update(updated);
            
            // Update session
            session.setAttribute("customer", updated);
            session.setAttribute("fullName", updated.getCustomerName());
            
            response.sendRedirect(request.getContextPath() + "/customer-profile?success=1");
        } catch (DateTimeParseException e) {
            request.setAttribute("error", "Ngày sinh không đúng định dạng (yyyy-mm-dd)");
            request.setAttribute("customer", current);
            request.getRequestDispatcher("/AdminLTE-3.2.0/public-customer-profile-edit.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.setAttribute("customer", current);
            request.getRequestDispatcher("/AdminLTE-3.2.0/public-customer-profile-edit.jsp").forward(request, response);
        }
    }
}
