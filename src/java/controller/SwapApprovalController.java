/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import DAO.ShiftSwapDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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

        int requestID =
                Integer.parseInt(request.getParameter("requestID"));
        String action = request.getParameter("action");

        ShiftSwapDAO dao = new ShiftSwapDAO();

        if (action.equals("approve")) {
            dao.approveSwap(requestID, 0);

            // send mail
//            String email = dao.getEmailByRequestID(requestID);
//            MailUtil.sendMail(email,
//                    "Swap Approved",
//                    "Your shift swap has been approved.");
        } else {
            dao.rejectSwap(requestID, requestID);
        }

        response.sendRedirect("swap-approval");
    }
}