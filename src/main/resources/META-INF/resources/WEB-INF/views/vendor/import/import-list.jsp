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
    <h1 class="mb-4">Danh sách phiếu nhập</h1>

    <!-- Thông báo lỗi hoặc thành công -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>
    <!-- Form tìm kiếm -->
    <div class="d-flex align-items-center gap-2 mb-3">
        <input
                type="text"
                name="id"
                class="form-control"
                placeholder="Tìm theo ID Import"
                value="${id}"
                style="width: 250px;"
        />
        <button type="submit" class="btn btn-warning">
            <i class="fas fa-search"></i> Tìm kiếm
        </button>
    </div>

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
                        <a href="/vendor/import/edit/${imp.id}" class="btn btn-warning btn-sm">
                            <i class="fas fa-edit"></i> Sửa
                        </a>
                        <a href="/vendor/import/delete/${imp.id}" class="btn btn-danger btn-sm"
                           onclick="return confirm('Bạn có chắc chắn muốn xóa?');">
                            <i class="fas fa-trash"></i> Xóa
                        </a>
                        <a href="/vendor/import-detail/add-detail/${imp.id}" class="btn btn-success btn-sm">
                            <i class="fas fa-plus"></i> Thêm chi tiết
                        </a>
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
</body>
</html>
