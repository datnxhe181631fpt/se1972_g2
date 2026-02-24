<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Shift History</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            .card-custom {
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }
        </style>
    </head>

    <body class="bg-light">
        <div class="container mt-4">

            <h2 class="mb-4">Employee Shift History</h2>

            <div class="card card-custom p-3">
                <table class="table table-bordered table-hover text-center align-middle">

                    <thead class="table-dark">
                        <tr>
                            <th>Date</th>
                            <th>Shift</th>
                            <th>Time</th>
                            <th>Status</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="h" items="${history}">
                            <tr>
                                <td>${h.workDate}</td>
                                <td>${h.shift.shiftName}</td>
                                <td>${h.shift.startTime} - ${h.shift.endTime}</td>
                                <td>
                                    <span class="badge ${h.status == 'APPROVED' ? 'bg-success' : 'bg-warning'}">
                                        ${h.status}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>

                </table>
            </div>

        </div>
    </body>
</html>