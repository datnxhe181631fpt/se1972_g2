<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Swap Approval</title>

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

            <h2 class="mb-4">Swap Approval (Manager)</h2>

            <div class="card card-custom p-3">

                <table class="table table-hover table-bordered text-center align-middle">

                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Employee</th>
                            <th>Assignment ID</th>
                            <th>Reason</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="s" items="${swapList}">
                            <tr>
                                <td>${s.requestId}</td>
                                <td>${s.employee.fullName}</td>
                                <td>${s.assignmentId}</td>
                                <td>${s.reason}</td>
                                <td>
                                    <span class="badge ${s.status == 'PENDING' ? 'bg-warning' : 'bg-success'}">
                                        ${s.status}
                                    </span>
                                </td>

                                <td>
                                    <c:if test="${s.status == 'PENDING'}">
                                        <a href="swap-approval?action=approve&id=${s.requestId}"
                                           class="btn btn-success btn-sm">Approve</a>

                                        <a href="swap-approval?action=reject&id=${s.requestId}"
                                           class="btn btn-danger btn-sm">Reject</a>
                                    </c:if>
                                </td>

                            </tr>
                        </c:forEach>
                    </tbody>

                </table>

            </div>
        </div>
    </body>
</html>