<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý nhân viên</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Google Font -->
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- AdminLTE -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/AdminLTE-3.2.0/dist/css/adminlte.min.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <!-- Sidebar -->
    <jsp:include page="include/admin-sidebar.jsp"/>

    <!-- Content Wrapper -->
    <div class="content-wrapper">

        <!-- Content Header -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Quản lý nhân viên</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/dashboard">Home</a>
                            </li>
                            <li class="breadcrumb-item active">Nhân viên</li>
                        </ol>
                    </div>
                </div>
            </div>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">

                <!-- Search & Filter -->
                <div class="card card-primary card-outline">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-search"></i> Tìm kiếm & Lọc
                        </h3>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/employees"
                              method="get"
                              class="form-inline">

                            <input type="hidden" name="action" value="list">

                            <div class="form-group mr-3 mb-2">
                                <label class="mr-2">Từ khóa:</label>
                                <input type="text"
                                       name="key"
                                       value="${param.key}"
                                       class="form-control"
                                       placeholder="Tên hoặc Email">
                            </div>

                            <div class="form-group mr-3 mb-2">
                                <label class="mr-2">Trạng thái:</label>
                                <select name="status" class="form-control">
                                    <option value="">Tất cả</option>
                                    <option value="true" ${param.status == 'true' ? 'selected' : ''}>
                                        Active
                                    </option>
                                    <option value="false" ${param.status == 'false' ? 'selected' : ''}>
                                        Inactive
                                    </option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary mb-2 mr-2">
                                <i class="fas fa-search"></i> Tìm
                            </button>

                            <a href="${pageContext.request.contextPath}/admin/employees"
                               class="btn btn-default mb-2 mr-2">
                                <i class="fas fa-redo"></i> Reset
                            </a>

                            <a href="${pageContext.request.contextPath}/admin/employees?action=add"
                               class="btn btn-success mb-2">
                                <i class="fas fa-plus"></i> Thêm nhân viên
                            </a>
                        </form>
                    </div>
                </div>

                <!-- Employee List -->
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-users"></i> Danh sách nhân viên
                        </h3>
                    </div>

                    <div class="card-body">
                        <c:if test="${not empty lists}">
                            <table class="table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th style="width: 8%">ID</th>
                                    <th style="width: 22%">Họ tên</th>
                                    <th style="width: 22%">Email</th>
                                    <th style="width: 18%">Vai trò</th>
                                    <th style="width: 15%">Trạng thái</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="e" items="${lists}">
                                    <!-- Main row -->
                                    <tr onclick="toggleDetail('${e.employeeID}')" style="cursor:pointer">
                                        <td>#${e.employeeID}</td>
                                        <td>${e.fullName}</td>
                                        <td>${e.email}</td>
                                        <td>${e.roleName}</td>
                                        <td>
                                            <span class="badge ${e.status ? 'badge-success' : 'badge-danger'}">
                                                ${e.status ? 'Active' : 'Inactive'}
                                            </span>
                                        </td>
                                    </tr>

                                    <!-- Detail row -->
                                    <tr id="detail-${e.employeeID}" style="display:none">
                                        <td colspan="5">
                                            <div class="p-3 bg-light">

                                                <!-- Info -->
                                                <div class="card mb-3">
                                                    <div class="card-header bg-info">
                                                        <h5 class="card-title mb-0">
                                                            <i class="fas fa-info-circle"></i> Thông tin chi tiết
                                                        </h5>
                                                    </div>
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <p><strong>Họ tên:</strong> ${e.fullName}</p>
                                                                <p><strong>Email:</strong> ${e.email}</p>
                                                                <p><strong>SĐT:</strong> ${e.phone}</p>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <p><strong>Vai trò:</strong> ${e.roleName}</p>
                                                                <p><strong>Ngày vào làm:</strong> ${e.hireDate}</p>
                                                                <p><strong>Trạng thái:</strong>
                                                                    <span class="badge ${e.status ? 'badge-success' : 'badge-danger'}">
                                                                        ${e.status ? 'Active' : 'Inactive'}
                                                                    </span>
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Actions -->
                                                <div class="card">
                                                    <div class="card-body d-flex justify-content-between align-items-center">
                                                        <span class="text-muted">
                                                            <small>
                                                                <i class="far fa-calendar-alt"></i>
                                                                Ngày vào làm: ${e.hireDate}
                                                            </small>
                                                        </span>
                                                        <div>
                                                            <a href="${pageContext.request.contextPath}/admin/employees?action=edit&id=${e.employeeID}"
                                                               class="btn btn-warning btn-sm">
                                                                <i class="fas fa-edit"></i> Sửa
                                                            </a>

                                                            <c:if test="${e.status}">
                                                                <a href="${pageContext.request.contextPath}/admin/employees?action=deactivate&id=${e.employeeID}"
                                                                   class="btn btn-secondary btn-sm"
                                                                   onclick="return confirm('Vô hiệu hóa nhân viên này?')">
                                                                    <i class="fas fa-ban"></i> Deactivate
                                                                </a>
                                                            </c:if>

                                                            <c:if test="${!e.status}">
                                                                <a href="${pageContext.request.contextPath}/admin/employees?action=activate&id=${e.employeeID}"
                                                                   class="btn btn-success btn-sm">
                                                                    <i class="fas fa-check"></i> Activate
                                                                </a>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:if>

                        <c:if test="${empty lists}">
                            <div class="alert alert-info text-center">
                                <i class="fas fa-info-circle"></i>
                                Chưa có nhân viên nào.
                            </div>
                        </c:if>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="card-footer clearfix">
                            <div class="float-left text-muted">
                                Trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong>
                            </div>
                            <ul class="pagination pagination-sm m-0 float-right">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link"
                                           href="?page=${currentPage - 1}&key=${param.key}&status=${param.status}">
                                            «
                                        </a>
                                    </li>
                                </c:if>

                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <c:if test="${i >= currentPage-1 && i <= currentPage+1}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link"
                                               href="?page=${i}&key=${param.key}&status=${param.status}">
                                                ${i}
                                            </a>
                                        </li>
                                    </c:if>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link"
                                           href="?page=${currentPage + 1}&key=${param.key}&status=${param.status}">
                                            »
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </c:if>
                </div>

            </div>
        </section>
    </div>

    <!-- Footer -->
    <jsp:include page="include/admin-footer.jsp"/>

</div>

<!-- JS -->
<script src="${pageContext.request.contextPath}/AdminLTE-3.2.0/plugins/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/AdminLTE-3.2.0/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/AdminLTE-3.2.0/dist/js/adminlte.min.js"></script>

<script>
    function toggleDetail(id) {
        $('#detail-' + id).toggle();
    }
</script>

</body>
</html>
