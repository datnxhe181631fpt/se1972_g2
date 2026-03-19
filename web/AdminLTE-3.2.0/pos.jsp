<%-- 
    Main POS screen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Bán hàng (POS)</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/AdminLTE-3.2.0/dist/css/adminlte.min.css">
        <style>
            body.dark-pos {
                background-color: #f8fafc;
                color: #1e293b;
            }

            .pos-search-bar {
                background: white;
                border-radius: 999px;
                padding: 8px 16px;
                display: flex;
                align-items: center;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
                border: 1px solid #e2e8f0;
            }

            .pos-search-bar i {
                color: #64748b;
                margin-right: 8px;
            }

            .pos-search-bar input {
                background: transparent;
                border: none;
                color: #1e293b;
                width: 100%;
                outline: none;
            }

            .pos-products-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
                gap: 16px;
            }

            .pos-product-card {
                background: white;
                border-radius: 12px;
                padding: 16px;
                border: 1px solid #e2e8f0;
                transition: all 0.2s ease;
                display: flex;
                flex-direction: column;
                height: 100%;
                text-align: left;
                width: 100%;
            }

            .pos-product-card:hover {
                transform: translateY(-2px);
                border-color: #3b82f6;
                box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            }

            .pos-product-name {
                font-size: 15px;
                font-weight: 600;
                color: #1e293b;
                margin-bottom: 4px;
                height: 45px;
                overflow: hidden;
            }

            .pos-product-price {
                font-weight: 700;
                color: #2563eb;
                font-size: 16px;
            }

            .pos-order-panel {
                background: white;
                border-radius: 12px;
                border: 1px solid #e2e8f0;
                padding: 20px;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
                position: sticky;
                top: 20px;
            }

            .pos-order-summary-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 8px;
                font-size: 14px;
            }

            .pos-total-amount {
                font-size: 24px;
                font-weight: 800;
                color: #1e293b;
            }

            .pos-pay-btn {
                width: 100%;
                border-radius: 8px;
                padding: 12px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .pos-payment-option {
                flex: 1;
                padding: 12px;
                border-radius: 8px;
                border: 2px solid #e2e8f0;
                background: #f8fafc;
                cursor: pointer;
                text-align: center;
                transition: all 0.2s;
            }

            .pos-payment-option.active {
                border-color: #3b82f6;
                background: #eff6ff;
                color: #2563eb;
            }

            .pos-payment-option input {
                display: none;
            }

            /* Pagination styling */
            .pagination .page-link {
                color: #475569;
                border-radius: 6px;
                margin: 0 2px;
            }
            .pagination .page-item.active .page-link {
                background-color: #3b82f6;
                border-color: #3b82f6;
            }

            .pos-sidebar-toggle {
                display: none;
            }
            
            @media (max-width: 991.98px) {
                .pos-sidebar-toggle {
                    display: block;
                }
            }
        </style>
    </head>
    <body class="hold-transition">
        <div class="wrapper">
            <!-- Content Wrapper -->
            <div class="content-wrapper" style="margin-left: 0; background: #f8fafc;">
                <section class="content-header">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col-sm-6 d-flex align-items-center">
                                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-link text-dark p-0 mr-3">
                                    <i class="fas fa-arrow-left"></i>
                                </a>
                                <h1 class="m-0 font-weight-bold">Hệ thống Bán hàng (POS)</h1>
                            </div>
                            <div class="col-sm-6 text-right">
                                <span class="badge badge-info p-2">
                                    <i class="fas fa-user-tie mr-1"></i> Nhân viên: Cashier
                                </span>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <!-- Left: Products -->
                            <div class="col-lg-8">
                                <!-- Messages -->
                                <c:if test="${not empty msg}">
                                    <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm">
                                        <i class="fas fa-check-circle mr-2"></i> ${msg}
                                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                                    </div>
                                </c:if>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm">
                                        <i class="fas fa-exclamation-triangle mr-2"></i> ${error}
                                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                                    </div>
                                </c:if>

                                <div class="card border-0 shadow-sm mb-4" style="border-radius: 12px;">
                                    <div class="card-body">
                                        <div class="row mb-4">
                                            <div class="col-md-7">
                                                <form action="<c:url value='/pos'/>" method="get">
                                                    <div class="pos-search-bar">
                                                        <i class="fas fa-search"></i>
                                                        <input type="text" name="key" value="${searchKey}" placeholder="Tìm theo tên sản phẩm hoặc SKU..." autocomplete="off">
                                                    </div>
                                                </form>
                                            </div>
                                            <div class="col-md-5">
                                                <form id="pos-category-form" action="<c:url value='/pos'/>" method="get">
                                                    <input type="hidden" name="key" value="${searchKey}">
                                                    <select name="categoryId" class="form-control" style="border-radius: 999px;" onchange="this.form.submit()">
                                                        <option value="">Tất cả danh mục</option>
                                                        <c:forEach var="cat" items="${categories}">
                                                            <option value="${cat.categoryID}" ${selectedCategoryId == cat.categoryID ? 'selected' : ''}>${cat.categoryName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </form>
                                            </div>
                                        </div>

                                        <div class="row mb-4">
                                            <div class="col-12">
                                                <form action="<c:url value='/pos'/>" method="post" class="form-inline">
                                                    <input type="hidden" name="action" value="addItem">
                                                    <div class="input-group input-group-sm mr-2" style="width: 250px;">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text bg-white border-right-0" style="border-radius: 8px 0 0 8px;"><i class="fas fa-barcode"></i></span>
                                                        </div>
                                                        <input type="text" id="sku" name="sku" class="form-control border-left-0" placeholder="Quét hoặc nhập SKU" style="border-radius: 0 8px 8px 0;" autofocus>
                                                    </div>
                                                    <input type="number" name="quantity" value="1" min="1" class="form-control form-control-sm mr-2" style="width: 60px; border-radius: 8px;">
                                                    <button type="submit" class="btn btn-sm btn-primary" style="border-radius: 8px;">
                                                        <i class="fas fa-plus mr-1"></i> Thêm
                                                    </button>
                                                </form>
                                            </div>
                                        </div>

                                        <div class="pos-products-grid">
                                            <c:forEach var="p" items="${products}">
                                                <form action="<c:url value='/pos'/>" method="post">
                                                    <input type="hidden" name="action" value="addItem">
                                                    <input type="hidden" name="sku" value="${p.sku}">
                                                    <input type="hidden" name="quantity" value="1">
                                                    <button type="submit" class="pos-product-card">
                                                        <div class="mb-2 text-right">
                                                            <span class="badge ${p.stock > 10 ? 'badge-success' : 'badge-warning'}">Tồn: ${p.stock}</span>
                                                        </div>
                                                        <div class="pos-product-name">${p.productName}</div>
                                                        <div class="text-muted small mb-2">SKU: ${p.sku}</div>
                                                        <div class="mt-auto d-flex justify-content-between align-items-center">
                                                            <div class="pos-product-price">
                                                                <fmt:formatNumber value="${p.sellingPrice}" type="number" maxFractionDigits="0"/>đ
                                                            </div>
                                                            <div class="text-primary"><i class="fas fa-cart-plus fa-lg"></i></div>
                                                        </div>
                                                    </button>
                                                </form>
                                            </c:forEach>
                                        </div>

                                        <c:if test="${totalPages > 1}">
                                            <nav aria-label="Pagination" class="mt-4">
                                                <ul class="pagination pagination-sm justify-content-center">
                                                    <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                                                        <a class="page-link" href="?page=${currentPage-1}&key=${searchKey}&categoryId=${selectedCategoryId}"><i class="fas fa-chevron-left"></i></a>
                                                    </li>
                                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                            <a class="page-link" href="?page=${i}&key=${searchKey}&categoryId=${selectedCategoryId}">${i}</a>
                                                        </li>
                                                    </c:forEach>
                                                    <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                                        <a class="page-link" href="?page=${currentPage+1}&key=${searchKey}&categoryId=${selectedCategoryId}"><i class="fas fa-chevron-right"></i></a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </c:if>
                                    </div>
                                </div>
                            </div>

                            <!-- Right: Order & Payment -->
                            <div class="col-lg-4">
                                <div class="pos-order-panel">
                                    <h4 class="font-weight-bold mb-4">Chi tiết đơn hàng</h4>
                                    
                                    <div class="mb-4" style="max-height: 300px; overflow-y: auto;">
                                        <c:forEach var="item" items="${cart}">
                                            <div class="d-flex justify-content-between align-items-center mb-3 pb-3 border-bottom">
                                                <div style="flex: 1;">
                                                    <div class="font-weight-bold text-truncate" style="max-width: 151px;">${item.product.productName}</div>
                                                    <div class="text-muted small">
                                                        <fmt:formatNumber value="${item.unitPrice}" type="number" maxFractionDigits="0"/>đ x ${item.quantity}
                                                    </div>
                                                </div>
                                                <div class="d-flex align-items-center">
                                                    <form action="<c:url value='/pos'/>" method="post" class="mr-2">
                                                        <input type="hidden" name="action" value="updateQty">
                                                        <input type="hidden" name="productId" value="${item.product.productID}">
                                                        <input type="number" name="quantity" value="${item.quantity}" min="1" class="form-control form-control-sm" style="width: 50px;" onchange="this.form.submit()">
                                                    </form>
                                                    <form action="<c:url value='/pos'/>" method="post">
                                                        <input type="hidden" name="action" value="removeItem">
                                                        <input type="hidden" name="productId" value="${item.product.productID}">
                                                        <button type="submit" class="btn btn-link text-danger p-0"><i class="fas fa-trash"></i></button>
                                                    </form>
                                                </div>
                                                <div class="text-right font-weight-bold ml-2" style="min-width: 80px;">
                                                    <fmt:formatNumber value="${item.lineTotal}" type="number" maxFractionDigits="0"/>đ
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <c:if test="${empty cart}">
                                            <div class="text-center py-5 text-muted">
                                                <i class="fas fa-shopping-cart fa-3x mb-3 opacity-25"></i>
                                                <p>Chưa có sản phẩm nào</p>
                                            </div>
                                        </c:if>
                                    </div>

                                    <div class="bg-gray-50 p-3 rounded-lg border mb-4">
                                        <div class="pos-order-summary-row">
                                            <span>Tạm tính</span>
                                            <span id="js-subtotal" class="font-weight-bold text-dark"><fmt:formatNumber value="${totalAmount}" type="number" maxFractionDigits="0"/> đ</span>
                                        </div>
                                        <div class="pos-order-summary-row text-success">
                                            <span>Khuyến mãi (Tự động)</span>
                                            <span id="js-auto-discount" class="font-weight-bold">- <fmt:formatNumber value="${autoPromoDiscount}" type="number" maxFractionDigits="0"/> đ</span>
                                        </div>
                                        <div class="pos-order-summary-row text-primary">
                                            <span>Giảm thêm (<span id="js-manual-percent">0</span>%)</span>
                                            <span id="js-manual-discount" class="font-weight-bold">0 đ</span>
                                        </div>
                                        <div class="pos-order-summary-row">
                                            <span>VAT (0%/5%)</span>
                                            <span class="font-weight-bold"><fmt:formatNumber value="${vatAmount}" type="number" maxFractionDigits="0"/> đ</span>
                                        </div>
                                        <hr>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span class="font-weight-bold">TỔNG CỘNG</span>
                                            <span class="pos-total-amount" id="js-final-amount">
                                                <fmt:formatNumber value="${totalAmount - autoPromoDiscount + vatAmount}" type="number" maxFractionDigits="0"/> đ
                                            </span>
                                        </div>
                                    </div>

                                    <form id="checkout-form" action="<c:url value='/pos'/>" method="post">
                                        <input type="hidden" name="action" value="checkout">
                                        
                                        <div class="form-group mb-3">
                                            <label class="small font-weight-bold text-uppercase text-muted">Giảm giá thêm (%)</label>
                                            <input type="number" id="pos-discount" name="discountPercent" min="0" max="100" step="0.5" value="0" class="form-control" placeholder="0">
                                        </div>

                                        <div class="form-group mb-4">
                                            <label class="small font-weight-bold text-uppercase text-muted">Phương thức thanh toán</label>
                                            <div class="d-flex" style="gap: 12px;">
                                                <label class="pos-payment-option active" id="label-cash">
                                                    <input type="radio" name="paymentMethod" value="CASH" checked onchange="togglePayment(this)">
                                                    <i class="fas fa-money-bill-wave d-block mb-1"></i>
                                                    Tiền mặt
                                                </label>
                                                <label class="pos-payment-option" id="label-transfer">
                                                    <input type="radio" name="paymentMethod" value="TRANSFER" onchange="togglePayment(this)">
                                                    <i class="fas fa-credit-card d-block mb-1"></i>
                                                    Chuyển khoản
                                                </label>
                                            </div>
                                        </div>

                                        <div id="cash-section">
                                            <div class="form-group mb-3">
                                                <label class="small font-weight-bold text-uppercase text-muted">Tiền khách đưa</label>
                                                <div class="input-group">
                                                    <input type="number" id="pos-cash" name="cashReceived" class="form-control form-control-lg font-weight-bold" placeholder="0">
                                                    <div class="input-group-append"><span class="input-group-text">đ</span></div>
                                                </div>
                                            </div>
                                            <div class="d-flex justify-content-between align-items-center mb-4 p-2 bg-light rounded">
                                                <span class="text-muted">Tiền thừa trả khách:</span>
                                                <span id="js-change-amount" class="h5 m-0 font-weight-bold text-success">0 đ</span>
                                            </div>
                                        </div>

                                        <div class="form-group mb-3">
                                            <label class="small font-weight-bold text-uppercase text-muted">Số điện thoại (ID Khách hàng)</label>
                                            <input type="text" name="customerId" class="form-control" placeholder="Nhập SĐT khách hàng">
                                        </div>
                                        
                                        <div class="form-group mb-3">
                                            <label class="small font-weight-bold text-uppercase text-muted">Tên khách hàng (Nếu khách mới)</label>
                                            <input type="text" name="customerName" class="form-control" placeholder="Nguyễn Văn A">
                                        </div>

                                        <div class="form-group mb-4">
                                            <label class="small font-weight-bold text-uppercase text-muted">Ghi chú</label>
                                            <textarea name="note" rows="2" class="form-control" placeholder="Ghi chú đơn hàng..."></textarea>
                                        </div>

                                        <div class="row no-gutters">
                                            <div class="col-4 pr-2">
                                                <button type="button" class="btn btn-outline-secondary btn-block py-3" onclick="location.href='?action=clearCart'" ${empty cart ? 'disabled' : ''}>Hủy</button>
                                            </div>
                                            <div class="col-8">
                                                <button type="submit" class="btn btn-primary pos-pay-btn" ${empty cart ? 'disabled' : ''}>Xác nhận thanh toán</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/AdminLTE-3.2.0/plugins/jquery/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/AdminLTE-3.2.0/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        
        <!-- Hidden values for calculation -->
        <input type="hidden" id="raw-subtotal" value="${totalAmount}">
        <input type="hidden" id="raw-auto-discount" value="${autoPromoDiscount}">
        <input type="hidden" id="raw-vat" value="${vatAmount}">

        <script>
            function updateSummary() {
                var subtotal = parseFloat($('#raw-subtotal').val()) || 0;
                var autoDiscount = parseFloat($('#raw-auto-discount').val()) || 0;
                var vat = parseFloat($('#raw-vat').val()) || 0;
                
                var manualPct = parseFloat($('#pos-discount').val()) || 0;
                if (manualPct < 0) manualPct = 0;
                if (manualPct > 100) manualPct = 100;
                
                var manualDiscount = subtotal * manualPct / 100;
                var finalAmount = subtotal - autoDiscount - manualDiscount + vat;
                if (finalAmount < 0) finalAmount = 0;
                
                $('#js-manual-percent').text(manualPct);
                $('#js-manual-discount').text('- ' + manualDiscount.toLocaleString('vi-VN') + ' đ');
                $('#js-final-amount').text(finalAmount.toLocaleString('vi-VN') + ' đ');
                
                var cash = parseFloat($('#pos-cash').val()) || 0;
                var change = cash - finalAmount;
                if (change < 0) change = 0;
                $('#js-change-amount').text(change.toLocaleString('vi-VN') + ' đ');
            }

            function togglePayment(radio) {
                $('.pos-payment-option').removeClass('active');
                $(radio).closest('.pos-payment-option').addClass('active');
                if (radio.value === 'TRANSFER') {
                    $('#cash-section').slideUp();
                } else {
                    $('#cash-section').slideDown();
                }
            }

            $(document).ready(function() {
                $('#pos-discount, #pos-cash').on('input change', updateSummary);
                $('#sku').focus();
            });
        </script>
    </body>
</html>
