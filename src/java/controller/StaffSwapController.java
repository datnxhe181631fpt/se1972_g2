package controller;

import DAO.ShiftSwapDAO;
import entity.ShiftSwapRequest;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/staff/swap")
public class StaffSwapController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/AdminLTE-3.2.0/staff-swap-form.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // ⚠ TẠM hardcode vì chưa login
            int fromEmployeeID = 1;

            int fromAssignmentID =
                    Integer.parseInt(request.getParameter("fromAssignmentID"));

            String reason = request.getParameter("reason");

            ShiftSwapRequest swap = new ShiftSwapRequest();
            swap.setFromEmployeeID(fromEmployeeID);
            swap.setFromAssignmentID(fromAssignmentID);
            swap.setReason(reason);
            swap.setStatus("PENDING");

            ShiftSwapDAO dao = new ShiftSwapDAO();
            dao.insertSwapRequest(swap);

            response.sendRedirect("swap?success=true");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("swap?error=true");
        }
    }
}