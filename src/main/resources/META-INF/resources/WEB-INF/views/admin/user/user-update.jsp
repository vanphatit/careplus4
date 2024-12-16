<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
                    <li class="breadcrumb-item"><a href="/admin/users">Người dùng </a></li>
                    <li class="breadcrumb-item active">Cập nhật</li>
                </ol>

                <div class="mt-5">
                    <div class="row">
                        <div class="col-12 col-md-8 mx-auto">
                            <div class="card">
                                <div class="card-header text-white" style="background-color: rgb(0, 28, 64);">
                                    <h3>Cập nhật thông tin người dùng</h3>
                                </div>
                                <div class="card-body">
                                    <form action="/admin/user/update/${userGet.phoneNumber}" method="post">
                                        <div class="mb-3">
                                            <label for="name" class="form-label">Tên</label>
                                            <input type="text" id="name" name="name" class="form-control" value="${userGet.name}" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="email" class="form-label">Email</label>
                                            <input type="email" id="email" name="email" class="form-control" value="${userGet.email}" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="address" class="form-label">Địa chỉ</label>
                                            <input type="text" id="address" name="address" class="form-control" value="${userGet.address}">
                                        </div>
                                        <div class="mb-3">
                                            <label for="gender" class="form-label">Giới tính</label>
                                            <select id="gender" name="gender" class="form-control">
                                                <option value="M" ${userGet.gender == 'M' ? 'selected' : ''}>Nam</option>
                                                <option value="F" ${userGet.gender == 'F' ? 'selected' : ''}>Nữ</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="role" class="form-label">Giới tính</label>
                                            <select id="role" name="role" class="form-control">
                                                <option value="ADMIN" ${userGet.role.name == 'ADMIN' ? 'selected' : ''}>Admin</option>
                                                <option value="VENDOR" ${userGet.role.name == 'VENDOR' ? 'selected' : ''}>Vendor</option>
                                                <option value="USER" ${userGet.role.name == 'USER' ? 'selected' : ''}>User</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="pointEarned" class="form-label">Điểm tích lũy</label>
                                            <input type="number" id="pointEarned" name="pointEarned" class="form-control" value="${userGet.pointEarned}" min="0" required>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <button type="submit" class="btn btn-success">Lưu thay đổi</button>
                                            <a href="/admin/users" class="btn btn-secondary">Quay lại</a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

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
