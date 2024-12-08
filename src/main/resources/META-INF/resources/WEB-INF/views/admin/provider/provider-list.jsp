<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Danh sách Nhà cung cấp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="bg-light">
<div class="container mt-5">
    <h1 class="mb-4 text-start">Danh sách nhà cung cấp</h1>

    <!-- Form tìm kiếm -->
    <form action="${pageContext.request.contextPath}/admin/provider/searchpaginated" method="get" class="row g-3 mb-4">
        <div class="col-md-5">
            <input type="text" name="name" class="form-control" placeholder="Tìm theo tên" value="${param.name}" />
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary w-100"><i class="fas fa-search"></i> Tìm kiếm</button>
        </div>
    </form>
    <div class="mb-4">
        <a href="${pageContext.request.contextPath}/admin/provider/add" class="btn btn-success">
            <i class="fas fa-plus"></i> Thêm Nhà cung cấp mới
        </a>
    </div>
    <!-- Hiển thị danh sách Provider -->
    <div class="table-responsive">
        <table class="table table-bordered table-hover">
            <thead class="table-primary text-center">
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Địa chỉ</th>
                <th>Số điện thoại</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="provider" items="${providers}">
                <tr>
                    <td class="text-center">${provider.id}</td>
                    <td>${provider.name}</td>
                    <td>${provider.address}</td>
                    <td>${provider.phone}</td>
                    <td class="text-center">
                        <a href="${pageContext.request.contextPath}/admin/provider/edit/${provider.id}" class="btn btn-warning btn-sm">
                            <i class="fas fa-edit"></i> Sửa
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/provider/show/${provider.id}" class="btn btn-info btn-sm mx-1">
                            <i class="fas fa-eye"></i> Xem
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/provider/delete/${provider.id}" class="btn btn-danger btn-sm">
                            <i class="fas fa-trash"></i> Xóa
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Phân trang -->
    <c:if test="${not empty pageNumbers}">
        <nav>
            <ul class="pagination justify-content-center">
                <c:forEach var="pageNum" items="${pageNumbers}">
                    <li class="page-item ${pageNum == providerPage.number + 1 ? 'active' : ''}">
                        <a class="page-link" href="?page=${pageNum}&size=${providerPage.size}">
                                ${pageNum}
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