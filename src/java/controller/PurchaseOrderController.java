/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.PurchaseOrderDAO;
import entity.PurchaseOrder;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.List;

/**
 *
 * @author qp
 */
@WebServlet(name = "PurchaseOrderController", urlPatterns = {"/purchaseorder"})
public class PurchaseOrderController extends HttpServlet {
    
    private PurchaseOrderDAO poDAO = new PurchaseOrderDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "list";
        }
        
        switch (action) {
            case "list":
            case "search":
                showList(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "detail":
                showDetail(request, response);
                break;
            default:
                showList(request, response);
        }
    }
    
    private void showList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("key");
        String status = request.getParameter("status");
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        
        LocalDate fromDate = null;
        LocalDate toDate = null;
        if (from != null && !from.trim().isEmpty()) {
            fromDate = LocalDate.parse(from);
        }
        if (to != null && !to.trim().isEmpty()) {
            toDate = LocalDate.parse(to);
        }
        
        int page = 1;
        int pageSize = 5;
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }
        
        int totalRecords = poDAO.countPOs(keyword, status, fromDate, toDate);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
        
        List<PurchaseOrder> lists = poDAO.searchPOWithPaginated(keyword, status, fromDate, toDate, page, pageSize);
        request.setAttribute("lists", lists);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        
        String msg = (String) request.getSession().getAttribute("msg");
        if (msg != null) {
            request.setAttribute("msg", msg);
            request.getSession().removeAttribute("msg");
        }
        request.getRequestDispatcher("/AdminLTE-3.2.0/po-list.jsp").forward(request, response);
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String poNumber = poDAO.generateNextPONumber();
        
        String err = (String) request.getSession().getAttribute("error");
        
        PurchaseOrder po = new PurchaseOrder();
        po.setPoNumber(poNumber);
        po.setOrderDate(java.time.LocalDate.now());
        
        if (err != null) {
            request.setAttribute("error", err);
            request.getSession().removeAttribute("error");
        }
        
        request.setAttribute("po", po);
        request.setAttribute("code", poNumber);
        request.setAttribute("mode", "add");
        request.getRequestDispatcher("/AdminLTE-3.2.0/po-form.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
    
}
