<%-- 
    Document   : po-detail
    Created on : Feb 24, 2026, 10:55:58 PM
    Author     : qp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết đơn đặt hàng</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/AdminLTE-3.2.0/dist/css/adminlte.min.css">

    </head>
    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">
            <!-- Navbar & Sidebar -->
            <jsp:include page="include/admin-header.jsp" />
            <jsp:include page="include/admin-sidebar.jsp" />


            <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <section class="content-header">
                    <div class="container-fluid">
                        <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1>
                                    Chi tiết đơn đặt hàng
                                </h1>
                            </div>
                            <div class="col-sm-6">
                                <ol class="breadcrumb float-sm-right">
                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Home</a></li>
                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/purchaseorder?action=list">Đơn đặt hàng</a></li>
                                    <li class="breadcrumb-item active">
                                        Chi tiết
                                    </li>
                                </ol>
                            </div>
                        </div>
                    </div><!-- /.container-fluid -->
                </section>

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                <i class="icon fas fa-ban"></i> ${error}
                            </div>
                        </c:if>

                        <div class="card card-default">
                            <div class="card-header">
                                <h3 class="card-title"><strong>Thông tin đơn hàng</strong></h3>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <p><strong>Mã ĐĐH:</strong> <span class="text-primary">${po.poNumber}</span></p>
                                    </div>
                                    <div class="col-md-4">
                                        <p><strong>Nhà cung cấp:</strong> ${not empty po.supplierName ? po.supplierName : po.supplierId}</p>
                                        <p><strong>Ngày tạo:</strong> ${po.createdAt}</p>
                                    </div>
                                    <div class="col-md-4">
                                        <p><strong>Ngày giao dự kiến:</strong> ${po.expectedDate}</p>
                                        <p><strong>Trạng thái: </strong> 
                                        <c:choose>
                                            <c:when test="${po.status == 'PENDING_APPROVAL'}"><span class="badge badge-warning">Chờ duyệt</span></c:when>
                                            <c:when test="${po.status == 'APPROVED'}"><span class="badge badge-success">Đã duyệt</span></c:when>
                                            <c:when test="${po.status == 'CANCELLED'}"><span class="badge badge-danger">Đã hủy</span></c:when>
                                            <c:when test="${po.status == 'REJECTED'}"><span class="badge badge-danger">Từ chối</span></c:when>
                                            <c:otherwise><span class="badge badge-secondary">${po.status}</span></c:otherwise>
                                        </c:choose>
                                        </p>
                                    </div>
                                </div>
                                <hr>

                                <h5><strong>Chi tiết sản phẩm</strong></h5>
                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th style="width: 50px">STT</th>
                                                <th>Sản phẩm</th>
                                                <th>Số lượng</th>
                                                <th>Đơn giá</th>
                                                <th>Giảm giá</th> 
                                                <th>Thành tiền</th>
                                                <th>Ghi chú</th>
                                            </tr> 
                                        </thead>
                                        <tbody>
                                        <c:forEach var="item" items="${items}" varStatus="status">
                                            <tr>
                                                <td>${status.index + 1}</td>
                                                <td>${item.productName}</td>
                                                <td>${item.quantityOrdered}</td>
                                                <td><fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="đ"/></td>
                                            <td><fmt:formatNumber value="${item.discountValue}" type="currency" currencySymbol="đ"/></td>
                                            <td><strong class="text-success"><fmt:formatNumber value="${item.lineTotal}" type="currency" currencySymbol="đ"/></strong></td>
                                            <td>${item.notes}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="row mt-3">
                                    <div class="col-md-6">
                                        <p><strong>Ghi chú:</strong> <br> 
                                            <em>${not empty po.notes ? po.notes : 'Không có ghi chú'}</em>
                                        </p>
                                    </div>
                                    <div class="col-md-6 text-right">
                                        <p>Tổng phụ: <strong><fmt:formatNumber value="${po.subtotal}" type="currency" currencySymbol="đ"/></strong></p>
                                        <p>Tổng giảm giá: <strong><fmt:formatNumber value="${po.totalDiscount}" type="currency" currencySymbol="đ"/></strong></p>
                                        <h4>Tổng tiền: <strong class="text-danger"><fmt:formatNumber value="${po.totalAmount}" type="currency" currencySymbol="đ"/></strong></h4>
                                    </div>
                                </div>

                                <hr>
                                <h5><strong>Thông tin kiểm soát</strong></h5>
                                <div class="row text-muted" style="font-size: 0.9rem;">
                                    <div class="col-md-6">
                                        Người tạo: <strong>${not empty po.createdByName ? po.createdByName : po.createdBy}</strong> - ${po.createdAt}
                                    </div>
                                    <div class="col-md-6">
                                        Người duyệt:
                                        <c:choose>
                                            <c:when test="${not empty po.approvedBy}">
                                                <strong>${not empty po.approvedByName ? po.approvedByName : po.approvedBy}</strong> - ${po.approvedAt}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">(Chưa duyệt)</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="mt-4 pt-3 border-top">
                                    <!-- Actions for Manager when status is PENDING -->
                                    <form method="post" action="${pageContext.request.contextPath}/purchaseorder">
                                        <input type="hidden" name="action" value="approve" />
                                        <input type="hidden" name="poId" value="${po.id}" />
                                        <div class="form-group">
                                            <label for="rejectReason">Lý do từ chối:</label>
                                            <textarea class="form-control" id="rejectReason" name="rejectReason" rows="3"></textarea>
                                        </div>

                                        <button type="submit" name="decision" value="reject" class="btn btn-danger">
                                            <i class="fas fa-times"></i> Từ chối
                                        </button>
                                        <button type="submit" name="decision" value="approve" class="btn btn-success ml-2">
                                            <i class="fas fa-check"></i> Duyệt
                                        </button>
                                    </form>

                                    <!-- Actions for Manager when status is APPROVED -->
                                    <form method="post" action="${pageContext.request.contextPath}/purchaseorder">
                                        <input type="hidden" name="action" value="cancel" />
                                        <input type="hidden" name="poId" value="${po.poId}" />

                                        <div class="form-group">
                                            <label for="cancelReason">Lý do hủy:</label>
                                            <textarea class="form-control" id="cancelReason" name="cancelReason" rows="3"></textarea>
                                        </div>

                                        <button type="submit" class="btn btn-danger">
                                            <i class="fas fa-ban"></i> Hủy đơn
                                        </button>
                                    </form>

                                    <!-- Actions for Staff (Creator) when status is PENDING -->
                                    <a href="${pageContext.request.contextPath}/purchaseorder?action=edit&poId=${po.poId}" class="btn btn-primary">
                                        <i class="fas fa-edit"></i> Sửa đơn
                                    </a>

                                    <!-- Back Button (always visible) -->
                                    <a href="${pageContext.request.contextPath}/purchaseorder?action=list" class="btn btn-secondary ${sessionScope.userRole != null ? 'ml-2' : ''}">
                                        <i class="fas fa-arrow-left"></i> Quay lại
                                    </a>                                        
                                </div><!-- ./mt-4 -->
                            </div><!-- ./card-body -->
                        </div><!-- ./card -->

                    </div><!-- ./container-fluid -->
                </section><!-- ./content -->


     

            </div><!-- ./content-wrapper -->
            <jsp:include page="include/admin-footer.jsp" />
        </div><!-- ./wrapper -->

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/AdminLTE-3.2.0/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="${pageContext.request.contextPath}/AdminLTE-3.2.0/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath}/AdminLTE-3.2.0/dist/js/adminlte.min.js"></script>

</body>
</html>
