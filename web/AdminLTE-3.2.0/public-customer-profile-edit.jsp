<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bookstore - Chỉnh sửa hồ sơ</title>

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
        body {
            font-family: 'Poppins', sans-serif;
            background: #f4f7f6;
            color: #333;
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

        /* ── Edit Card ── */
        .edit-container {
            max-width: 650px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .edit-card {
            background: #fff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
            padding: 40px 45px;
        }

        .edit-header {
            text-align: center;
            margin-bottom: 40px;
        }
        .edit-header h3 {
            font-weight: 700;
            color: #302b63;
        }
        .edit-header p {
            color: #999;
            font-size: 0.9rem;
        }

        .form-group label {
            font-size: 0.85rem;
            color: #302b63;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 10px;
            display: block;
        }

        .form-control {
            border-radius: 12px;
            border: 2px solid #f0f2f5;
            padding: 12px 18px;
            height: auto;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s;
        }
        .form-control:focus {
            border-color: #764ba2;
            box-shadow: 0 0 0 3px rgba(118,75,162,0.1);
            outline: none;
        }

        .btn-save {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: #fff;
            border: none;
            padding: 14px 40px;
            border-radius: 15px;
            font-weight: 600;
            font-size: 1rem;
            box-shadow: 0 10px 25px rgba(118,75,162,0.3);
            transition: all 0.3s;
            cursor: pointer;
            width: 100%;
            margin-top: 20px;
        }
        .btn-save:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 30px rgba(118,75,162,0.4);
            color: #fff;
        }

        .btn-cancel {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #999;
            font-size: 0.9rem;
            text-decoration: none;
            transition: color 0.3s;
        }
        .btn-cancel:hover {
            color: #ff6b6b;
            text-decoration: none;
        }

        .error-message {
             background: #fff5f5;
             color: #c53030;
             padding: 12px 18px;
             border-radius: 12px;
             margin-bottom: 25px;
             font-size: 0.88rem;
             border-left: 4px solid #c53030;
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

<div class="edit-container">
    <div class="edit-card">
        <div class="edit-header">
            <h3>Chỉnh sửa hồ sơ</h3>
            <p>Thay đổi thông tin cá nhân của bạn bên dưới</p>
        </div>

        <c:if test="${not empty error}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/customer-profile-edit" method="post">
            <div class="form-group">
                <label>Họ và tên <span class="text-danger">*</span></label>
                <input type="text" name="fullName" class="form-control" value="${customer.customerName}" placeholder="Nhập họ tên đầy đủ" required>
            </div>
            
            <div class="form-group" style="margin-top:20px;">
                <label>Email</label>
                <input type="email" name="email" class="form-control" value="${customer.email}" placeholder="Nhập email của bạn (ví dụ: name@gmail.com)">
            </div>
            
            <div class="form-group" style="margin-top:20px;">
                <label>Ngày sinh</label>
                <input type="date" name="birthday" class="form-control" value="${customer.birthday}">
            </div>

            <div class="form-group" style="margin-top:20px;">
                <label>Số điện thoại (ID)</label>
                <input type="text" class="form-control" value="${customer.phoneNumber}" disabled style="background: #f9f9f9; cursor: not-allowed; color: #aaa; border: 2px solid #eee;">
            </div>

            <button type="submit" class="btn-save">
                <i class="fas fa-save"></i> Lưu thay đổi
            </button>
            <a href="${pageContext.request.contextPath}/customer-profile" class="btn-cancel">Hủy bỏ</a>
        </form>
    </div>
</div>

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/AdminLTE-3.2.0/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="${pageContext.request.contextPath}/AdminLTE-3.2.0/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>
