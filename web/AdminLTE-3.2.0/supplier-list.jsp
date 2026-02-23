<%-- 
    Document   : supplier-list
    Created on : Jan 31, 2026, 12:21:55 AM
    Author     : qp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Quản lý nhà cung cấp</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/AdminLTE-3.2.0/dist/css/adminlte.min.css">
        <!-- Custom CSS -->
        <!--<link href="${pageContext.request.contextPath}/assets/style/main.css" rel="stylesheet">-->
    </head>
    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">

<!--             Navbar 
            <nav class="main-header navbar navbar-expand navbar-white navbar-light">
                 Left navbar links 
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
                    </li>
                </ul>
            </nav>
            -->

            <!-- Sidebar -->
            <jsp:include page="include/admin-sidebar.jsp" />

            <!-- Content Wrapper -->
            <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <section class="content-header">
                    <div class="container-fluid">
                        <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1>Quản lý nhà cung cấp</h1>
                            </div>
                            <div class="col-sm-6">
                                <ol class="breadcrumb float-sm-right">
                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Home</a></li>
                                    <li class="breadcrumb-item active">Nhà cung cấp</li>
                                </ol>
                            </div>
                        </div>
                    </div><!-- /.container-fluid -->
                </section>

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-12">
                                <!-- Search & Filter Card -->
                                <div class="card card-primary card-outline">
                                    <div class="card-header">
                                        <h3 class="card-title">
                                            <i class="fas fa-search"></i> Tìm kiếm & Lọc
                                        </h3>
                                    </div>
                                    <div class="card-body">
                                        <form action="${pageContext.request.contextPath}/supplier" method="get" class="form-inline">
                                            <input type="hidden" name="action" value="search">
                                            <div class="form-group mr-3 mb-2">
                                                <label for="key" class="mr-2">Tìm kiếm:</label>
                                                <input type="text" class="form-control" id="key" name="key" value="${param.key}" placeholder="Nhập từ khóa...">
                                            </div>

                                            <div class="form-group mr-3 mb-2">
                                                <label for="status" class="mr-2">Trạng thái:</label>
                                                <select name="status" id="status" class="form-control">
                                                    <option value="">Tất cả</option>
                                                    <option value="true" ${param.status=='true' ? 'selected': ''}>Hoạt động</option>
                                                    <option value="false" ${param.status=='false' ? 'selected': ''}>Ngừng hoạt động</option>
                                                </select>
                                            </div>

                                            <button type="submit" class="btn btn-primary mb-2 mr-2">
                                                <i class="fas fa-search"></i> Tìm kiếm
                                            </button>
                                            <a href="${pageContext.request.contextPath}/supplier?action=list" class="btn btn-default mb-2 mr-2">
                                                <i class="fas fa-redo"></i> Đặt lại
                                            </a>
                                            <a href="${pageContext.request.contextPath}/supplier?action=add" class="btn btn-success mb-2">
                                                <i class="fas fa-plus"></i> Tạo NCC mới
                                            </a>
                                        </form>
                                    </div>
                                </div>

                                <!-- Supplier List Card -->
                                <div class="card">
                                    <div class="card-header">
                                        <h3 class="card-title">
                                            <i class="fas fa-list"></i> Danh sách nhà cung cấp
                                        </h3>
                                    </div>
                                    <!-- /.card-header -->
                                    <div class="card-body">
                                        <c:if test="${not empty lists}">
                                            <table class="table table-bordered table-striped table-hover">
                                                <thead>
                                                    <tr>
                                                        <th style="width: 10%">Mã</th>
                                                        <th style="width: 30%">Tên NCC</th>
                                                        <th style="width: 25%">Người liên hệ</th>
                                                        <th style="width: 20%">Điện thoại</th>
                                                        <th style="width: 15%">Trạng thái</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="item" items="${lists}">
                                                        <tr class="expandable-row" onclick="toggleDetail('${item.supplierCode}')" style="cursor: pointer;">
                                                            <td>${item.supplierCode}</td>
                                                            <td>${item.supplierName}</td>
                                                            <td>${item.contactPerson}</td>
                                                            <td>${item.phone}</td>
                                                            <td>
                                                                <c:if test="${item.isActive}">
                                                                    <span class="badge badge-success">Hoạt động</span>
                                                                </c:if>
                                                                <c:if test="${!item.isActive}">
                                                                    <span class="badge badge-danger">Không hoạt động</span>
                                                                </c:if>
                                                            </td>
                                                        </tr>

                                                        <tr class="detail-row" style="display: none;" id="detail-${item.supplierCode}">
                                                            <td colspan="5">
                                                                <div style="padding: 15px; background-color: #f8f9fa;">
                                                                    <!-- Thông tin chi tiết -->
                                                                    <div class="card mb-3">
                                                                        <div class="card-header bg-info">
                                                                            <h5 class="card-title mb-0"><i class="fas fa-info-circle"></i> Thông tin chi tiết</h5>
                                                                        </div>
                                                                        <div class="card-body">
                                                                            <div class="row">
                                                                                <div class="col-md-6">
                                                                                    <p><strong>Tên NCC:</strong> ${item.supplierName}</p>
                                                                                    <p><strong>Người liên hệ:</strong> ${item.contactPerson}</p>
                                                                                    <p><strong>Điện thoại:</strong> ${item.phone}</p>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <p><strong>Email:</strong> ${item.email}</p>
                                                                                    <p><strong>Địa chỉ:</strong> ${item.address}</p>
                                                                                    <p><strong>Trạng thái:</strong> 
                                                                                        <c:if test="${item.isActive}">
                                                                                            <span class="badge badge-success">Hoạt động</span>
                                                                                        </c:if>
                                                                                        <c:if test="${!item.isActive}">
                                                                                            <span class="badge badge-danger">Không hoạt động</span>
                                                                                        </c:if>
                                                                                    </p>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <!-- Lịch sử giao dịch -->
                                                                    <div class="card mb-3">
                                                                        <div class="card-header bg-secondary">
                                                                            <h5 class="card-title mb-0"><i class="fas fa-history"></i> Lịch sử giao dịch</h5>
                                                                        </div>
                                                                        <div class="card-body">
                                                                            <table class="table table-sm table-bordered mb-0">
                                                                                <thead class="thead-light">
                                                                                    <tr>
                                                                                        <th>Ngày</th>
                                                                                        <th>Loại</th>
                                                                                        <th>Mã ĐĐH</th>
                                                                                        <th>Giá trị</th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td>20/01/26</td>
                                                                                        <td>Nhập hàng</td>
                                                                                        <td>PO-0123</td>
                                                                                        <td>15.000.000đ</td>
                                                                                    </tr>
                                                                                </tbody>
                                                                            </table>
                                                                        </div>
                                                                    </div>

                                                                    <!-- Thao tác -->
                                                                    <div class="card">
                                                                        <div class="card-body">
                                                                            <div class="d-flex justify-content-between align-items-center">
                                                                                <span class="text-muted"><small><i class="far fa-calendar-alt"></i> Ngày tạo: 10/12/2025</small></span>
                                                                                <div>
                                                                                    <a href="${pageContext.request.contextPath}/supplier?action=edit&code=${item.supplierCode}" class="btn btn-warning btn-sm">
                                                                                        <i class="fas fa-edit"></i> Sửa
                                                                                    </a>
                                                                                    <c:if test="${item.isActive}">
                                                                                        <form action="${pageContext.request.contextPath}/supplier" method="post" style="display: inline-block;">
                                                                                            <input type="hidden" name="code" value="${item.supplierCode}">
                                                                                            <button type="submit" name="action" value="deactive" class="btn btn-secondary btn-sm" onclick="return confirm('Bạn chắc chắn muốn hủy kích hoạt?');">
                                                                                                <i class="fas fa-ban"></i> Hủy kích hoạt
                                                                                            </button>
                                                                                        </form>
                                                                                    </c:if>
                                                                                    <c:if test="${!item.isActive}">
                                                                                        <form action="${pageContext.request.contextPath}/supplier" method="post" style="display: inline-block;">
                                                                                            <input type="hidden" name="code" value="${item.supplierCode}">
                                                                                            <button type="submit" name="action" value="active" class="btn btn-success btn-sm">
                                                                                                <i class="fas fa-check"></i> Kích hoạt
                                                                                            </button>
                                                                                        </form>
                                                                                    </c:if>
                                                                                    <form action="${pageContext.request.contextPath}/supplier" method="post" style="display: inline-block;">
                                                                                        <input type="hidden" name="code" value="${item.supplierCode}">
                                                                                        <button type="submit" name="action" value="delete" class="btn btn-danger btn-sm" onclick="return confirm('Bạn chắc chắn muốn xóa nhà cung cấp này?');">
                                                                                            <i class="fas fa-trash"></i> Xóa
                                                                                        </button>
                                                                                    </form>
                                                                                </div>
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
                                                Không có nhà cung cấp nào được thêm, hãy thêm nhà cung cấp mới.
                                            </div>
                                        </c:if>
                                    </div>
                                    <!-- /.card-body -->

                                    <!-- Pagination -->
                                    <c:if test="${not empty lists && totalPages > 1}">
                                        <div class="card-footer clearfix">
                                            <div class="float-left">
                                                <p class="text-muted">
                                                    Hiển thị trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong>
                                                </p>
                                            </div>
                                            <ul class="pagination pagination-sm m-0 float-right">
                                                <c:if test="${currentPage > 1}">
                                                    <li class="page-item">
                                                        <a class="page-link" href="supplier?action=list&page=1&key=${param.key}&status=${param.status}">First</a>
                                                    </li>
                                                    <li class="page-item">
                                                        <a class="page-link" href="supplier?action=list&page=${currentPage - 1}&key=${param.key}&status=${param.status}">«</a>
                                                    </li>
                                                </c:if>

                                                <c:forEach begin="1" end="${totalPages}" var="i">
                                                    <c:if test="${i == currentPage || i == currentPage - 1 || i == currentPage + 1}">
                                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                            <a class="page-link" href="supplier?action=list&page=${i}&key=${param.key}&status=${param.status}">${i}</a>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>

                                                <c:if test="${currentPage < totalPages}">
                                                    <li class="page-item">
                                                        <a class="page-link" href="supplier?action=list&page=${currentPage + 1}&key=${param.key}&status=${param.status}">»</a>
                                                    </li>
                                                    <li class="page-item">
                                                        <a class="page-link" href="supplier?action=list&page=${totalPages}&key=${param.key}&status=${param.status}">Last</a>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </div>
                                    </c:if>
                                </div>
                                <!-- /.card -->
                            </div>
                            <!-- /.col -->
                        </div>
                        <!-- /.row -->
                    </div>
                    <!-- /.container-fluid -->
                </section>
                <!-- /.content -->
            </div>
            <!-- /.content-wrapper -->

       
             <!-- Footer -->
    <jsp:include page="include/admin-footer.jsp" />
        </div>
        <!-- ./wrapper -->

        <!-- jQuery -->
        <script src="${pageContext.request.contextPath}/assets/AdminLTE-3.2.0/plugins/jquery/jquery.min.js"></script>
        <!-- Bootstrap 4 -->
        <script src="${pageContext.request.contextPath}/assets/AdminLTE-3.2.0/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- AdminLTE App -->
        <script src="${pageContext.request.contextPath}/assets/AdminLTE-3.2.0/dist/js/adminlte.min.js"></script>
        <!-- Custom JS -->
        <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>

        <!-- Toast notification script -->
        <c:if test="${not empty msg}">
            <script>
                                                                                            $(document).ready(function () {
                                                                                                var msgCode = "${msg}";
                                                                                                var message = "Thông báo hệ thống";
                                                                                                var toastClass = "bg-success";
                                                                                                var toastTitle = "Thành công";
                                                                                                var icon = "fas fa-check";

                                                                                                if (msgCode.includes("fail")) {
                                                                                                    message = "Có lỗi xảy ra, vui lòng thử lại!";
                                                                                                    toastClass = "bg-danger";
                                                                                                    toastTitle = "Lỗi";
                                                                                                    icon = "fas fa-times";
                                                                                                } else if (msgCode === "success_add") {
                                                                                                    message = "Thêm nhà cung cấp mới thành công!";
                                                                                                    icon = "fas fa-check-circle";
                                                                                                } else if (msgCode === "success_edit") {
                                                                                                    message = "Cập nhật thông tin thành công!";
                                                                                                    icon = "fas fa-edit";
                                                                                                } else if (msgCode === "success_delete") {
                                                                                                    message = "Xóa nhà cung cấp thành công!";
                                                                                                    icon = "fas fa-trash";
                                                                                                } else if (msgCode === "success_active") {
                                                                                                    message = "Kích hoạt nhà cung cấp thành công!";
                                                                                                    icon = "fas fa-check-circle";
                                                                                                } else if (msgCode === "success_deactive") {
                                                                                                    message = "Hủy kích hoạt nhà cung cấp!";
                                                                                                    toastClass = "bg-warning";
                                                                                                    toastTitle = "Cảnh báo";
                                                                                                    icon = "fas fa-ban";
                                                                                                }

                                                                                                // Sử dụng AdminLTE Toast
                                                                                                $(document).Toasts('create', {
                                                                                                    class: toastClass,
                                                                                                    title: toastTitle,
                                                                                                    subtitle: '',
                                                                                                    body: message,
                                                                                                    icon: icon,
                                                                                                    autohide: true,
                                                                                                    delay: 3500,
                                                                                                    position: 'topRight'
                                                                                                });
                                                                                            });
            </script>
        </c:if>
    </body>
</html>