<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:url value="/" var="URL"></c:url>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>CarePlus4 - Quản lý người dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body>
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Quản lý người dùng</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin/">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/users">Quản lý người dùng</a></li>
                    <li class="breadcrumb-item active">Chi tiết "${userGet.name}"</li>
                </ol>

                <div class="mt-5">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <div class="card">
                                <div class="card-body">
                                    <table class="table table-bordered">
                                        <tr>
                                            <th>Số điện thoại</th>
                                            <td>${userGet.phoneNumber}</td>
                                        </tr>
                                        <tr>
                                            <th>Tên</th>
                                            <td>${userGet.name}</td>
                                        </tr>
                                        <tr>
                                            <th>Email</th>
                                            <td>${userGet.email}</td>
                                        </tr>
                                        <tr>
                                            <th>Địa chỉ</th>
                                            <td>${userGet.address}</td>
                                        </tr>
                                        <tr>
                                            <th>Giới tính</th>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${userGet.gender == 'M'}">Nam</c:when>
                                                    <c:otherwise>Nữ</c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Quyền</th>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${userGet.role.name == 'ADMIN'}">Quản trị viên</c:when>
                                                    <c:when test="${userGet.role.name == 'VENDOR'}">Người bán</c:when>
                                                    <c:when test="${userGet.role.name == 'USER'}">Người dùng</c:when>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Điểm tích lũy</th>
                                            <td>${userGet.pointEarned}</td>
                                        </tr>
                                        <tr>
                                            <th>Trạng thái</th>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${userGet.status}">
                                                        <span class="badge bg-success">Hoạt động</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger">Ngưng</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Ngày tạo</th>
                                            <td><fmt:formatDate value="${userGet.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                                        </tr>
                                        <tr>
                                            <th>Ngày cập nhật</th>
                                            <td><fmt:formatDate value="${userGet.updatedAt}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="card-footer d-flex justify-content-between">
                                    <div>
                                        <c:choose>
                                            <c:when test="${userGet.status}">
                                                <a href="/admin/user/delete/${userGet.phoneNumber}" class="btn btn-danger"
                                                   onclick="return confirm('Bạn có chắc chắn muốn tắt hoạt động người dùng này?')">Tắt hoạt động</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="/admin/user/activate/${userGet.phoneNumber}" class="btn btn-primary"
                                                   onclick="return confirm('Bạn có chắc chắn muốn kích hoạt người dùng này?')">Kích hoạt</a>
                                            </c:otherwise>
                                        </c:choose>
                                        <a href="${pageContext.request.contextPath}/admin/user/newpass/${userGet.phoneNumber}" class="btn btn-primary"
                                           onclick="return confirm('Bạn có chắc chắn muốn tạo mới mật khẩu cho người dùng này?')">Đổi mật khẩu mới</a>
                                    </div>
                                    <div>
                                        <a href="/admin/user/update/${userGet.phoneNumber}" class="btn btn-warning">Cập nhật</a>
                                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Quay lại</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    <c:if test="${not empty success}">
    Swal.fire({
        icon: 'success',
        title: 'Thành công!',
        text: '${success}',
        confirmButtonText: 'OK'
    });
    </c:if>
    <c:if test="${not empty error}">
    Swal.fire({
        icon: 'error',
        title: 'Lỗi!',
        text: '${error}',
        confirmButtonText: 'OK'
    });
    </c:if>
</script>
</body>
</html>