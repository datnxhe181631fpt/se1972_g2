<%-- 
    Document   : po-list
    Created on : Feb 9, 2026, 3:43:51 PM
    Author     : qp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách đơn đặt hàng</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/AdminLTE-3.2.0/dist/css/adminlte.min.css">
    </head>
    <body class="hold-transition sidebar-mini layout-fixed">

        <div class="wrapper">
            <!--sidebar-->
            <jsp:include page="include/admin-sidebar.jsp" />

            <!-- Content Wrapper -->
            <div class="content-wrapper">
                <!--content header (page header) -->
                <section class="content-header">
                    <div class="container-fluid">
                        <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1>Quản lý đơn đặt hàng</h1>
                            </div>
                            <div>
                                <ol class="breadcrumb float-sm-right">
                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active">Đơn đặt hàng</li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </section>


                <!-- main content -->
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
                                        <a href="${pageContext.request.contextPath}/purchaseorder?action=add"
                                           class="btn btn-success mb-2" style="margin-left: 80%;">
                                            <i class="fas fa-plus"></i> Tạo đơn đặt hàng mới
                                        </a>
                                    </div>
                                    <div class="card-body">
                                        <form action="${pageContext.request.contextPath}/purchaseorder" method="get"
                                              class="form-inline">
                                            <input type="hidden" name="action" value="search">
                                            <div class="form-group mr-3 mb-2">
                                                <label for="key" class="mr-2">Tìm kiếm:</label>
                                                <input type="text" class="form-control" id="key" name="key" value="${param.key}"
                                                       placeholder="Nhập từ khóa...">
                                            </div>

                                            <div class="form-group mr-3 mb-2">
                                                <label for="status" class="mr-2">Trạng thái:</label>
                                                <select name="status" id="status" class="form-control">
                                                    <option value="PENDING_APPROVAL">Chờ duyệt</option>
                                                    <option value="APPROVED">Đã duyệt</option>
                                                    <option value="CANCELLED">Đã hủy</option>
                                                    <option value="REJECTED">Đã từ chối</option>
                                                    <option value="PARTIAL">Nhận một phần</option>
                                                    <option value="COMPLETED">Đã hoàn thành</option>
                                                </select>
                                            </div>
                                            <div class="form-group mr-3 mb-2">
                                                <label for="from" class="mr-2">Từ ngày:</label>
                                                <input type="date" class="form-control" id="from" name="from" value="${param.from}">
                                            </div>

                                            <div class="form-group mr-3 mb-2">
                                                <label for="to" class="mr-2">Đến ngày: </label>
                                                <input type="date" class="form-control" id="to" name="to" value="${param.to}">
                                            </div>

                                            <button type="submit" class="btn btn-primary mb-2 mr-2">
                                                <i class="fas fa-search"></i> Tìm kiếm
                                            </button>
                                            <a href="${pageContext.request.contextPath}/purchaseorder?action=list"
                                               class="btn btn-default mb-2 mr-2">
                                                <i class="fas fa-redo"></i> Đặt lại
                                            </a>

                                        </form>
                                    </div>
                                </div><!-- search box-->

                                <div class="card">
                                    <div class="card-header">
                                        <h3 class="card-title">
                                            <i class="fas fa-list"></i> Danh sách đơn đặt hàng
                                        </h3>
                                    </div>
                                    <div class="card-body">
                                        <c:if test="${not empty lists}">
                                            <table class="table table-bordered table-striped table-hover">
                                                <thead>
                                                    <tr>
                                                        <th style="width: 10%">Mã</th>
                                                        <th style="width: 30%">Ngày tạo</th>
                                                        <th style="width: 20%">Nhà cung cấp</th>
                                                        <th style="width: 20%">Tổng tiền</th>
                                                        <th style="width: 10%">Trạng thái</th>
                                                        <th style="width: 10%">Người tạo</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="item" items="${lists}">
                                                        <tr class="expandable-row" onclick="toggleDetail('${item.poNumber}')"
                                                            style="cursor: pointer">
                                                            <td>${item.poNumber}</td>
                                                            <td>${item.createdAt}</td>
                                                            <td>${item.supplierId}</td>
                                                            <td>${item.totalAmount}</td>
                                                            <td>
                                                                <c:if test="${item.status == 'PENDING_APPROVAL'}">
                                                                    <span class="badge badge-success">Chờ duyệt</span>
                                                                </c:if>
                                                                <c:if test="${item.status == 'APPROVED'}">
                                                                    <span class="badge badge-success">Đã duyệt</span>
                                                                </c:if>
                                                                <c:if test="${item.status == 'REJECTED'}">
                                                                    <span class="badge badge-danger">Từ chối</span>
                                                                </c:if>
                                                            </td>
                                                            <td>${item.createdBy}</td>
                                                        </tr>

                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </c:if>

                                        <c:if test="${empty lists}">
                                            <div class="alert alert-info text-center">
                                                <i class="fas fa-info-circle"></i>
                                                Không có đơn đặt hàng nào được thêm, hãy thêm đơn đặt hàng mới.
                                            </div>
                                        </c:if>
                                    </div><!-- /.card-body -->

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
                                                        <a class="page-link"
                                                           href="purchaseorder?action=list&page=1&key=${param.key}&status=${param.status}&from=${param.from}&to=${param.to}">First</a>
                                                    </li>
                                                    <li class="page-item">
                                                        <a class="page-link"
                                                           href="purchaseorder?action=list&page=${currentPage - 1}&key=${param.key}&status=${param.status}&from=${param.from}&to=${param.to}">«</a>
                                                    </li>
                                                </c:if>

                                                <c:forEach begin="1" end="${totalPages}" var="i">
                                                    <c:if test="${i == currentPage || i == currentPage - 1 || i == currentPage + 1}">
                                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                            <a class="page-link"
                                                               href="purchaseorder?action=list&page=${i}&key=${param.key}&status=${param.status}&from=${param.from}&to=${param.to}">${i}</a>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>

                                                <c:if test="${currentPage < totalPages}">
                                                    <li class="page-item">
                                                        <a class="page-link"
                                                           href="purchaseorder?action=list&page=${currentPage + 1}&key=${param.key}&status=${param.status}&from=${param.from}&to=${param.to}">»</a>
                                                    </li>
                                                    <li class="page-item">
                                                        <a class="page-link"
                                                           href="purchaseorder?action=list&page=${totalPages}&key=${param.key}&status=${param.status}&from=${param.from}&to=${param.to}">Last</a>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </div>
                                    </c:if>
                                </div><!-- /.card -->

                            </div><!-- ./ col-12 -->
                        </div><!-- ./ row -->
                    </div><!-- ./ container-fluid -->
                </section> <!--./ content -->
            </div><!-- ./ content-wrapper -->


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

    </body>
</html>
