<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Customer Tier & Loyalty Settings</title>

        <!-- Google Font: Source Sans Pro -->
        <link rel="stylesheet"
              href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <!-- Font Awesome -->
        <link rel="stylesheet"
              href="<%= request.getContextPath() %>/AdminLTE-3.2.0/plugins/fontawesome-free/css/all.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="<%= request.getContextPath() %>/AdminLTE-3.2.0/dist/css/adminlte.min.css">
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
                                <h1><i class="fas fa-trophy"></i> CUSTOMER TIER & LOYALTY SETTINGS</h1>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">

                        <!-- Tier Classification Rules Card -->
                        <div class="card">
                            <div class="card-header bg-light">
                                <h3 class="card-title text-bold text-uppercase" style="margin-top: 5px;">Tier
                                    Classification Rules</h3>
                                <div class="card-tools">
                                    <a href="<%= request.getContextPath() %>/admin/customer-tiers"
                                       class="btn btn-success btn-sm">
                                        <i class="fas fa-plus"></i> Add Tier
                                    </a>
                                </div>
                            </div>

                            <div class="card-body p-0">
                                <table class="table table-bordered table-hover">
                                    <thead class="bg-light">
                                        <tr>
                                            <th>Tier Name</th>
                                            <th>Min Spending</th>
                                            <th>Points Multiplier</th>
                                            <th>Discount %</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty tiers}">
                                                <tr>
                                                    <td colspan="5" class="text-center text-muted py-4">
                                                        No tiers found. Please add a new tier.
                                                    </td>
                                                </tr>
                                            </c:when>

                                            <c:otherwise>
                                                <c:forEach items="${tiers}" var="tier">
                                                    <tr class="${tier.tierID == selectedTier.tierID ? 'table-active' : ''}">
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${tier.tierName eq 'Bronze'}">
                                                                    <span class="badge" style="background-color: #D35400; color: white;">${tier.tierName}</span>
                                                                </c:when>
                                                                <c:when test="${tier.tierName eq 'Silver'}">
                                                                    <span class="badge" style="background-color: #A6ACAF; color: white;">${tier.tierName}</span>
                                                                </c:when>
                                                                <c:when test="${tier.tierName eq 'Gold'}">
                                                                    <span class="badge" style="background-color: #F1C40F; color: black;">${tier.tierName}</span>
                                                                </c:when>
                                                                <c:when test="${tier.tierName eq 'Diamond'}">
                                                                    <span class="badge" style="background-color: #3498DB; color: white;">${tier.tierName}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-info">${tier.tierName}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <fmt:formatNumber value="${tier.minTotalSpent}" type="number" groupingUsed="true"/> ₫
                                                        </td>
                                                        <td>x ${tier.pointRate}</td>
                                                        <td>${tier.discountRate}%</td>
                                                        <td>
                                                            <a href="<%= request.getContextPath() %>/admin/customer-tiers?action=edit&id=${tier.tierID}">Sửa</a>
                                                            <span class="text-muted mx-1">|</span>
                                                            <a href="<%= request.getContextPath() %>/admin/customer-tiers?action=delete&id=${tier.tierID}"
                                                               class="text-danger"
                                                               onclick="return confirm('Bạn có chắc muốn xoá cấp bậc này?');">Xoá</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Selected Tier Details Section -->
                        <div class="card card-light" id="tierDetails">
                            <div class="card-header border-0">
                                <h3 class="card-title text-bold text-uppercase">
                                    <c:choose>
                                        <c:when test="${not empty selectedTier}">
                                            Edit Tier Details: <span class="text-warning text-bold"
                                                                     style="color: #F1C40F !important;">${selectedTier.tierName}</span>
                                        </c:when>
                                        <c:otherwise>
                                            Add New Tier
                                        </c:otherwise>
                                    </c:choose>
                                </h3>
                            </div>
                            <form action="<%= request.getContextPath() %>/admin/customer-tiers" method="post">
                                <input type="hidden" name="action"
                                       value="${not empty selectedTier ? 'update' : 'add'}">
                                <c:if test="${not empty selectedTier}">
                                    <input type="hidden" name="tierID" value="${selectedTier.tierID}">
                                </c:if>

                                <div class="card-body">
                                    <!-- Tier Name -->
                                    <div class="form-group row">
                                        <label for="tierName" class="col-sm-2 col-form-label">Tier Name:</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="tierName"
                                                   name="tierName" value="${selectedTier.tierName}" required>
                                        </div>
                                    </div>

                                    <!-- Requirement -->
                                    <div class="form-group row">
                                        <label for="spendingRequirement"
                                               class="col-sm-2 col-form-label">Requirement:</label>
                                        <div class="col-sm-10 d-flex align-items-center">
                                            <span class="mr-2">Spend</span>
                                            <c:if test="${not empty selectedTier}">
                                                <fmt:formatNumber value="${selectedTier.minTotalSpent}"
                                                                  type="number" groupingUsed="false"
                                                                  var="formattedMinSpent" />
                                            </c:if>
                                            <input type="text" class="form-control" id="spendingRequirement"
                                                   name="minTotalSpent" value="${formattedMinSpent}"
                                                   style="width: 150px;" required>
                                            <span class="ml-2">VND to reach this tier</span>
                                        </div>
                                    </div>

                                    <!-- Points Multiplier -->
                                    <div class="form-group row">
                                        <label for="pointsMultiplier" class="col-sm-2 col-form-label">Points
                                            Multiplier:</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="pointsMultiplier"
                                                   name="pointRate"
                                                   value="${selectedTier.pointRate != null ? selectedTier.pointRate : 1.0}"
                                                   style="width: 150px;" required>
                                        </div>
                                    </div>

                                    <!-- Discount Rate -->
                                    <div class="form-group row">
                                        <label for="discountRate" class="col-sm-2 col-form-label">Discount
                                            Rate:</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="discountRate"
                                                   name="discountRate"
                                                   value="${selectedTier.discountRate != null ? selectedTier.discountRate : 0}"
                                                   style="width: 150px;" required>
                                        </div>
                                    </div>

                                    <!-- Benefits -->
                                    <div class="form-group row">
                                        <label
                                            class="col-sm-2 col-form-label text-uppercase text-danger text-bold">Benefits:</label>
                                        <div class="col-sm-10">
                                            <div class="custom-control custom-checkbox">
                                                <input class="custom-control-input" type="checkbox"
                                                       id="benefit1" checked>
                                                <label for="benefit1"
                                                       class="custom-control-label font-weight-normal">Birthday
                                                    Gift
                                                    (Voucher 50k)</label>
                                            </div>
                                            <div class="custom-control custom-checkbox mt-2">
                                                <input class="custom-control-input" type="checkbox"
                                                       id="benefit2" checked>
                                                <label for="benefit2"
                                                       class="custom-control-label font-weight-normal">Free Book
                                                    Wrapping (Bọc sách miễn phí)</label>
                                            </div>
                                            <div class="custom-control custom-checkbox mt-2">
                                                <input class="custom-control-input" type="checkbox"
                                                       id="benefit3">
                                                <label for="benefit3"
                                                       class="custom-control-label font-weight-normal">Early Access
                                                    to
                                                    New Books (Ưu tiên mua sách mới)</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="card-footer bg-transparent border-top-0 d-flex justify-content-end">
                                    <a href="<%= request.getContextPath() %>/admin/customer-tiers"
                                       class="btn btn-secondary mr-2"
                                       style="background-color: #6c757d; border-color: #6c757d; color: white;">Cancel</a>
                                    <button type="submit" class="btn btn-primary"
                                            style="background-color: #2b6bd8; border-color: #2b6bd8;">SAVE
                                        CHANGES</button>
                                </div>
                            </form>
                        </div>

                    </div>
                </section>
            </div>

            <!-- Footer -->
            <jsp:include page="include/admin-footer.jsp" />

        </div>

        <!-- jQuery -->
        <script src="<%= request.getContextPath() %>/AdminLTE-3.2.0/plugins/jquery/jquery.min.js"></script>
        <!-- Bootstrap 4 -->
        <script
        src="<%= request.getContextPath() %>/AdminLTE-3.2.0/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- AdminLTE App -->
        <script src="<%= request.getContextPath() %>/AdminLTE-3.2.0/dist/js/adminlte.min.js"></script>
    </body>

</html>