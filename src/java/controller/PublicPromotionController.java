package controller;

import DAO.CustomerDAO;
import DAO.PromotionDAO;
import entity.Customer;
import entity.Promotion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/customer-promotions")
public class PublicPromotionController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customerInSession = (Customer) session.getAttribute("customer");

        if (customerInSession == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Đảm bảo thông tin khách hàng mới nhất (bao gồm cả TierID)
        CustomerDAO customerDAO = new CustomerDAO();
        Customer latestCustomer = customerDAO.getById(customerInSession.getPhone());
        
        if (latestCustomer == null) {
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        PromotionDAO promotionDAO = new PromotionDAO();
        // Lấy danh sách khuyến mãi áp dụng cho hạng thành viên của khách hàng
        List<Promotion> promotions = promotionDAO.getPromotionsForCustomer(latestCustomer.getTierID());

        request.setAttribute("customer", latestCustomer);
        request.setAttribute("promotions", promotions);
        request.getRequestDispatcher("/AdminLTE-3.2.0/public-promotion-list.jsp").forward(request, response);
    }
}
