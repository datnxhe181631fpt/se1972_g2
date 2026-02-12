<%-- 
    Document   : po-form
    Created on : Feb 11, 2026, 3:40:40 PM
    Author     : qp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Tạo đơn đặt hàng</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/AdminLTE-3.2.0/dist/css/adminlte.min.css">
    </head>
    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">
            <!-- Sidebar -->
            <jsp:include page="include/admin-header.jsp" />
            <jsp:include page="include/admin-sidebar.jsp"/>

            <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <section class="content-header">
                    <div class="container-fluid">
                        <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1>
                                    <c:if test="${mode=='add'}">Tạo đơn đặt hàng mới</c:if>
                                    <c:if test="${mode=='edit'}">Sửa đơn đặt hàng</c:if>
                                    </h1>
                                </div>
                                <div class="col-sm-6">
                                    <ol class="breadcrumb float-sm-right">
                                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Home</a></li>
                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/purchaseorder?action=list">Đơn đặt hàng</a></li>
                                    <li class="breadcrumb-item active">
                                        <c:if test="${mode=='add'}">Thêm mới</c:if>
                                        <c:if test="${mode=='edit'}">Chỉnh sửa</c:if>
                                        </li>
                                    </ol>
                                </div>
                            </div>
                        </div><!-- /.container-fluid -->
                    </section>

                    <!-- Main content -->
                    <section class="content">
                        <div class="container-fluid">
                            <div class="row">
                                <!-- left column -->
                                <div class="col-12">     
                                    <!-- general form elements -->
                                    <div class="card-header">
                                        <h3 class="card-title">Thông tin cơ bản</h3>
                                    </div>
                                    <!-- /.card-header -->

                                    <!-- Display error message if exists -->
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger alert-dismissible" style="margin: 15px 15px 0 15px;">
                                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                        <i class="icon fas fa-ban"></i> ${error}
                                    </div>
                                </c:if>

                                <!-- form start -->
                                <form action="${pageContext.request.contextPath}/purchaseorder" method="post">
                                    <div class="card-body">
                                        <div class="form-group">
                                            <label for="poNumber">Mã ĐĐH: </label>
                                            <input type="text" class="form-control" id="poNumber" name="poNumber" value="${poNumber}" placeholder="Tự động" readonly>
                                            <small class="form-text text-muted">* Mã đơn đặt hàng được tự động tạo</small>
                                        </div>

                                        <div class="form-group">
                                            <label for="supplierId">Nhà cung cấp: </label>
                                            <select id="supplierId" name="supplierId">
                                                <c:forEach var="item" items="${supList}">
                                                    <option value="${item.supplierId}"> ${item.supplierName}</option>
                                                </c:forEach>
                                            </select>
                                            <small class="form-text text-muted">*</small>
                                        </div>  

                                        <div class="form-group">
                                            <label for="orderDate">Ngày tạo: </label>
                                            <input type="date" class="form-control" id="orderDate" name="orderDate" value="${orderDate}">
                                        </div>

                                        <div class="form-group">
                                            <label for="orderDate">Ngày giao dự kiến: </label>
                                            <input type="date" class="form-control" id="expectedDate" name="expectedDate" value="${expectedDate}" >
                                        </div>


                                        <!-- add items -->
                                        <div class="card card-outline card-info mt-3">
                                            <div class="card-header">
                                                <h3 class="card-title"><i class="fas fa-boxes"></i>Chi tiết sản phẩm</h3>
                                                <div class="card-tools">
                                                    <a href="${pageContext.request.contextPath}/purchaseorder?action=addProduct" class="btn btn-success btn-sm">
                                                        <i class="fas fa-plus"></i>Thêm sản phẩm
                                                    </a> 
                                                </div>
                                            </div>
                                            <div class="card-body p-0">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered table-striped table hover mb-0">
                                                        <thead>
                                                            <tr>
                                                                <th style="width: 5%">STT</th>
                                                                <th style="width: 25%">Sản phẩm</th>
                                                                <th style="width: 10%">Số lượng</th>
                                                                <th style="width: 15%">Đơn giá</th>
                                                                <th style="width: 10%">Giảm giá</th>
                                                                <th style="width: 15%">Thành tiền</th>
                                                                <th style="width: 15%">Ghi chú</th>
                                                                <th style="width: 5%">Xóa</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:choose>
                                                                <c:when test="${not empty orderItems}">
                                                                    <c:forEach var="item" items="${orderItems}" varStatus="status">
                                                                        <tr>
                                                                            <td class="text-center">${status.index + 1}</td>
                                                                            <td> ${item.productName} </td>
                                                                            <td>
                                                                                <input type="number" class="form-control form-control-sm" value="${item.quantity}" min="1">
                                                                            </td>
                                                                            <td>
                                                                                <input type="number" class="form-control form-control-sm" value="${item.unitPrice}" min="0" step="1000">
                                                                            </td>
                                                                            <td>
                                                                                <div class="input-group input-group-sm">
                                                                                    <input type="number" class="form-control" value="${item.discount}" min="0" max="100">
                                                                                    <div class="input-group-append">
                                                                                        <span class="input-group-text">%</span>
                                                                                    </div>
                                                                                </div>
                                                                            </td>
                                                                            <td class="text-right">
                                                                                <strong class="text-success">${item.totalPrice}đ</strong>
                                                                            </td>
                                                                            <td>
                                                                                <input type="text" class="form-control form-control-sm" value="${item.notes}" placeholder="Ghi chú...">
                                                                            </td>
                                                                            <td class="text-center">
                                                                                <button type="button" class="btn btn-danger btn-sm" onclick="return confirm('Xóa sản phẩm này?');">
                                                                                    <i class="fas fa-trash"></i>
                                                                                </button>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <tr>
                                                                        <td colspan="8" class="text-center text-muted py-4">
                                                                            <i class="fas fa-inbox fa-3x mb-3 d-block"></i>
                                                                            <p class="mb-0">Chưa có sản phẩm nào. Click "Thêm sản phẩm" để bắt đầu.</p>
                                                                        </td>
                                                                    </tr>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Notes -->
                                        <div class="form-group mt-3">
                                            <label for="notes"><i class="fas fa-sticky-note"></i> Ghi chú:</label>
                                            <textarea class="form-control" id="notes" name="notes" rows="3" placeholder="Nhập ghi chú cho đơn đặt hàng...">${notes}</textarea>
                                        </div><!-- ./them chi tiet san pham -->

                                    </div><!-- ./card-body -->
                                    <div class="card-footer">
                                        <a href="${pageContext.request.contextPath}/purchaseorder?action=list" class="btn btn-default">
                                            <i class="fas fa-times"></i> Hủy
                                        </a>
                                        <button type="submit" name="action" value="save" class="btn btn-primary float-right">
                                            <i class="fas fa-save"></i> Gửi duyệt
                                        </button>
                                    </div>  
                            </div><!-- ./col-12 -->
                            </form><!-- ./form -->
                        </div><!-- ./row -->
                    </div><!-- ./container-fluid -->
                </section><!-- ./content -->

            </div><!-- ./content-wrapper -->

            <!-- Footer -->
            <jsp:include page="include/admin-footer.jsp" />
        </div><!-- ./wrapper -->

        <!-- jQuery -->
        <script src="${pageContext.request.contextPath}/assets/AdminLTE-3.2.0/plugins/jquery/jquery.min.js"></script>
        <!-- Bootstrap 4 -->
        <script src="${pageContext.request.contextPath}/assets/AdminLTE-3.2.0/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- AdminLTE App -->
        <script src="${pageContext.request.contextPath}/assets/AdminLTE-3.2.0/dist/js/adminlte.min.js"></script>

    </body>
</html>
