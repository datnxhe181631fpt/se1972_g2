<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Lịch sử mua hàng - Bookstore</title>

    <!-- Google Font -->
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
    <!-- FontAwesome -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/AdminLTE-3.2.0/plugins/fontawesome-free/css/all.min.css">
    <!-- AdminLTE -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/AdminLTE-3.2.0/dist/css/adminlte.min.css">

    <style>
        html, body {
            height: 100%;
            margin: 0 !important;
            padding: 0 !important;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background: #f4f7f6;
            color: #444;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin-left: 0 !important;
        }

        /* ── Top Navbar ── */
        .shop-navbar {
            background: linear-gradient(135deg, #302b63, #24243e);
            padding: 0 30px;
            height: 64px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 15px rgba(0,0,0,0.2);
        }
        .shop-navbar .brand {
            color: #fff;
            font-size: 1.5rem;
            font-weight: 700;
            text-decoration: none;
            display: flex; align-items: center; gap: 10px;
        }
        .shop-navbar .brand:hover { color: #c4b5fd; text-decoration: none; }
        .shop-navbar .brand i {
            background: linear-gradient(135deg, #667eea, #764ba2);
            padding: 8px 10px;
            border-radius: 10px;
        }
        .nav-links { display: flex; gap: 15px; align-items: center; }
        .nav-links a {
            color: rgba(255,255,255,0.8);
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            padding: 8px 18px;
            border-radius: 25px;
            transition: all 0.3s;
        }
        .nav-links a:hover, .nav-links a.active {
            background: rgba(255,255,255,0.15);
            color: #fff;
            text-decoration: none;
        }
        
        .user-info-nav {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-left: 20px;
            padding-left: 20px;
            border-left: 1px solid rgba(255,255,255,0.1);
        }
        .user-avatar-mini {
            width: 32px; height: 32px;
            border-radius: 50%;
            background: #667eea;
            color: #fff;
            display: flex; align-items: center; justify-content: center;
            font-size: 0.8rem; font-weight: 600;
        }

        /* ── Main content wrapper ── */
        .site-page-wrapper {
            flex: 1 0 auto;
            margin-left: 0 !important;
            padding-left: 0 !important;
            width: 100% !important;
        }

        /* ── Container ── */
        .history-container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .page-header {
            margin-bottom: 30px;
        }
        .page-header h2 {
            font-weight: 700;
            color: #1e293b;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .page-header h2 i { color: #667eea; }

        /* ── Table Card ── */
        .history-card {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            overflow: hidden;
            border: 1px solid rgba(0,0,0,0.03);
        }

        .table {
            margin-bottom: 0;
        }
        .table thead th {
            background: #f8fafc;
            border-top: none;
            color: #64748b;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
            padding: 20px 25px;
            border-bottom: 2px solid #f1f5f9;
        }
        .table tbody td {
            vertical-align: middle;
            padding: 20px 25px;
            color: #334155;
            font-size: 0.95rem;
            border-bottom: 1px solid #f1f5f9;
        }
        .table tbody tr:last-child td { border-bottom: none; }
        .table tbody tr:hover { background: #fdfdfd; }

        .invoice-code {
            font-family: 'Monaco', 'Consolas', monospace;
            font-weight: 600;
            color: #667eea;
        }
        
        .amount-final {
            font-weight: 700;
            color: #1e293b;
        }

        .badge-status {
            padding: 6px 12px;
            border-radius: 30px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        .status-paid { background: #dcfce7; color: #10b981; }
        .status-unpaid { background: #fee2e2; color: #ef4444; }

        .payment-method {
            font-size: 0.85rem;
            color: #64748b;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .no-history {
            text-align: center;
            padding: 80px 20px;
        }
        .no-history i { font-size: 4rem; color: #e2e8f0; margin-bottom: 20px; }
        .no-history h4 { color: #64748b; font-weight: 600; }

        /* ── Footer ── */
        .footer {
            background: #1e293b;
            color: #fff;
            padding: 40px 20px;
            text-align: center;
            font-size: 0.9rem;
            margin-top: 60px;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="shop-navbar">
        <a href="${pageContext.request.contextPath}/products" class="brand">
            <i class="fas fa-book"></i> BOOKSTORE
        </a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/products">Sản phẩm</a>
            <a href="${pageContext.request.contextPath}/customer-promotions">Khuyến mãi</a>
            <a href="${pageContext.request.contextPath}/customer-history" class="active">Lịch sử mua hàng</a>
            <c:choose>
                <c:when test="${not empty sessionScope.customerId}">
                    <div class="user-info-nav">
                        <a href="${pageContext.request.contextPath}/customer-profile" style="display: flex; align-items: center; gap: 8px; font-weight: 500;">
                            <div class="user-avatar-mini">${not empty sessionScope.fullName ? fn:substring(sessionScope.fullName, 0, 1) : 'U'}</div>
                            ${sessionScope.fullName}
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" title="Đăng xuất"><i class="fas fa-sign-out-alt"></i></a>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn-login-nav">Đăng nhập</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <!-- History Content -->
    <div class="site-page-wrapper">
        <div class="history-container">
            <div class="page-header">
                <h2><i class="fas fa-history"></i> Lịch sử mua hàng</h2>
                <p class="text-muted">Chào mừng trở lại, ${sessionScope.fullName}. Dưới đây là danh sách các hóa đơn của bạn.</p>
            </div>

            <div class="history-card">
                <c:choose>
                    <c:when test="${not empty invoices}">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Mã hóa đơn</th>
                                        <th>Ngày mua</th>
                                        <th class="text-right">Tổng cộng</th>
                                        <th class="text-right">Giảm giá</th>
                                        <th class="text-right">Thành tiền</th>
                                        <th class="text-center">Trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="inv" items="${invoices}">
                                        <tr>
                                            <td><span class="invoice-code">${inv.invoiceCode}</span></td>
                                            <td>
                                                <fmt:formatDate value="${inv.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                            </td>
                                            <td class="text-right"><fmt:formatNumber value="${inv.totalAmount}" type="number" /> đ</td>
                                            <td class="text-right text-danger">-<fmt:formatNumber value="${inv.discountAmount}" type="number" /> đ</td>
                                            <td class="text-right"><span class="amount-final"><fmt:formatNumber value="${inv.finalAmount}" type="number" /> đ</span></td>
                                            <td class="text-center">
                                                <span class="badge-status ${inv.paymentStatus == 'PAID' ? 'status-paid' : 'status-unpaid'}">
                                                    ${inv.paymentStatus == 'PAID' ? 'Đã thanh toán' : 'Chưa thanh toán'}
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-history">
                            <i class="fas fa-shopping-basket"></i>
                            <h4>Bạn chưa có giao dịch nào trong hệ thống.</h4>
                            <p>Hãy khám phá các sản phẩm của chúng tôi và thực hiện đơn hàng đầu tiên nhé!</p>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary mt-3">Mua sắm ngay</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer" style="flex-shrink: 0;">
        <p>&copy; 2026 Bookstore POS System. All rights reserved.</p>
        <p style="opacity: 0.6; font-size: 0.8rem;">Cảm ơn bạn đã tin tưởng mua sắm tại cửa hàng chúng tôi.</p>
    </footer>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/AdminLTE-3.2.0/plugins/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/AdminLTE-3.2.0/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
