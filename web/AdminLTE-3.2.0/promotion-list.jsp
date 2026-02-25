<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Chiến Dịch Khuyến Mãi</title>

            <!-- Google Font: Source Sans Pro -->
            <link rel="stylesheet"
                href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
            <!-- Font Awesome -->
            <link rel="stylesheet"
                href="<%= request.getContextPath() %>/AdminLTE-3.2.0/plugins/fontawesome-free/css/all.min.css">
            <!-- Theme style -->
            <link rel="stylesheet" href="<%= request.getContextPath() %>/AdminLTE-3.2.0/dist/css/adminlte.min.css">

            <style>
                /* ── Status labels ─────────────────────────────── */
                .status-on {
                    color: #28a745;
                    font-weight: 600;
                }

                .status-off {
                    color: #6c757d;
                    font-weight: 600;
                }

                .status-exp {
                    color: #dc3545;
                    font-weight: 600;
                }

                /* ── Action links ──────────────────────────────── */
                .action-link {
                    color: #007bff;
                    text-decoration: none;
                    font-weight: 500;
                    font-size: 13px;
                }

                .action-link:hover {
                    text-decoration: underline;
                }

                /* ── Table ─────────────────────────────────────── */
                #promotionTable thead th {
                    background-color: #f8f9fa;
                    font-weight: 700;
                    border-bottom: 2px solid #dee2e6;
                    vertical-align: middle;
                }

                #promotionTable tbody tr:hover {
                    background-color: #f4f6f9;
                }

                #promotionTable td {
                    vertical-align: middle;
                }

                /* ── Filter bar ────────────────────────────────── */
                .filter-bar {
                    display: flex;
                    align-items: center;
                    gap: 8px;
                }

                .filter-bar label {
                    font-weight: 600;
                    margin-bottom: 0;
                }

                /* ── Badge for type ────────────────────────────── */
                .badge-type {
                    font-size: 11px;
                    padding: 3px 8px;
                    border-radius: 10px;
                    font-weight: 600;
                    letter-spacing: 0.3px;
                }

                .badge-percent {
                    background: #cce5ff;
                    color: #004085;
                }

                .badge-buyx {
                    background: #d4edda;
                    color: #155724;
                }

                .badge-fixed {
                    background: #fff3cd;
                    color: #856404;
                }

                .badge-gift {
                    background: #f8d7da;
                    color: #721c24;
                }

                /* ── Legend ────────────────────────────────────── */
                .legend-text {
                    font-size: 12px;
                    color: #6c757d;
                }

                /* ── Empty state ───────────────────────────────── */
                .empty-state {
                    text-align: center;
                    padding: 40px 20px;
                    color: #868e96;
                }

                .empty-state i {
                    font-size: 40px;
                    margin-bottom: 12px;
                    display: block;
                }
            </style>
        </head>

        <body class="hold-transition sidebar-mini">
            <div class="wrapper">

                <!-- Navbar -->
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
                                    <h1><i class="fas fa-bullhorn mr-2"></i>CHIẾN DỊCH KHUYẾN MÃI</h1>
                                </div>
                                <div class="col-sm-6">
                                    <ol class="breadcrumb float-sm-right">
                                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                                        <li class="breadcrumb-item active">Khuyến Mãi</li>
                                    </ol>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Main content -->
                    <section class="content">
                        <div class="container-fluid">

                            <!-- Flash messages -->
                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fas fa-check-circle mr-1"></i> ${successMessage}
                                    <button type="button" class="close"
                                        data-dismiss="alert"><span>&times;</span></button>
                                </div>
                            </c:if>
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fas fa-exclamation-circle mr-1"></i> ${errorMessage}
                                    <button type="button" class="close"
                                        data-dismiss="alert"><span>&times;</span></button>
                                </div>
                            </c:if>

                            <!-- Filter bar + Create button -->
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <form action="<%= request.getContextPath() %>/admin/promotions" method="get"
                                    id="filterForm" class="filter-bar">
                                    <label><i class="fas fa-filter mr-1"></i>Lọc:</label>

                                    <select class="form-control form-control-sm" id="filterStatus" name="status"
                                        style="width:160px;" onchange="document.getElementById('filterForm').submit()">
                                        <option value="" <c:if test="${empty param.status}">selected</c:if>>Tất Cả Trạng
                                            Thái</option>
                                        <option value="ACTIVE" <c:if test="${param.status == 'ACTIVE'}">selected</c:if>
                                            >🟢 Đang Hoạt Động</option>
                                        <option value="INACTIVE" <c:if test="${param.status == 'INACTIVE'}">selected
                                            </c:if>>⚫ Không Hoạt Động</option>
                                    </select>

                                    <select class="form-control form-control-sm" id="filterType" name="type"
                                        style="width:180px;" onchange="document.getElementById('filterForm').submit()">
                                        <option value="" <c:if test="${empty param.type}">selected</c:if>>Tất Cả Loại
                                        </option>
                                        <option value="PERCENT" <c:if test="${param.type == 'PERCENT'}">selected</c:if>
                                            >Giảm % Giá
                                        </option>
                                        <option value="FIXED" <c:if test="${param.type == 'FIXED'}">
                                            selected</c:if>>Giảm Số Tiền Cố Định</option>
                                    </select>

                                    <!-- Nút reset filter nếu đang có filter -->
                                    <c:if test="${not empty param.status or not empty param.type}">
                                        <a href="<%= request.getContextPath() %>/admin/promotions"
                                            class="btn btn-sm btn-outline-secondary" title="Xóa bộ lọc">
                                            <i class="fas fa-times"></i>
                                        </a>
                                    </c:if>
                                </form>

                                <a href="<%= request.getContextPath() %>/admin/promotions?action=create"
                                    class="btn btn-success btn-sm">
                                    <i class="fas fa-plus mr-1"></i> Tạo Khuyến Mãi
                                </a>
                            </div>

                            <!-- Promotion Campaigns Card -->
                            <div class="card shadow-sm">
                                <div
                                    class="card-header bg-light d-flex align-items-center justify-content-between py-2">
                                    <h3 class="card-title text-bold text-uppercase mb-0" style="font-size:14px;">
                                        <i class="fas fa-list mr-1 text-muted"></i>
                                        Danh Sách Chiến Dịch Khuyến Mãi
                                    </h3>
                                    <c:if test="${not empty promotions}">
                                        <span class="badge badge-secondary">${promotions.size()} chiến dịch</span>
                                    </c:if>
                                </div>
                                <div class="card-body p-0">
                                    <table class="table table-bordered table-hover mb-0" id="promotionTable">
                                        <thead>
                                            <tr>
                                                <th style="width:5%;">#</th>
                                                <th style="width:32%;">Tên Chiến Dịch</th>
                                                <th style="width:18%;">Loại</th>
                                                <th style="width:20%;">Thời Gian</th>
                                                <th style="width:10%;">Trạng Thái</th>
                                                <th style="width:15%;" class="text-center">Thao Tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${not empty promotions}">
                                                    <c:forEach items="${promotions}" var="promo" varStatus="st">
                                                        <tr>
                                                            <td class="text-muted" style="font-size:13px;">
                                                                ${st.index + 1}</td>

                                                            <td>
                                                                <strong>${promo.promotionName}</strong>
                                                                <c:if test="${not empty promo.promotionCode}">
                                                                    <br><small
                                                                        class="text-muted">${promo.promotionCode}</small>
                                                                </c:if>
                                                            </td>

                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${promo.promotionType eq 'PERCENT'}">
                                                                        <span class="badge-type badge-percent">Giảm
                                                                            % Giá</span>
                                                                    </c:when>
                                                                    <c:when test="${promo.promotionType eq 'FIXED'}">
                                                                        <span class="badge-type badge-fixed">Giảm Cố
                                                                            Định</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span
                                                                            class="badge-type badge-secondary">${promo.promotionType}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>

                                                            <td style="font-size:13px;">
                                                                <i class="far fa-calendar-alt text-muted mr-1"></i>
                                                                ${promo.startDateFormatted}&nbsp;&rarr;&nbsp;${promo.endDateFormatted}
                                                            </td>

                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${promo.status eq 'ACTIVE'}">
                                                                        <span class="status-on"><i class="fas fa-circle"
                                                                                style="font-size:8px;"></i>
                                                                            Bật</span>
                                                                    </c:when>
                                                                    <c:when test="${promo.status eq 'INACTIVE'}">
                                                                        <span class="status-off"><i
                                                                                class="fas fa-circle"
                                                                                style="font-size:8px;"></i>
                                                                            Tắt</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="status-exp"><i
                                                                                class="fas fa-circle"
                                                                                style="font-size:8px;"></i> Hết
                                                                            hạn</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>

                                                            <td class="text-center">
                                                                <%-- Chỉnh sửa --%>
                                                                    <a href="<%= request.getContextPath() %>/admin/promotions?action=edit&id=${promo.promotionID}"
                                                                        class="action-link" title="Chỉnh sửa">
                                                                        <i class="fas fa-edit"></i>
                                                                    </a>

                                                                    <span class="text-muted mx-1">|</span>

                                                                    <%-- Gửi thông báo --%>
                                                                        <a href="<%= request.getContextPath() %>/admin/promotions?action=notify&id=${promo.promotionID}"
                                                                            class="action-link" title="Gửi Thông Báo">
                                                                            <i class="fas fa-bell"></i>
                                                                        </a>

                                                                        <span class="text-muted mx-1">|</span>

                                                                        <%-- Toggle On/Off (disabled khi hết hạn) --%>
                                                                            <c:choose>
                                                                                <c:when
                                                                                    test="${promo.status eq 'ACTIVE'}">
                                                                                    <a href="<%= request.getContextPath() %>/admin/promotions?action=toggle&id=${promo.promotionID}&currentStatus=ACTIVE<c:if test="
                                                                                        ${not empty
                                                                                        param.status}">&status=${param.status}
                                                                                        </c:if>
                                                                                        <c:if
                                                                                            test="${not empty param.type}">
                                                                                            &type=${param.type}
                                                                                        </c:if>"
                                                                                        class="action-link
                                                                                        text-danger" title="Tắt
                                                                                        khuyến mãi"
                                                                                        onclick="return confirm('Xác
                                                                                        nhận TẮT chiến dịch:
                                                                                        ${promo.promotionName}?')">
                                                                                        <i class="fas fa-toggle-on"></i>
                                                                                    </a>
                                                                                </c:when>
                                                                                <c:when
                                                                                    test="${promo.status eq 'INACTIVE'}">
                                                                                    <a href="<%= request.getContextPath() %>/admin/promotions?action=toggle&id=${promo.promotionID}&currentStatus=INACTIVE<c:if test="
                                                                                        ${not empty
                                                                                        param.status}">&status=${param.status}
                                                                                        </c:if>
                                                                                        <c:if
                                                                                            test="${not empty param.type}">
                                                                                            &type=${param.type}
                                                                                        </c:if>"
                                                                                        class="action-link
                                                                                        text-success" title="Bật
                                                                                        khuyến mãi"
                                                                                        onclick="return confirm('Xác
                                                                                        nhận BẬT chiến dịch:
                                                                                        ${promo.promotionName}?')">
                                                                                        <i
                                                                                            class="fas fa-toggle-off"></i>
                                                                                    </a>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <span class="text-muted"
                                                                                        title="Đã hết hạn">
                                                                                        <i class="fas fa-ban"></i>
                                                                                    </span>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>

                                                <%-- Không có dữ liệu --%>
                                                    <c:otherwise>
                                                        <tr>
                                                            <td colspan="6">
                                                                <div class="empty-state">
                                                                    <i class="fas fa-search text-muted"></i>
                                                                    <c:choose>
                                                                        <c:when
                                                                            test="${not empty param.status or not empty param.type}">
                                                                            Không có chương trình khuyến mãi nào phù
                                                                            hợp với bộ lọc đã chọn.<br>
                                                                            <a href="<%= request.getContextPath() %>/admin/promotions"
                                                                                class="btn btn-sm btn-outline-secondary mt-2">
                                                                                <i class="fas fa-times mr-1"></i>Xóa
                                                                                bộ lọc
                                                                            </a>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            Chưa có chiến dịch khuyến mãi nào.<br>
                                                                            <a href="<%= request.getContextPath() %>/admin/promotions?action=create"
                                                                                class="btn btn-sm btn-success mt-2">
                                                                                <i class="fas fa-plus mr-1"></i>Tạo
                                                                                Khuyến Mãi
                                                                            </a>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Legend -->
                                <div class="card-footer bg-transparent border-top py-2">
                                    <p class="legend-text mb-0">
                                        <i class="fas fa-edit text-primary"></i> = Chỉnh Sửa &nbsp;|&nbsp;
                                        <i class="fas fa-bell text-primary"></i> = Gửi Thông Báo &nbsp;|&nbsp;
                                        <i class="fas fa-toggle-on text-danger"></i> = Đang Bật (click để Tắt)
                                        &nbsp;|&nbsp;
                                        <i class="fas fa-toggle-off text-success"></i> = Đang Tắt (click để Bật)
                                    </p>
                                </div>
                            </div><%-- /.card --%>

                        </div><%-- /.container-fluid --%>
                    </section><%-- /.content --%>
                </div><%-- /.content-wrapper --%>

                    <!-- Footer -->
                    <jsp:include page="include/admin-footer.jsp" />
            </div><%-- /.wrapper --%>

                <!-- jQuery -->
                <script src="<%= request.getContextPath() %>/AdminLTE-3.2.0/plugins/jquery/jquery.min.js"></script>
                <!-- Bootstrap 4 -->
                <script
                    src="<%= request.getContextPath() %>/AdminLTE-3.2.0/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
                <!-- AdminLTE App -->
                <script src="<%= request.getContextPath() %>/AdminLTE-3.2.0/dist/js/adminlte.min.js"></script>

                <script>
                    // Tự đóng alert sau 4 giây
                    setTimeout(function () {
                        $('.alert').alert('close');
                    }, 4000);
                </script>
        </body>

        </html>