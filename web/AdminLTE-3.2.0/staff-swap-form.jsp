<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Gửi Đơn Đổi Ca</title>

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/AdminLTE-3.2.0/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/AdminLTE-3.2.0/dist/css/adminlte.min.css">
</head>

<body class="hold-transition sidebar-mini">
<div class="wrapper">

    <jsp:include page="include/admin-header.jsp"/>
    <jsp:include page="include/admin-sidebar.jsp"/>

    <div class="content-wrapper">

        <!-- HEADER -->
        <section class="content-header">
            <div class="container-fluid">
                <h1><i class="fas fa-exchange-alt"></i> Gửi Đơn Đổi Ca</h1>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">

                <!-- SUCCESS -->
                <c:if test="${param.success == 'true'}">
                    <div class="alert alert-success alert-dismissible fade show">
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                        Gửi đơn đổi ca thành công!
                    </div>
                </c:if>

                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">Thông tin đổi ca</h3>
                    </div>

                    <form method="post"
                          action="${pageContext.request.contextPath}/staff/swap">

                        <div class="card-body">

                            <!-- NGƯỜI MUỐN ĐỔI -->
                            <h5 class="text-primary">Người muốn đổi ca</h5>

                            <div class="form-group">
                                <label>Tên nhân viên</label>
                                <select name="fromEmployeeID" class="form-control" required>
                                    <c:forEach items="${employeeList}" var="e">
                                        <option value="${e.employeeId}">
                                            ${e.fullName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Ca làm</label>
                                <select name="fromAssignmentID" class="form-control" required>
                                    <c:forEach items="${assignmentList}" var="a">
                                        <option value="${a.assignmentID}">
                                            ${a.shiftName} - ${a.workDate}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <hr>

                            <!-- NGƯỜI ĐƯỢC ĐỔI -->
                            <h5 class="text-success">Người được đổi</h5>

                            <div class="form-group">
                                <label>Tên nhân viên</label>
                                <select name="toEmployeeID" class="form-control" required>
                                    <c:forEach items="${employeeList}" var="e">
                                        <option value="${e.employeeId}">
                                            ${e.fullName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Ca làm</label>
                                <select name="toAssignmentID" class="form-control" required>
                                    <c:forEach items="${assignmentList}" var="a">
                                        <option value="${a.assignmentID}">
                                            ${a.shiftName} - ${a.workDate}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <hr>

                            <!-- LÝ DO -->
                            <div class="form-group">
                                <label>Lý do đổi ca</label>
                                <textarea name="reason"
                                          class="form-control"
                                          rows="4"
                                          required></textarea>
                            </div>

                        </div>

                        <div class="card-footer">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-paper-plane"></i> Gửi đơn
                            </button>
                        </div>

                    </form>
                </div>

            </div>
        </section>

    </div>

    <jsp:include page="include/admin-footer.jsp"/>
</div>
</body>
</html>