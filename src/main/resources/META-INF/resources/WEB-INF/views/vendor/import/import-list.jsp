<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Danh sách phiếu nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="bg-light">
<div class="container mt-5">
    <!-- Breadcrumb Section -->
    <h1 class="mt-4">Quản lý Phiếu nhập</h1>
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
        <li class="breadcrumb-item active">Danh sách phiếu nhập</li>
    </ol>

    <h3 class="mb-4">Danh sách phiếu nhập</h3>

    <!-- Form tìm kiếm -->
    <form action="/vendor/import/searchpaginated" method="get">
    <div class="d-flex align-items-center gap-2 mb-3">
        <input
                type="text"
                name="id"
                class="form-control"
                placeholder="Tìm theo ID Import"
                value="${param.id}"
                style="width: 250px;"
        />
        <button type="submit" class="btn btn-warning" style="margin: 0 10px">
            <i class="fas fa-search"></i> Tìm kiếm
        </button>
    </div>
    </form>

    <!-- Nút thêm mới -->
    <div class="d-flex gap-2 mb-3">
        <a href="/vendor/import/add" class="btn btn-success">
            <i class="fas fa-plus"></i> Thêm phiếu nhập mới
        </a>
    </div>

    <!-- Bảng danh sách Import -->
    <div class="table-responsive">
        <table class="table table-bordered table-hover">
            <thead class="table-primary">
            <tr>
                <th>Mã phiếu nhập</th>
                <th>Nhà cung cấp</th>
                <th>Ngày nhập</th>
                <th>Tổng tiền</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="imp" items="${imports}">
                <tr>
                    <td>${imp.id}</td>
                    <td>${imp.provider.name}</td>
                    <td><fmt:formatDate value="${imp.date}" pattern="yyyy-MM-dd"/></td>
                    <td><fmt:formatNumber value="${imp.totalAmount}" pattern="#,###"/></td>
                    <td>
                        <a href="/vendor/import/show/${imp.id}" class="btn btn-info btn-sm">
                            <i class="fas fa-eye"></i> Chi tiết
                        </a>
                        <button class="btn btn-danger btn-sm" onclick="confirmDelete('${imp.id}');">
                            <i class="fas fa-trash"></i> Xóa
                        </button>
                        <button class="btn btn-success btn-sm" onclick="confirmEdit('${imp.id}');">
                            <i class="fas fa-edit"></i> Thêm chi tiết
                        </button>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty imports}">
                <tr>
                    <td colspan="5" class="text-center">Không có bản ghi nào</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>

    <!-- Phân trang -->
    <c:if test="${not empty pageNumbers}">
        <nav>
            <ul class="pagination justify-content-center">
                <c:forEach var="pageNumber" items="${pageNumbers}">
                    <li class="page-item ${pageNumber == importPage.number + 1 ? 'active' : ''}">
                        <a class="page-link" href="/vendor/import?page=${pageNumber}">
                                ${pageNumber}
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    // Kiểm tra nếu có message
    <c:if test="${not empty message}">
    Swal.fire({
        icon: 'success',
        title: 'Thành công!',
        text: '${message}',
        confirmButtonText: 'OK'
    });
    </c:if>

    // Kiểm tra nếu có error
    <c:if test="${not empty error}">
    Swal.fire({
        icon: 'error',
        title: 'Lỗi!',
        text: '${error}',
        confirmButtonText: 'OK'
    });
    </c:if>
</script>
<script>
    function confirmDelete(id) {
        Swal.fire({
            title: 'Bạn có chắc chắn muốn xóa phiếu nhập ' + id + '?',
            text: "Hành động này không thể hoàn tác!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Xóa',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                // Chuyển hướng tới URL xóa
                window.location.href = `/vendor/import/delete/` + id;
            }
        });
    }

    function confirmEdit(id) {
        Swal.fire({
            title: 'Bạn có chắc chắn muốn thêm chi tiết cho phiếu nhập ' + id + '?',
            text: "Hành động này không thể hoàn tác!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Thêm chi tiết',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                // Chuyển hướng tới URL sửa
                window.location.href = `/vendor/import-detail/add-detail/` + id;
            }
        });
    }
</script>
</body>
</html>
