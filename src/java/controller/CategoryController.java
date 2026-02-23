/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */




package controller;

import DAO.CategoryDAO;
import entity.Category;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CategoryController", urlPatterns = {"/admin/categories"})
public class CategoryController extends HttpServlet {
    
    private CategoryDAO categoryDAO;
    
    @Override
    public void init() {
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                listCategories(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteCategory(request, response);
                break;
            case "toggle":
                toggleCategoryStatus(request, response);
                break;
            default:
                listCategories(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addCategory(request, response);
        } else if ("edit".equals(action)) {
            updateCategory(request, response);
        }
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get parameters
        String search = request.getParameter("search");
        String statusParam = request.getParameter("status");
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        String pageParam = request.getParameter("page");
        String pageSizeParam = request.getParameter("pageSize");
        
        // Default values
        int page = 1;
        int pageSize = 10;
        Boolean isActive = null;
        
        // Parse parameters
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
            try {
                pageSize = Integer.parseInt(pageSizeParam);
            } catch (NumberFormatException e) {
                pageSize = 10;
            }
        }
        
        if ("active".equals(statusParam)) {
            isActive = true;
        } else if ("inactive".equals(statusParam)) {
            isActive = false;
        }
        
        // Get data
        List<Category> categories = categoryDAO.getCategories(search, isActive, sortBy, sortOrder, page, pageSize);
        int totalRecords = categoryDAO.getTotalCategories(search, isActive);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
        
        // Set attributes
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalRecords", totalRecords);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search);
        request.setAttribute("status", statusParam);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);
        
        // Forward to JSP
        request.getRequestDispatcher("/AdminLTE-3.2.0/admin-category-list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/AdminLTE-3.2.0/admin-category-detail.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Category category = categoryDAO.getCategoryByID(id);
        request.setAttribute("category", category);
        request.getRequestDispatcher("/AdminLTE-3.2.0/admin-category-detail.jsp").forward(request, response);
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoryName = request.getParameter("categoryName");
        String description = request.getParameter("description");
        String icon = request.getParameter("icon");
        String displayOrderParam = request.getParameter("displayOrder");
        boolean isActive = "on".equals(request.getParameter("isActive"));
        
        int displayOrder = 0;
        if (displayOrderParam != null && !displayOrderParam.isEmpty()) {
            try {
                displayOrder = Integer.parseInt(displayOrderParam);
            } catch (NumberFormatException e) {
                displayOrder = 0;
            }
        }
        
        // Check if category name already exists
        if (categoryDAO.isCategoryNameExists(categoryName, null)) {
            Category category = new Category();
            category.setCategoryName(categoryName);
            category.setDescription(description);
            category.setIcon(icon);
            category.setDisplayOrder(displayOrder);
            category.setIsActive(isActive);
            
            request.setAttribute("error", "Tên danh mục đã tồn tại! Vui lòng chọn tên khác.");
            request.setAttribute("category", category);
            request.getRequestDispatcher("/AdminLTE-3.2.0/admin-category-detail.jsp").forward(request, response);
            return;
        }
        
        Category category = new Category();
        category.setCategoryName(categoryName);
        category.setDescription(description);
        category.setIcon(icon);
        category.setDisplayOrder(displayOrder);
        category.setIsActive(isActive);
        
        boolean success = categoryDAO.insertCategory(category);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/categories?msg=add_success");
        } else {
            request.setAttribute("error", "Thêm danh mục thất bại!");
            request.setAttribute("category", category);
            request.getRequestDispatcher("/AdminLTE-3.2.0/admin-category-detail.jsp").forward(request, response);
        }
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int categoryID = Integer.parseInt(request.getParameter("categoryID"));
        String categoryName = request.getParameter("categoryName");
        String description = request.getParameter("description");
        String icon = request.getParameter("icon");
        String displayOrderParam = request.getParameter("displayOrder");
        boolean isActive = "on".equals(request.getParameter("isActive"));
        
        int displayOrder = 0;
        if (displayOrderParam != null && !displayOrderParam.isEmpty()) {
            try {
                displayOrder = Integer.parseInt(displayOrderParam);
            } catch (NumberFormatException e) {
                displayOrder = 0;
            }
        }
        
        // Check if category name already exists (excluding current category)
        if (categoryDAO.isCategoryNameExists(categoryName, categoryID)) {
            Category category = new Category();
            category.setCategoryID(categoryID);
            category.setCategoryName(categoryName);
            category.setDescription(description);
            category.setIcon(icon);
            category.setDisplayOrder(displayOrder);
            category.setIsActive(isActive);
            
            request.setAttribute("error", "Tên danh mục đã tồn tại! Vui lòng chọn tên khác.");
            request.setAttribute("category", category);
            request.getRequestDispatcher("/AdminLTE-3.2.0/admin-category-detail.jsp").forward(request, response);
            return;
        }
        
        Category category = new Category();
        category.setCategoryID(categoryID);
        category.setCategoryName(categoryName);
        category.setDescription(description);
        category.setIcon(icon);
        category.setDisplayOrder(displayOrder);
        category.setIsActive(isActive);
        
        boolean success = categoryDAO.updateCategory(category);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/categories?msg=update_success");
        } else {
            request.setAttribute("error", "Cập nhật danh mục thất bại!");
            request.setAttribute("category", category);
            request.getRequestDispatcher("/AdminLTE-3.2.0/admin-category-detail.jsp").forward(request, response);
        }
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        // Soft delete: Set IsActive = false instead of deleting
        Category category = categoryDAO.getCategoryByID(id);
        if (category != null) {
            category.setIsActive(false);
            boolean success = categoryDAO.updateCategory(category);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?msg=delete_success");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/categories?msg=delete_error");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/categories?msg=delete_error");
        }
    }
    
    private void toggleCategoryStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        Category category = categoryDAO.getCategoryByID(id);
        if (category != null) {
            // Toggle status
            category.setIsActive(!category.isIsActive());
            boolean success = categoryDAO.updateCategory(category);
            
            if (success) {
                String msg = category.isIsActive() ? "activate_success" : "deactivate_success";
                response.sendRedirect(request.getContextPath() + "/admin/categories?msg=" + msg);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/categories?msg=toggle_error");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/categories?msg=toggle_error");
        }
    }
}
