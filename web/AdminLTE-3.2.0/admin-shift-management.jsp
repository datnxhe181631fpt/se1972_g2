<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Shift Management</title>

        <!-- Google Font -->
        <link rel="stylesheet"
              href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">

        <!-- FontAwesome -->
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/AdminLTE-3.2.0/plugins/fontawesome-free/css/all.min.css">

        <!-- AdminLTE -->
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/AdminLTE-3.2.0/dist/css/adminlte.min.css">
    </head>

    <body class="hold-transition sidebar-mini">
        <div class="wrapper">

            <!-- HEADER -->
            <jsp:include page="include/admin-header.jsp"/>

            <!-- SIDEBAR -->
            <jsp:include page="include/admin-sidebar.jsp"/>

            <!-- Content Wrapper -->
            <div class="content-wrapper">

                <!-- Content Header -->
                <section class="content-header">
                    <div class="container-fluid">
                        <h1><i class="fas fa-calendar-alt"></i> Shift Management</h1>
                    </div>
                </section>

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">

                        <!-- Assign Card -->
                        <div class="card card-primary">
                            <div class="card-header">
                                <h3 class="card-title">Assign Employee To Shift</h3>
                            </div>

                            <form method="post" action="shift-management">
                                <div class="card-body row">

                                    <div class="form-group col-md-3">
                                        <label>Date</label>
                                        <input type="date" name="workDate"
                                               class="form-control" required>
                                    </div>

                                    <div class="form-group col-md-3">
                                        <label>Shift</label>
                                        <select name="shiftID" class="form-control">
                                            <c:forEach var="s" items="${shifts}">
                                                <option value="${s.shiftID}">
                                                    ${s.shiftName}
                                                    (${s.startTime} - ${s.endTime})
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="form-group col-md-4">
                                        <label>Employee</label>
                                        <select name="employeeID" class="form-control">
                                            <c:forEach var="e" items="${employees}">
                                                <option value="${e.employeeId}">
                                                    ${e.fullName}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="form-group col-md-2 align-self-end">
                                        <button class="btn btn-primary btn-block">
                                            Assign
                                        </button>
                                    </div>

                                </div>
                            </form>
                        </div>

                        <!-- DAILY SHIFT OVERVIEW -->
                        <div class="card card-info">

                            <!-- HEADER + DATE FILTER -->
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h3 class="card-title">
                                    Daily Shift Overview
                                </h3>

                                <form method="get" action="shift-management" class="form-inline">
                                    <input type="date" name="viewDate"
                                           value="${viewDate}"
                                           class="form-control mr-2"/>

                                    <button class="btn btn-sm btn-primary">
                                        View
                                    </button>
                                </form>
                            </div>

                            <div class="card-body">
                                <div class="row">

                                    <c:forEach var="shift" items="${shifts}">
                                        <div class="col-md-4 mb-4">
                                            <div class="card shadow-sm h-100">

                                                <!-- SHIFT HEADER -->
                                                <div class="card-header bg-primary text-white">
                                                    <b>${shift.shiftName}</b>
                                                    <span class="float-right">
                                                        ${shift.startTime} - ${shift.endTime}
                                                    </span>
                                                </div>

                                                <div class="card-body">

                                                    <c:set var="hasEmployee" value="false"/>

                                                    <!-- LOOP EMPLOYEE IN THIS SHIFT -->
                                                    <c:forEach var="a" items="${assignments}">
                                                        <c:if test="${a.shiftID == shift.shiftID}">
                                                            <c:set var="hasEmployee" value="true"/>

                                                            <div class="border rounded p-3 mb-3 bg-light">

                                                                <div class="d-flex justify-content-between">
                                                                    <div>
                                                                        <strong>${a.fullName}</strong>
                                                                        <div class="text-muted small">
                                                                            ${a.role}
                                                                        </div>
                                                                    </div>

                                                                    <div>
                                                                        <c:choose>
                                                                            <c:when test="${a.status == 'SWAP'}">
                                                                                <span class="badge badge-warning">
                                                                                    Swap
                                                                                </span>
                                                                            </c:when>
                                                                            <c:when test="${a.status == 'LEAVE'}">
                                                                                <span class="badge badge-danger">
                                                                                    Leave
                                                                                </span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="badge badge-success">
                                                                                    Assigned
                                                                                </span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </div>
                                                                </div>

                                                                <hr class="my-2">

                                                                <div class="small text-muted">
                                                                    Date: ${a.workDate}
                                                                </div>

                                                            </div>

                                                        </c:if>
                                                    </c:forEach>

                                                    <!-- IF NO EMPLOYEE -->
                                                    <c:if test="${!hasEmployee}">
                                                        <div class="text-center text-muted pt-4">
                                                            <i class="fas fa-user-slash fa-2x mb-2"></i>
                                                            <div>No Employee Assigned</div>
                                                        </div>
                                                    </c:if>

                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>

                                </div>
                            </div>
                        </div>

                        <!-- Employee List -->
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Employee List</h3>
                            </div>

                            <div class="card-body table-responsive p-0">
                                <table class="table table-hover text-nowrap">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Status</th>
                                            <th>History</th>
                                            <th>Swap</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <c:forEach var="e" items="${employees}">
                                            <tr>
                                                <td>${e.employeeId}</td>
                                                <td>${e.fullName}</td>
                                                <td>${e.email}</td>
                                                <td>
                                                    <span class="badge ${e.status == 'ACTIVE' ? 'badge-success' : 'badge-danger'}">
                                                        ${e.status}
                                                    </span>
                                                </td>
                                                <td>
                                                    <a href="shift-history?employeeID=${e.employeeId}"
                                                       class="btn btn-info btn-sm">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                </td>
                                                <td>
                                                    <a href="swap-approval?employeeID=${e.employeeId}"
                                                       class="btn btn-warning btn-sm">
                                                        <i class="fas fa-exchange-alt"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <div class="card-footer clearfix">
                                <ul class="pagination pagination-sm m-0 float-right">
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link"
                                               href="shift-management?page=${i}&search=${param.search}&status=${param.status}">
                                                ${i}
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>

                        </div>

                    </div>
                </section>
            </div>

            <!-- FOOTER -->
            <jsp:include page="include/admin-footer.jsp"/>

        </div>

        <!-- Scripts -->
        <script src="${pageContext.request.contextPath}/AdminLTE-3.2.0/plugins/jquery/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/AdminLTE-3.2.0/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/AdminLTE-3.2.0/dist/js/adminlte.min.js"></script>

    </body>
</html>