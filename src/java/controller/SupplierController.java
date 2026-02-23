/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.SupplierDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import entity.Supplier;
import util.Validation;

/**
 *
 * @author qp
 */
@WebServlet(name = "SupplierController", urlPatterns = {"/supplier"})
public class SupplierController extends HttpServlet {

    private SupplierDAO supDAO = new SupplierDAO();

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
            default:
                showList(request, response);
        }
    }

    private void showList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("key");
        String statusParam = request.getParameter("status");
        Boolean isActive = null;

        if (statusParam != null && !statusParam.trim().isEmpty()) {
            isActive = Boolean.valueOf(statusParam);
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

        int totalRecords = supDAO.countSuppliers(keyword, isActive);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        List<Supplier> lists = supDAO.searchSuppliersWithPaginated(keyword, isActive, page, pageSize);
        request.setAttribute("lists", lists);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);

        String msg = (String) request.getSession().getAttribute("msg");

        if (msg != null) {
            request.setAttribute("msg", msg);
            request.getSession().removeAttribute("msg");
        }
        request.getRequestDispatcher("/AdminLTE-3.2.0/supplier-list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = supDAO.generateNextSupplierCode();

        String err = (String) request.getSession().getAttribute("error");
 
        Supplier supplier = new Supplier();
        supplier.setSupplierCode(code); 

        if (err != null) {
            request.setAttribute("error", err);
            request.getSession().removeAttribute("error");
       
        }

        request.setAttribute("supplier", supplier);
        request.setAttribute("code", code);
        request.setAttribute("mode", "add");

        request.getRequestDispatcher("/AdminLTE-3.2.0/supplier-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        Supplier supplier = supDAO.getSupplierByCode(code);
        request.setAttribute("supplier", supplier);
        request.setAttribute("code", code);
        request.setAttribute("mode", "edit");
        request.getRequestDispatcher("/AdminLTE-3.2.0/supplier-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        //validate 
        //...
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        String code = request.getParameter("code");

        String msg = "";
        boolean success;
        switch (action) {
            case "delete":
                success = supDAO.deleteSupplier(code);
                msg = success ? "success_delete" : "fail";
                break;
            case "active":
                success = supDAO.activeSupplier(code);
                msg = success ? "sucess_active" : "fail";
                break;
            case "deactive":
                success = supDAO.deactiveSupplier(code);
                msg = success ? "sucess_deactive" : "fail";
                break;
            case "save":
                String name = request.getParameter("name");
                String contactPerson = request.getParameter("contactPerson");
                String phone = request.getParameter("phone");
                String email = request.getParameter("email");
                String address = request.getParameter("address");
                Supplier sup = new Supplier(code, name, contactPerson, phone, email, address);

                //validate
                Validation valid = new Validation();
                valid.required("Mã nhà cung cấp", name)
                        .required("Tên NCC", name).minLength("Tên nhà cung cấp", name, 3)
                        .required("Người liên hệ", contactPerson)
                        .required("Số điện thoại", name).phone("Số điện thoại", phone)
                        .email("Email", email);

                if (!valid.isValid()) {
                    request.setAttribute("supplier", sup);

                    request.setAttribute("code", code);

                    request.setAttribute("error", valid.getFirstError());

                    String mode = supDAO.isCodeExist(code) ? "edit" : "add";
                    request.setAttribute("mode", mode);

                    request.getRequestDispatcher("/AdminLTE-3.2.0/supplier-form.jsp").forward(request, response);
                    return;
                }

                if (supDAO.isCodeExist(code)) {
                    success = supDAO.updateSupplier(sup);
                    msg = success ? "success_edit" : "fail";
                } else {
                    success = supDAO.addSupplier(sup);
                    msg = success ? "success_add" : "fail";
                }
                break;
        }

        request.getSession().setAttribute("msg", msg);
        response.sendRedirect("supplier?action=list");
    }
}
