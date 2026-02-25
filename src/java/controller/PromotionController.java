package controller;

import DAO.PromotionDAO;
import entity.Promotion;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet(name = "PromotionController", urlPatterns = { "/admin/promotions" })
public class PromotionController extends HttpServlet {

    private final PromotionDAO promotionDAO = new PromotionDAO();

    /** Định dạng ngày nhận từ form date-picker (MM/dd/yyyy). */
    private static final DateTimeFormatter FORM_DATE_FMT = DateTimeFormatter.ofPattern("MM/dd/yyyy");

    // =========================================================================
    // GET
    // =========================================================================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null)
            action = "";

        switch (action) {

            // ── Hiển thị form tạo mới ──────────────────────────────────────
            case "create":
                request.getRequestDispatcher(
                        "/AdminLTE-3.2.0/promotion-form.jsp").forward(request, response);
                break;

            // ── Hiển thị form chỉnh sửa ────────────────────────────────────
            case "edit":
                handleEditForm(request, response);
                break;

            // ── Toggle trạng thái ACTIVE ↔ INACTIVE ───────────────────────
            case "toggle":
                handleToggle(request, response);
                break;

            // ── Mặc định: danh sách với filter ────────────────────────────
            default:
                handleList(request, response);
                break;
        }
    }

    // =========================================================================
    // POST
    // =========================================================================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null)
            action = "";

        switch (action) {
            case "create":
                handleCreate(request, response);
                break;
            case "update":
                handleUpdate(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/promotions");
        }
    }

    // =========================================================================
    // Handlers
    // =========================================================================

    /** Hiển thị danh sách, lọc theo status và/hoặc type. */
    private void handleList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String status = request.getParameter("status"); // có thể null hoặc ""
        String type = request.getParameter("type");

        List<Promotion> promotions = promotionDAO.getByFilter(status, type);
        request.setAttribute("promotions", promotions);

        request.getRequestDispatcher(
                "/AdminLTE-3.2.0/promotion-list.jsp").forward(request, response);
    }

    /** Load promotion theo id rồi chuyển đến form chỉnh sửa. */
    private void handleEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/admin/promotions");
            return;
        }

        try {
            int id = Integer.parseInt(idStr.trim());
            Promotion promotion = promotionDAO.getById(id);
            if (promotion == null) {
                request.setAttribute("errorMessage", "Không tìm thấy chương trình khuyến mãi có ID = " + id);
                handleList(request, response);
                return;
            }
            request.setAttribute("promotion", promotion);
            request.getRequestDispatcher(
                    "/AdminLTE-3.2.0/promotion-form.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/promotions");
        }
    }

    /** Đổi trạng thái ACTIVE ↔ INACTIVE rồi redirect về danh sách. */
    private void handleToggle(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String idStr = request.getParameter("id");
        String currentStatus = request.getParameter("currentStatus");

        if (idStr == null || currentStatus == null) {
            response.sendRedirect(request.getContextPath() + "/admin/promotions");
            return;
        }

        try {
            int id = Integer.parseInt(idStr.trim());
            String newStatus = "ACTIVE".equalsIgnoreCase(currentStatus) ? "INACTIVE" : "ACTIVE";
            promotionDAO.updateStatus(id, newStatus);
        } catch (NumberFormatException e) {
            // bỏ qua, redirect về list
        }

        // Giữ nguyên filter params khi redirect
        String status = request.getParameter("status");
        String type = request.getParameter("type");
        StringBuilder redirect = new StringBuilder(
                request.getContextPath() + "/admin/promotions?");
        if (status != null && !status.isEmpty())
            redirect.append("status=").append(status).append("&");
        if (type != null && !type.isEmpty())
            redirect.append("type=").append(type);

        response.sendRedirect(redirect.toString());
    }

    /** Tạo mới promotion, redirect về danh sách khi thành công. */
    private void handleCreate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Promotion p = buildPromotionFromForm(request);

        if (p == null) {
            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.");
            request.getRequestDispatcher(
                    "/AdminLTE-3.2.0/promotion-form.jsp").forward(request, response);
            return;
        }

        // Tự tạo PromotionCode nếu chưa có
        if (p.getPromotionCode() == null || p.getPromotionCode().isBlank()) {
            p.setPromotionCode("PROMO-" + System.currentTimeMillis());
        }
        p.setStatus("ACTIVE");
        p.setIsStackable(false);
        p.setPriority(0);

        promotionDAO.insert(p);
        response.sendRedirect(request.getContextPath() + "/admin/promotions");
    }

    /** Cập nhật promotion hiện có, redirect về danh sách khi thành công. */
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("promotionID");
        if (idStr == null || idStr.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/admin/promotions");
            return;
        }

        Promotion p = buildPromotionFromForm(request);
        if (p == null) {
            // Load lại promotion gốc để hiển thị form với lỗi
            try {
                int id = Integer.parseInt(idStr.trim());
                Promotion original = promotionDAO.getById(id);
                request.setAttribute("promotion", original);
            } catch (NumberFormatException ignored) {
            }

            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.");
            request.getRequestDispatcher(
                    "/AdminLTE-3.2.0/promotion-form.jsp").forward(request, response);
            return;
        }

        try {
            int id = Integer.parseInt(idStr.trim());
            p.setPromotionID(id);

            // Giữ nguyên status, isStackable, priority, promotionCode từ bản gốc
            Promotion original = promotionDAO.getById(id);
            if (original != null) {
                p.setStatus(original.getStatus());
                p.setIsStackable(original.getIsStackable());
                p.setPriority(original.getPriority());
                p.setPromotionCode(original.getPromotionCode());
            }

            promotionDAO.update(p);
            response.sendRedirect(request.getContextPath() + "/admin/promotions");

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/promotions");
        }
    }

    // =========================================================================
    // Utility
    // =========================================================================

    /**
     * Đọc các trường từ form và tạo đối tượng Promotion.
     * Trả về null nếu dữ liệu bắt buộc (tên, ngày) không hợp lệ.
     */
    private Promotion buildPromotionFromForm(HttpServletRequest request) {
        String name = request.getParameter("promotionName");
        String type = request.getParameter("promotionType");
        String startStr = request.getParameter("startDate");
        String endStr = request.getParameter("endDate");

        if (name == null || name.isBlank())
            return null;
        if (startStr == null || startStr.isBlank())
            return null;
        if (endStr == null || endStr.isBlank())
            return null;

        LocalDate startDate, endDate;
        try {
            startDate = LocalDate.parse(startStr.trim(), FORM_DATE_FMT);
            endDate = LocalDate.parse(endStr.trim(), FORM_DATE_FMT);
        } catch (DateTimeParseException e) {
            return null;
        }

        Promotion p = new Promotion();
        p.setPromotionName(name.trim());
        p.setPromotionType(type != null ? type.trim() : "PERCENT");
        p.setStartDate(startDate);
        p.setEndDate(endDate);
        return p;
    }
}
