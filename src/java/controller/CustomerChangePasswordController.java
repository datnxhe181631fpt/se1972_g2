package controller;

import DAO.CustomerAccountDAO;
import entity.CustomerAccount;
import entity.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/customer-change-password")
public class CustomerChangePasswordController extends HttpServlet {

    private CustomerAccountDAO customerAccountDAO;

    @Override
    public void init() {
        customerAccountDAO = new CustomerAccountDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Customer customer = (Customer) session.getAttribute("customer");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Basic validation
        if (newPassword == null || !newPassword.equals(confirmPassword)) {
            session.setAttribute("passwordError", "Mật khẩu mới và xác nhận mật khẩu không khớp.");
            response.sendRedirect(request.getContextPath() + "/customer-profile");
            return;
        }

        // Verify old password
        CustomerAccount account = customerAccountDAO.getAccountById(customer.getCustomerID());
        if (account == null || !account.getPassword().equals(oldPassword)) {
            session.setAttribute("passwordError", "Mật khẩu hiện tại không chính xác.");
            response.sendRedirect(request.getContextPath() + "/customer-profile");
            return;
        }

        // Update password
        try {
            customerAccountDAO.updatePassword(customer.getCustomerID(), newPassword);
            session.setAttribute("passwordSuccess", "Đổi mật khẩu thành công!");
        } catch (Exception e) {
            session.setAttribute("passwordError", "Có lỗi xảy ra khi đổi mật khẩu: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/customer-profile");
    }
}
