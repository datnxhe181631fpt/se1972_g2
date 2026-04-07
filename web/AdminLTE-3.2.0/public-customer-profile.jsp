<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bookstore - Hồ sơ cá nhân</title>

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
            color: #333;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin-left: 0 !important;
        }

        /* ── Navbar ── */
        .shop-navbar {
            background: linear-gradient(135deg, #302b63, #24243e);
            padding: 0 30px;
            height: 64px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky; top: 0; z-index: 1000;
            box-shadow: 0 2px 15px rgba(0,0,0,0.2);
        }
        .shop-navbar .brand {
            color: #fff; font-size: 1.5rem; font-weight: 700; text-decoration: none;
            display: flex; align-items: center; gap: 10px;
        }
        .shop-navbar .brand i {
            background: linear-gradient(135deg, #667eea, #764ba2);
            padding: 8px 10px; border-radius: 10px;
        }
        .nav-links { display: flex; gap: 15px; align-items: center; }
        .nav-links a {
            color: rgba(255,255,255,0.8); text-decoration: none;
            font-size: 0.9rem; font-weight: 500; padding: 8px 18px;
            border-radius: 25px; transition: all 0.3s;
        }
        .nav-links a:hover { background: rgba(255,255,255,0.15); color: #fff; }
        .nav-links .btn-login-nav {
            background: linear-gradient(135deg, #667eea, #764ba2); color: #fff;
        }

        /* ── Profile Card ── */
        .profile-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .profile-card {
            background: #fff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
            display: flex;
            flex-wrap: wrap;
        }

        .profile-sidebar {
            width: 320px;
            background: linear-gradient(180deg, #302b63, #24243e);
            color: #fff;
            padding: 40px 30px;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .profile-avatar {
            width: 140px;
            height: 140px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 25px;
            border: 4px solid rgba(255,255,255,0.15);
            font-size: 4rem;
        }

        .profile-sidebar h3 {
            font-size: 1.4rem;
            font-weight: 600;
            margin-bottom: 5px;
            color: #fff;
        }

        .profile-sidebar .badge-tier {
            background: linear-gradient(135deg, #667eea, #764ba2);
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        .profile-stats {
            width: 100%;
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
            padding-top: 25px;
            border-top: 1px solid rgba(255,255,255,0.1);
        }
        .stat-item {
            text-align: center;
        }
        .stat-item .val {
            display: block;
            font-size: 1.2rem;
            font-weight: 700;
        }
        .stat-item .lbl {
            font-size: 0.75rem;
            color: rgba(255,255,255,0.6);
            text-transform: uppercase;
        }

        .profile-content {
            flex: 1;
            padding: 40px 50px;
            background: #fff;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
        }
        .section-header h4 {
            font-weight: 700;
            color: #302b63;
            margin: 0;
            position: relative;
        }
        .section-header h4:after {
            content: '';
            position: absolute;
            bottom: -8px; left: 0;
            width: 40px; height: 3px;
            background: #764ba2;
            border-radius: 2px;
        }

        .btn-edit {
            background: #f0f2f5;
            color: #764ba2;
            padding: 8px 20px;
            border-radius: 12px;
            font-size: 0.88rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
        }
        .btn-edit:hover {
            background: #764ba2;
            color: #fff;
            text-decoration: none;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
        }

        .info-item label {
            display: block;
            font-size: 0.8rem;
            color: #999;
            margin-bottom: 5px;
            text-transform: uppercase;
            font-weight: 600;
        }
        .info-item span {
            font-size: 1rem;
            font-weight: 500;
            color: #333;
        }

        @media (max-width: 768px) {
            .profile-card { flex-direction: column; }
            .profile-sidebar { width: 100%; padding: 40px 20px; }
            .profile-content { padding: 40px 30px; }
            .info-grid { grid-template-columns: 1fr; }
        }

        /* ── Password Card ── */
        .password-card {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
            margin-top: 30px;
            padding: 40px 50px;
        }
        .form-group label {
            font-weight: 600;
            color: #302b63;
        }
        .form-control {
            border-radius: 12px;
            padding: 12px 15px;
            border: 1px solid #e0e0e0;
            transition: all 0.3s;
        }
        .form-control:focus {
            border-color: #764ba2;
            box-shadow: 0 0 0 3px rgba(118, 75, 162, 0.1);
        }
        .btn-save-pw {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: #fff;
            border: none;
            padding: 12px 30px;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s;
            cursor: pointer;
        }
        .btn-save-pw:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(118, 75, 162, 0.3);
            color: #fff;
        }
    </style>
</head>
<body>

<nav class="shop-navbar">
    <a href="${pageContext.request.contextPath}/home" class="brand">
        <i class="fas fa-book-open"></i> Bookstore
    </a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/products">
            <i class="fas fa-shopping-bag"></i> Sản phẩm
        </a>
        <a href="${pageContext.request.contextPath}/customer-promotions">
            <i class="fas fa-ticket-alt"></i> Khuyến mãi
        </a>
        <a href="${pageContext.request.contextPath}/customer-history">
            <i class="fas fa-history"></i> Lịch sử mua hàng
        </a>
        <c:choose>
            <c:when test="${not empty sessionScope.customer}">
                <a href="${pageContext.request.contextPath}/customer-profile" class="btn-login-nav">
                    <i class="fas fa-user-circle"></i> ${sessionScope.customer.customerName}
                </a>
                <a href="${pageContext.request.contextPath}/logout" style="color: #ff6b6b;"><i class="fas fa-sign-out-alt"></i></a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login" class="btn-login-nav">
                    <i class="fas fa-sign-in-alt"></i> Đăng nhập
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>

<div class="profile-container">
    <c:if test="${param.success == 1}">
        <div class="alert alert-success alert-dismissible fade show" role="alert" style="border-radius: 12px; border: none; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
            <i class="fas fa-check-circle"></i> Cập nhật hồ sơ thành công!
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <div class="profile-card">
        <div class="profile-sidebar">
            <div class="profile-avatar">
                <i class="fas fa-user"></i>
            </div>
            <h3>${customer.customerName}</h3>
            <span class="badge-tier">
                <i class="fas fa-medal"></i> ${not empty customer.tierName ? customer.tierName : 'Thành viên'}
            </span>
            
            <div class="profile-stats">
                <div class="stat-item">
                    <span class="val">${customer.points}</span>
                    <span class="lbl">Điểm thưởng</span>
                </div>
            </div>
        </div>

        <div class="profile-content">
            <div class="section-header">
                <h4>Thông tin cá nhân</h4>
                <a href="${pageContext.request.contextPath}/customer-profile-edit" class="btn-edit">
                    <i class="fas fa-edit"></i> Chỉnh sửa
                </a>
            </div>

            <div class="info-grid">
                <div class="info-item">
                    <label>Họ và tên</label>
                    <span>${customer.customerName}</span>
                </div>
                <div class="info-item">
                    <label>Số điện thoại</label>
                    <span>${customer.phoneNumber}</span>
                </div>
                <div class="info-item">
                    <label>Email</label>
                    <span>${not empty customer.email ? customer.email : 'Chưa cập nhật'}</span>
                </div>
                <div class="info-item">
                    <label>Ngày sinh</label>
                    <span>
                        <c:choose>
                            <c:when test="${not empty customer.birthday}">
                                ${customer.birthday}
                            </c:when>
                            <c:otherwise>
                                Chưa cập nhật
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="info-item">
                    <label>Ngày đăng ký</label>
                    <span>
                        <fmt:parseDate value="${customer.registerDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                    </span>
                </div>
                <div class="info-item">
                    <label>Trạng thái</label>
                    <span>
                        <span class="badge ${customer.status == 'ACTIVE' ? 'badge-success' : 'badge-secondary'}" style="border-radius: 12px; font-weight: 500; font-size: 0.75rem;">
                            ${customer.status == 'ACTIVE' ? 'Hoạt động' : 'Đang xử lý'}
                        </span>
                    </span>
                </div>
            </div>
        </div>
    </div>

    <!-- Password Change Section -->
    <div class="password-card">
        <div class="section-header">
            <h4>Đổi mật khẩu</h4>
        </div>

        <c:if test="${not empty sessionScope.passwordError}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert" style="border-radius: 12px; border: none;">
                <i class="fas fa-exclamation-circle"></i> ${sessionScope.passwordError}
                <c:remove var="passwordError" scope="session" />
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
        <c:if test="${not empty sessionScope.passwordSuccess}">
            <div class="alert alert-success alert-dismissible fade show" role="alert" style="border-radius: 12px; border: none;">
                <i class="fas fa-check-circle"></i> ${sessionScope.passwordSuccess}
                <c:remove var="passwordSuccess" scope="session" />
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/customer-change-password" method="POST">
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="oldPassword">Mật khẩu hiện tại</label>
                        <input type="password" name="oldPassword" id="oldPassword" class="form-control" required placeholder="Nhập mật khẩu cũ">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="newPassword">Mật khẩu mới</label>
                        <input type="password" name="newPassword" id="newPassword" class="form-control" required placeholder="Nhập mật khẩu mới">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="confirmPassword">Xác nhận mật khẩu mới</label>
                        <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" required placeholder="Nhập lại mật khẩu mới">
                    </div>
                </div>
            </div>
            <div class="mt-3">
                <button type="submit" class="btn-save-pw">
                    <i class="fas fa-key"></i> Cập nhật mật khẩu
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Footer -->
<footer class="footer" style="background: #1e293b; color: #fff; padding: 40px 20px; text-align: center; font-size: 0.9rem; flex-shrink: 0; margin-top: auto;">
    <p>&copy; 2026 Bookstore POS System. All rights reserved.</p>
    <p style="opacity: 0.6; font-size: 0.8rem;">Cảm ơn bạn đã tin tưởng mua sắm tại cửa hàng chúng tôi.</p>
</footer>

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/AdminLTE-3.2.0/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="${pageContext.request.contextPath}/AdminLTE-3.2.0/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>
