package controller;

import DAO.BrandDAO;
import entity.Brand;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "BrandController", urlPatterns = {"/admin/brands"})
public class BrandController extends HttpServlet {
    
    private BrandDAO brandDAO;
    
    @Override
    public void init() {
        brandDAO = new BrandDAO();
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
                listBrands(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteBrand(request, response);
                break;
            case "toggle":
                toggleBrandStatus(request, response);
                break;
            default:
                listBrands(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addBrand(request, response);
        } else if ("edit".equals(action)) {
            updateBrand(request, response);
        }
    }

    private void listBrands(HttpServletRequest request, HttpServletResponse response)
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
        List<Brand> brands = brandDAO.getBrands(search, isActive, sortBy, sortOrder, page, pageSize);
        int totalRecords = brandDAO.getTotalBrands(search, isActive);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
        
        // Set attributes
        request.setAttribute("brands", brands);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalRecords", totalRecords);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search);
        request.setAttribute("status", statusParam);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);
        
        // Forward to JSP
        request.getRequestDispatcher("/AdminLTE-3.2.0/admin-brand-list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/AdminLTE-3.2.0/admin-brand-detail.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Brand brand = brandDAO.getBrandByID(id);
        request.setAttribute("brand", brand);
        request.getRequestDispatcher("/AdminLTE-3.2.0/admin-brand-detail.jsp").forward(request, response);
    }

    private void addBrand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String brandName = request.getParameter("brandName");
        String logo = request.getParameter("logo");
        String description = request.getParameter("description");
        boolean isActive = "on".equals(request.getParameter("isActive"));
        
        // Check if brand name already exists
        if (brandDAO.isBrandNameExists(brandName, null)) {
            Brand brand = new Brand();
            brand.setBrandName(brandName);
            brand.setLogo(logo);
            brand.setDescription(description);
            brand.setIsActive(isActive);
            
            request.setAttribute("error", "Tên thương hiệu đã tồn tại! Vui lòng chọn tên khác.");
            request.setAttribute("brand", brand);
            request.getRequestDispatcher("/AdminLTE-3.2.0/admin-brand-detail.jsp").forward(request, response);
            return;
        }
        
        Brand brand = new Brand();
        brand.setBrandName(brandName);
        brand.setLogo(logo);
        brand.setDescription(description);
        brand.setIsActive(isActive);
        
        boolean success = brandDAO.insertBrand(brand);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/brands?msg=add_success");
        } else {
            request.setAttribute("error", "Thêm thương hiệu thất bại!");
            request.setAttribute("brand", brand);
            request.getRequestDispatcher("/AdminLTE-3.2.0/admin-brand-detail.jsp").forward(request, response);
        }
    }

    private void updateBrand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int brandID = Integer.parseInt(request.getParameter("brandID"));
        String brandName = request.getParameter("brandName");
        String logo = request.getParameter("logo");
        String description = request.getParameter("description");
        boolean isActive = "on".equals(request.getParameter("isActive"));
        
        // Check if brand name already exists (excluding current brand)
        if (brandDAO.isBrandNameExists(brandName, brandID)) {
            Brand brand = new Brand();
            brand.setBrandID(brandID);
            brand.setBrandName(brandName);
            brand.setLogo(logo);
            brand.setDescription(description);
            brand.setIsActive(isActive);
            
            request.setAttribute("error", "Tên thương hiệu đã tồn tại! Vui lòng chọn tên khác.");
            request.setAttribute("brand", brand);
            request.getRequestDispatcher("/AdminLTE-3.2.0/admin-brand-detail.jsp").forward(request, response);
            return;
        }
        
        Brand brand = new Brand();
        brand.setBrandID(brandID);
        brand.setBrandName(brandName);
        brand.setLogo(logo);
        brand.setDescription(description);
        brand.setIsActive(isActive);
        
        boolean success = brandDAO.updateBrand(brand);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/brands?msg=update_success");
        } else {
            request.setAttribute("error", "Cập nhật thương hiệu thất bại!");
            request.setAttribute("brand", brand);
            request.getRequestDispatcher("/AdminLTE-3.2.0/admin-brand-detail.jsp").forward(request, response);
        }
    }

    private void deleteBrand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        // Soft delete: Set IsActive = false instead of deleting
        Brand brand = brandDAO.getBrandByID(id);
        if (brand != null) {
            brand.setIsActive(false);
            boolean success = brandDAO.updateBrand(brand);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/brands?msg=delete_success");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/brands?msg=delete_error");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/brands?msg=delete_error");
        }
    }
    
    private void toggleBrandStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        Brand brand = brandDAO.getBrandByID(id);
        if (brand != null) {
            // Toggle status
            brand.setIsActive(!brand.isIsActive());
            boolean success = brandDAO.updateBrand(brand);
            
            if (success) {
                String msg = brand.isIsActive() ? "activate_success" : "deactivate_success";
                response.sendRedirect(request.getContextPath() + "/admin/brands?msg=" + msg);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/brands?msg=toggle_error");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/brands?msg=toggle_error");
        }
    }
}
