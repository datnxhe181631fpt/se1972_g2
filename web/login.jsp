<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng nhập - Bookstore POS</title>

    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/AdminLTE-3.2.0/plugins/fontawesome-free/css/all.min.css">
    <!-- icheck bootstrap -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/AdminLTE-3.2.0/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/AdminLTE-3.2.0/dist/css/adminlte.min.css">
    
    <style>
        .login-page {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .login-box {
            margin-top: 5%;
        }
        .login-logo a {
            color: #fff;
            font-weight: bold;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body class="hold-transition login-page">
<div class="login-box">
    <!-- Logo -->
    <div class="login-logo">
        <a href="<%= request.getContextPath() %>/"><b>Bookstore</b> POS</a>
    </div>
    
    <!-- Card -->
    <div class="card">
        <div class="card-body login-card-body">
            <p class="login-box-msg">Đăng nhập để bắt đầu phiên làm việc</p>

            <!-- Success Message -->
            <c:if test="${param.msg == 'logout_success'}">
                <div class="alert alert-success alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <i class="icon fas fa-check"></i> Đăng xuất thành công!
                </div>
            </c:if>

            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <i class="icon fas fa-ban"></i> ${error}
                </div>
            </c:if>

            <!-- Login Form -->
            <form action="<%= request.getContextPath() %>/login" method="post" id="loginForm">
                <!-- Email -->
                <div class="input-group mb-3">
                    <input type="email" class="form-control" name="email" 
                           placeholder="Email" value="${email}" required autofocus>
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-envelope"></span>
                        </div>
                    </div>
                </div>
                
                <!-- Password -->
                <div class="input-group mb-3">
                    <input type="password" class="form-control" name="password" 
                           placeholder="Mật khẩu" required id="password">
                    <div class="input-group-append">
                        <button class="btn btn-outline-secondary" type="button" id="togglePassword" 
                                style="border-color: #ced4da;">
                            <i class="fas fa-eye" id="toggleIcon"></i>
                        </button>
                    </div>
                </div>
                
                <div class="row">
                    <!-- Submit Button -->
                    <div class="col-6">
                        <button type="submit" class="btn btn-primary btn-block">
                            Đăng nhập
                        </button>
                    </div>
                    
                    <!-- Forgot Password Link -->
                    <div class="col-6 text-right">
                        <a href="<%= request.getContextPath() %>/forgot-password" class="btn btn-link">
                            Quên mật khẩu?
                        </a>
                    </div>
                </div>
            </form>
            
            <!-- Demo Accounts Info -->
            <div class="mt-4 p-3 bg-light rounded"></div>
                <p class="mb-2"><strong><i class="fas fa-info-circle"></i> Tài khoản demo:</strong></p>
                <small class="text-muted">
                    <strong>Admin:</strong> admin@bookstore.com / admin123<br>
                    <strong>Staff:</strong> staff@bookstore.com / staff123
                </small>
            </div>
        </div>
    </div>
</div>

<!-- jQuery -->
<script src="<%= request.getContextPath() %>/AdminLTE-3.2.0/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="<%= request.getContextPath() %>/AdminLTE-3.2.0/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="<%= request.getContextPath() %>/AdminLTE-3.2.0/dist/js/adminlte.min.js"></script>

<script>
// Form validation
$('#loginForm').on('submit', function(e) {
    const email = $('input[name="email"]').val().trim();
    const password = $('input[name="password"]').val();
    
    if (!email) {
        e.preventDefault();
        alert('Vui lòng nhập email!');
        $('input[name="email"]').focus();
        return false;
    }
    
    if (!password) {
        e.preventDefault();
        alert('Vui lòng nhập mật khẩu!');
        $('input[name="password"]').focus();
        return false;
    }
    
    if (password.length < 6) {
        e.preventDefault();
        alert('Mật khẩu phải có ít nhất 6 ký tự!');
        $('input[name="password"]').focus();
        return false;
    }
    
    return true;
});

// Auto hide alerts after 5 seconds
setTimeout(function() {
    $('.alert').fadeOut('slow');
}, 5000);

// Toggle password visibility
$('#togglePassword').on('click', function() {
    const passwordInput = $('#password');
    const toggleIcon = $('#toggleIcon');
    
    if (passwordInput.attr('type') === 'password') {
        passwordInput.attr('type', 'text');
        toggleIcon.removeClass('fa-eye').addClass('fa-eye-slash');
    } else {
        passwordInput.attr('type', 'password');
        toggleIcon.removeClass('fa-eye-slash').addClass('fa-eye');
    }
});
</script>

</body>
</html>
