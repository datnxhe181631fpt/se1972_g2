<%-- 
    Document   : dashboard
    Created on : Mar 9, 2026, 12:35:12 PM
    Author     : xuand
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dashboard - Bookstore POS</title>

    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/AdminLTE-3.2.0/plugins/fontawesome-free/css/all.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/AdminLTE-3.2.0/dist/css/adminlte.min.css">
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
    
    <!-- Header -->
    <jsp:include page="include/admin-header.jsp" />
    
    <!-- Sidebar -->
    <jsp:include page="include/admin-sidebar.jsp" />
    
    <!-- Content Wrapper -->
    <div class="content-wrapper">
        <!-- Content Header -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Dashboard</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="<%= request.getContextPath() %>/dashboard">Home</a></li>
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ol>
                    </div>
                </div>
            </div>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                
                <!-- Welcome Card -->
                <div class="row">
                    <div class="col-12">
                        <div class="card card-primary">
                            <div class="card-header">
                                <h3 class="card-title">
                                    <i class="fas fa-home mr-2"></i>
                                    Chào mừng đến với Bookstore POS
                                </h3>
                            </div>
                            <div class="card-body">
                                <h4>Xin chào, <strong>${sessionScope.employeeName}</strong>!</h4>
                                <p class="text-muted">Vai trò: <span class="badge badge-info">${sessionScope.employeeRoleName}</span></p>
                                <p>Chúc bạn có một ngày làm việc hiệu quả!</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Info boxes -->
                <div class="row">
                    <!-- Total Sales -->
                    <div class="col-lg-3 col-6">
                        <div class="small-box bg-info">
                            <div class="inner">
                                <h3>150</h3>
                                <p>Đơn hàng hôm nay</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                            <a href="#" class="small-box-footer">
                                Xem chi tiết <i class="fas fa-arrow-circle-right"></i>
                            </a>
                        </div>
                    </div>

                    <!-- Revenue -->
                    <div class="col-lg-3 col-6">
                        <div class="small-box bg-success">
                            <div class="inner">
                                <h3>53<sup style="font-size: 20px">M</sup></h3>
                                <p>Doanh thu hôm nay</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                            <a href="#" class="small-box-footer">
                                Xem chi tiết <i class="fas fa-arrow-circle-right"></i>
                            </a>
                        </div>
                    </div>

                    <!-- Products -->
                    <div class="col-lg-3 col-6">
                        <div class="small-box bg-warning">
                            <div class="inner">
                                <h3>44</h3>
                                <p>Sản phẩm sắp hết</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-exclamation-triangle"></i>
                            </div>
                            <a href="#" class="small-box-footer">
                                Xem chi tiết <i class="fas fa-arrow-circle-right"></i>
                            </a>
                        </div>
                    </div>

                    <!-- Customers -->
                    <div class="col-lg-3 col-6">
                        <div class="small-box bg-danger">
                            <div class="inner">
                                <h3>65</h3>
                                <p>Khách hàng mới</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-user-plus"></i>
                            </div>
                            <a href="#" class="small-box-footer">
                                Xem chi tiết <i class="fas fa-arrow-circle-right"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">
                                    <i class="fas fa-bolt mr-2"></i>
                                    Thao tác nhanh
                                </h3>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3 col-sm-6 col-12">
                                        <a href="<%= request.getContextPath() %>/pos" class="btn btn-app btn-primary btn-block">
                                            <i class="fas fa-cash-register"></i>
                                            Bán hàng
                                        </a>
                                    </div>
                                    
                                    <c:if test="${sessionScope.employeeRoleId == 2}">
                                    <div class="col-md-3 col-sm-6 col-12">
                                        <a href="<%= request.getContextPath() %>/admin/brands" class="btn btn-app btn-success btn-block">
                                            <i class="fas fa-tags"></i>
                                            Quản lý thương hiệu
                                        </a>
                                    </div>
                                    <div class="col-md-3 col-sm-6 col-12">
                                        <a href="<%= request.getContextPath() %>/admin/categories" class="btn btn-app btn-info btn-block">
                                            <i class="fas fa-list"></i>
                                            Quản lý danh mục
                                        </a>
                                    </div>
                                    </c:if>
                                    
                                    <c:if test="${sessionScope.employeeRoleId == 2 || sessionScope.employeeRoleId == 3}">
                                    <div class="col-md-3 col-sm-6 col-12">
                                        <a href="<%= request.getContextPath() %>/purchaseorder" class="btn btn-app btn-warning btn-block">
                                            <i class="fas fa-warehouse"></i>
                                            Nhập hàng
                                        </a>
                                    </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activities (Optional) -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">
                                    <i class="fas fa-clock mr-2"></i>
                                    Hoạt động gần đây
                                </h3>
                            </div>
                            <div class="card-body">
                                <ul class="list-unstyled">
                                    <li class="mb-2">
                                        <i class="fas fa-check-circle text-success mr-2"></i>
                                        Đơn hàng #INV-001 đã hoàn thành
                                        <span class="text-muted float-right">5 phút trước</span>
                                    </li>
                                    <li class="mb-2">
                                        <i class="fas fa-box text-info mr-2"></i>
                                        Nhập kho 50 sản phẩm mới
                                        <span class="text-muted float-right">1 giờ trước</span>
                                    </li>
                                    <li class="mb-2">
                                        <i class="fas fa-user-plus text-primary mr-2"></i>
                                        Khách hàng mới đăng ký
                                        <span class="text-muted float-right">2 giờ trước</span>
                                    </li>
                                    <li class="mb-2">
                                        <i class="fas fa-exclamation-triangle text-warning mr-2"></i>
                                        Cảnh báo tồn kho thấp
                                        <span class="text-muted float-right">3 giờ trước</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">
                                    <i class="fas fa-bell mr-2"></i>
                                    Thông báo
                                </h3>
                            </div>
                            <div class="card-body">
                                <div class="alert alert-warning alert-dismissible">
                                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                                    <h5><i class="icon fas fa-exclamation-triangle"></i> Cảnh báo!</h5>
                                    Có 5 đơn đặt hàng cần được duyệt.
                                </div>
                                <div class="alert alert-info alert-dismissible">
                                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                                    <h5><i class="icon fas fa-info"></i> Thông tin!</h5>
                                    Hệ thống sẽ bảo trì vào 2h sáng ngày mai.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>
    </div>

    <!-- Footer -->
    <footer class="main-footer">
        <div class="float-right d-none d-sm-block">
            <b>Version</b> 1.0.0
        </div>
        <strong>Copyright &copy; 2026 <a href="#">Bookstore POS</a>.</strong> All rights reserved.
    </footer>
</div>

<!-- jQuery -->
<script src="<%= request.getContextPath() %>/AdminLTE-3.2.0/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="<%= request.getContextPath() %>/AdminLTE-3.2.0/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="<%= request.getContextPath() %>/AdminLTE-3.2.0/dist/js/adminlte.min.js"></script>
</body>
</html>
