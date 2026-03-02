/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.ShiftAssignmentDAO;
import DAO.ShiftSwapDAO;
import entity.EmployeeShiftAssignment;
import entity.ShiftSwapRequest;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;

@WebServlet("/admin/swap-approval")
public class SwapApprovalController extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        ShiftSwapDAO dao = new ShiftSwapDAO();
        request.setAttribute("requests",
                dao.getPendingRequests());

        request.getRequestDispatcher(
                "/AdminLTE-3.2.0/admin-swap-approval.jsp")
                .forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int requestID
                = Integer.parseInt(request.getParameter("requestID"));
        String action = request.getParameter("action");

        ShiftSwapDAO swapDAO = new ShiftSwapDAO();
        ShiftAssignmentDAO assignmentDAO = new ShiftAssignmentDAO();

        if (action.equals("approve")) {

            Connection conn = null;

            try {
                conn = assignmentDAO.getConnection();
                conn.setAutoCommit(false);

                // 1. Lấy request
                ShiftSwapRequest swap
                        = swapDAO.getRequestById(requestID);

                // 2. Lấy assignment của người yêu cầu
                EmployeeShiftAssignment fromAssignment
                        = assignmentDAO.getById(swap.getFromAssignmentID());

                // 3. Tìm assignment khác để đổi
                EmployeeShiftAssignment targetAssignment
                        = assignmentDAO.findAssignmentToSwap(
                                swap.getFromAssignmentID());

                if (targetAssignment != null) {

                    // 4. Hoán đổi shift
                    int tempShift = fromAssignment.getShiftID();

                    assignmentDAO.updateShift(
                            fromAssignment.getAssignmentID(),
                            targetAssignment.getShiftID(),
                            conn);

                    assignmentDAO.updateShift(
                            targetAssignment.getAssignmentID(),
                            tempShift,
                            conn);

                    // 5. Update trạng thái request
                    swapDAO.approveSwap(requestID, 0);

                    conn.commit();
                }

            } catch (Exception e) {
                try {
                    conn.rollback();
                } catch (Exception ex) {
                }
                e.printStackTrace();
            }

        } else {
            swapDAO.rejectSwap(requestID, 0);
        }

        response.sendRedirect("swap-approval");
    }
}
