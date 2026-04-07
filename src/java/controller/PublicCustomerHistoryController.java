package controller;

import DAO.CustomerDAO;
import DAO.SalesInvoiceDAO;
import entity.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/customer-history")
public class PublicCustomerHistoryController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String customerId = (String) session.getAttribute("customerId");

        if (customerId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy thông tin khách hàng để hiển thị tên/hạng nếu cần
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.getById((String) session.getAttribute("phone")); // Sử dụng phone làm định danh lấy từ session (kiểm tra LoginController)

        SalesInvoiceDAO invoiceDAO = new SalesInvoiceDAO();
        List<Map<String, Object>> invoices = invoiceDAO.getInvoicesByCustomerId(customerId);

        request.setAttribute("customer", customer);
        request.setAttribute("invoices", invoices);
        request.getRequestDispatcher("/AdminLTE-3.2.0/public-customer-history.jsp").forward(request, response);
    }
}
