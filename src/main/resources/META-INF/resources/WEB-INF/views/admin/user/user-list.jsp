<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>${imp.id == null ? 'Add New Import' : 'Edit Import'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        .custom-select {
            width: 25%;
            margin: 0 auto; /* Căn giữa */
            font-size: 16px;
            border-radius: 8px; /* Bo góc */
            padding: 8px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Hiệu ứng đổ bóng */
            background-color: #f9f9f9; /* Màu nền nhạt */
            transition: all 0.3s ease-in-out;
        }

        .breadcrumb .badge {
            font-size: 14px;
            padding: 8px 12px;
            border-radius: 12px;
            display: inline-block;
            font-weight: 500;
        }

        .custom-select:hover {
            border-color: #007bff; /* Đổi màu viền khi hover */
            background-color: #ffffff; /* Màu nền khi hover */
        }
    </style>
</head>
<body>
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <div class="d-flex align-items-center mt-4">
                    <h1 style="padding-right: 20px !important; padding-bottom: 10px" class="mb-0 me-3">Quản lý người
                        dùng</h1>
                    <a href="/admin/user/new"
                       class="btn btn-warning d-flex align-items-center justify-content-center px-3 py-2 shadow-sm">
                        <i class="fas fa-user-plus"></i>
                    </a>
                </div>
                <ol class="breadcrumb mb-4 d-flex justify-content-between align-items-center">
                    <div class="d-flex gap-2">
                        <li class="breadcrumb-item"><a href="/admin/">Dashboard</a></li>
                        <li class="breadcrumb-item active">Người dùng</li>
                    </div>

                    <div class="d-flex gap-3">
                        <span class="badge bg-primary mx-2">Quản trị viên: <strong>${adminCount}</strong></span>
                        <span class="badge bg-success mx-2">Người bán: <strong>${vendorCount}</strong></span>
                        <span class="badge bg-info mx-2">Người dùng: <strong>${userCount}</strong></span>
                    </div>
                </ol>

                <div class="mt-5">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <div class="d-flex justify-content-between align-items-center">
                                <!-- Tiêu đề -->
                                <h3>Danh sách người dùng</h3>

                                <!-- Combobox lọc status người dùng -->
                                <form action="/admin/users/filter" method="get" class="d-flex align-items-center">
                                    <select id="status" name="status"
                                            class="custom-select form-select form-select-sm me-3"
                                            style="width: 200px;" onchange="this.form.submit()">
                                        <option value="all">Tất cả (Trạng thái)</option>
                                        <option value="active" ${current_status == 'active' ? 'selected' : ''}>
                                            Còn hoạt động
                                            <c:if test="${not empty statusCount}">
                                                ( ${statusCount} )
                                            </c:if></option>
                                        <option value="inactive" ${current_status == 'inactive' ? 'selected' : ''}>
                                            Đã ngưng hoạt động
                                            <c:if test="${not empty statusCount}">
                                                ( ${statusCount} )
                                            </c:if></option>
                                    </select>
                                    <p>-</p>
                                    <select id="roles" name="roles"
                                            class="custom-select form-select form-select-sm me-3"
                                            style="width: 200px;" onchange="this.form.submit()">
                                        <option value="all">Tất cả (Quyền)</option>
                                        <option value="ADMIN" ${current_role == 'ADMIN' ? 'selected' : ''}>
                                            Quản trị viên
                                            <c:if test="${not empty roleCount}">
                                                ( ${roleCount} )
                                            </c:if></option>
                                        <option value="VENDOR" ${current_role == 'VENDOR' ? 'selected' : ''}>
                                            Người bán hàng
                                            <c:if test="${not empty roleCount}">
                                                ( ${roleCount} )
                                            </c:if></option>
                                        <option value="USER" ${current_role == 'USER' ? 'selected' : ''}>
                                            Người dùng
                                            <c:if test="${not empty roleCount}">
                                                ( ${roleCount} )
                                            </c:if></option>
                                    </select>
                                </form>

                                <div class="d-flex justify-content-center">
                                    <form action="/admin/user/search" method="post" class="position-relative"
                                          style="width: 300px;">
                                        <input type="text" name="searchT" placeholder="Tìm kiếm Tên, SĐT..."
                                               value="${searchText}${searchCount}" class="form-control"
                                               style="border-radius: 20px; padding-right: 45px;">
                                        <button type="submit" style="display: none;"></button>
                                    </form>
                                </div>
                            </div>

                            <hr/>
                            <table class="table table-bordered table-hover">
                                <thead style="background-color: rgb(0, 28, 64); color: white;">
                                <tr>
                                    <th>Số điện thoại</th>
                                    <th>Họ Tên</th>
                                    <th>Email</th>
                                    <th>Địa chỉ</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="user" items="${usersPage.content}">
                                    <tr>
                                        <td>${user.phoneNumber}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${user.role.name == 'ADMIN'}">
                                                    <span class="badge bg-primary">
                                                        <i class="fas fa-shield-alt me-1"></i> Admin
                                                        <strong> ${user.name}</strong>
                                                    </span>

                                                </c:when>
                                                <c:when test="${user.role.name == 'VENDOR'}">
                                                    <span class="badge bg-success">
                                                        <i class="fas fa-store me-1"></i> Vendor
                                                        <strong>${user.name}</strong>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span>${user.name}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${user.email}</td>
                                        <td>${user.address}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${user.status}">
                                                    <span class="badge bg-success">Hoạt động</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">Ngưng</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="/admin/user/${user.phoneNumber}" class="btn btn-success btn-sm">Chi
                                                tiết</a>
                                            <a href="/admin/user/update/${user.phoneNumber}"
                                               class="btn btn-warning btn-sm mx-2">Cập nhật</a>
                                            <c:choose>
                                                <c:when test="${user.status}">
                                                    <a href="/admin/user/delete/${user.phoneNumber}"
                                                       class="btn btn-danger btn-sm"
                                                       onclick="return confirm('Bạn có chắc chắn muốn tắt hoạt động người dùng này?')">Tắt
                                                        hoạt động</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="/admin/user/activate/${user.phoneNumber}"
                                                       class="btn btn-primary btn-sm"
                                                       onclick="return confirm('Bạn có chắc chắn muốn kích hoạt người dùng này?')">Kích
                                                        hoạt</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                            <!-- Phân trang -->
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="/admin/users?page=${currentPage - 1}"
                                           aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <c:forEach begin="1" end="${pageNo}" var="i">
                                        <c:choose>
                                            <c:when test="${currentPage == i}">
                                                <li class="page-item active">
                                                    <a class="page-link" href="/admin/users?page=${i}">${i}</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item">
                                                    <a class="page-link" href="/admin/users?page=${i}">${i}</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <li class="page-item ${currentPage == pageNo ? 'disabled' : ''}">
                                        <a class="page-link" href="/admin/users?page=${currentPage + 1}"
                                           aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                            <span class="sr-only">Next</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
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