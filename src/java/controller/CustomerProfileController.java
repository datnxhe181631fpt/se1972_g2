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

@WebServlet("/customer-profile")
public class CustomerProfileController extends HttpServlet {

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
        // Re-fetch from DB to get latest points/tiers etc.
        Customer detail = customerDAO.getById(currentCustomer.getCustomerID());
        
        request.setAttribute("customer", detail);
        request.getRequestDispatcher("/AdminLTE-3.2.0/public-customer-profile.jsp").forward(request, response);
    }
}
