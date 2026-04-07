<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Ưu đãi & Khuyến mãi - Bookstore</title>

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

        /* ── Header ── */
        .promo-header {
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            padding: 80px 20px;
            text-align: center;
            color: #fff;
            margin-bottom: 40px;
        }
        .promo-header h1 { font-weight: 700; font-size: 3rem; margin-bottom: 10px; }
        .promo-header p { font-size: 1.1rem; opacity: 0.9; }

        /* ── Promotion Cards ── */
        .promo-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px 60px;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(420px, 1fr));
            gap: 30px;
        }

        .promo-card {
            background: #fff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            border: 1px solid rgba(0,0,0,0.03);
            display: flex;
            flex-direction: column;
        }
        .promo-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }

        .promo-type-badge {
            position: absolute;
            top: 20px;
            left: 20px;
            padding: 6px 16px;
            border-radius: 30px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            z-index: 2;
        }
        .type-discount { background: #fee2e2; color: #ef4444; }
        .type-gift { background: #dcfce7; color: #10b981; }

        .promo-card-content {
            padding: 30px;
            padding-top: 55px; /* Thêm khoảng trống để không bị đè bởi badge */
            flex-grow: 1;
        }
        .promo-name {
            font-size: 1.25rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 15px;
            line-height: 1.4;
        }
        
        .promo-meta {
            margin-bottom: 25px;
            font-size: 0.9rem;
            color: #64748b;
        }
        .promo-meta div {
            display: flex; align-items: center; gap: 10px; margin-bottom: 8px;
        }
        .promo-meta i { width: 16px; color: #94a3b8; }

        .promo-code-box {
            background: #f8fafc;
            border: 2px dashed #cbd5e1;
            padding: 15px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: auto;
        }
        .promo-code {
            font-family: 'Monaco', 'Consolas', monospace;
            font-weight: 700;
            font-size: 1.1rem;
            color: #334155;
            letter-spacing: 1px;
        }
        .btn-copy {
            background: #fff;
            border: 1px solid #e2e8f0;
            width: 36px; height: 36px;
            border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
            color: #64748b;
        }
        .btn-copy:hover {
            background: #667eea;
            border-color: #667eea;
            color: #fff;
        }

        .no-data {
            grid-column: 1 / -1;
            padding: 100px 20px;
            text-align: center;
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }
        .no-data i { font-size: 4rem; color: #e2e8f0; margin-bottom: 20px; }
        .no-data h3 { color: #64748b; font-weight: 600; }

        /* ── Footer ── */
        .footer {
            background: #1e293b;
            color: #fff;
            padding: 40px 20px;
            text-align: center;
            font-size: 0.9rem;
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
            <a href="${pageContext.request.contextPath}/customer-history">Lịch sử mua hàng</a>
            <c:choose>
                <c:when test="${not empty sessionScope.customerId}">
                    <div class="user-info-nav">
                        <a href="${pageContext.request.contextPath}/customer-profile" style="display: flex; align-items: center; gap: 8px; font-weight: 500;">
                            <div class="user-avatar-mini">${fn:substring(sessionScope.fullName, 0, 1)}</div>
                            ${sessionScope.fullName}
                        </a>
                        <a href="${pageContext.request.contextPath}/login" title="Đăng xuất"><i class="fas fa-sign-out-alt"></i></a>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn-login-nav">Đăng nhập</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <!-- Main Wrapper -->
    <div class="site-page-wrapper">
        <!-- Header -->
        <div class="promo-header">
            <div class="container animate__animated animate__fadeIn">
                <h1>Ưu đãi dành cho bạn</h1>
                <p>Khám phá các chương trình khuyến mãi đặc biệt dựa trên hạng thành viên <strong>${customer.tierName}</strong></p>
            </div>
        </div>

        <!-- Main Content -->
        <div class="promo-container">
            <c:choose>
                <c:when test="${not empty promotions}">
                    <c:forEach var="p" items="${promotions}">
                        <div class="promo-card">
                            <span class="promo-type-badge ${p.promotionType == 'DISCOUNT' ? 'type-discount' : 'type-gift'}">
                                ${p.promotionType == 'DISCOUNT' ? 'Giảm giá' : 'Tặng quả'}
                            </span>
                            
                            <div class="promo-card-content">
                                <h2 class="promo-name">${p.promotionName}</h2>
                                
                                <div class="promo-meta">
                                    <div>
                                        <i class="far fa-calendar-alt"></i>
                                        Hiệu lực: <fmt:parseDate value="${p.startDate}" pattern="yyyy-MM-dd" var="sDate" />
                                                  <fmt:formatDate value="${sDate}" pattern="dd/MM/yyyy" /> 
                                                  đến 
                                                  <fmt:parseDate value="${p.endDate}" pattern="yyyy-MM-dd" var="eDate" />
                                                  <fmt:formatDate value="${eDate}" pattern="dd/MM/yyyy" />
                                    </div>
                                </div>

                                <div class="promo-code-box">
                                    <span class="promo-code" id="code-${p.promotionID}">${p.promotionCode}</span>
                                    <button class="btn-copy" onclick="copyCode('code-${p.promotionID}')" title="Sao chép mã">
                                        <i class="far fa-copy"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-data">
                        <i class="fas fa-ticket-alt"></i>
                        <h3>Hiện tại không có mã giảm giá nào phù hợp với hạng thẻ của bạn.</h3>
                        <p>Hãy tiếp tục tích lũy điểm để nhận được nhiều ưu đãi hơn nhé!</p>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary mt-3">Mua sắm ngay</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer" style="flex-shrink: 0;">
        <p>&copy; 2026 Bookstore POS System. All rights reserved.</p>
        <p style="opacity: 0.6; font-size: 0.8rem;">Hệ thống quản lý khách hàng & Khuyến mãi thân thiết</p>
    </footer>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/AdminLTE-3.2.0/plugins/jquery/jquery.min.js"></script>
    <script>
        function copyCode(id) {
            const codeText = document.getElementById(id).innerText;
            navigator.clipboard.writeText(codeText).then(() => {
                alert('Đã sao chép mã: ' + codeText);
            });
        }
    </script>
</body>
</html>
