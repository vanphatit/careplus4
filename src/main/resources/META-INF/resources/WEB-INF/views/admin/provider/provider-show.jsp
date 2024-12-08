<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Chi tiết Nhà Cung Cấp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="bg-light">
<div class="container mt-5">
<h1 class="mb-4">Chi tiết Nhà Cung Cấp</h1>

<!-- Kiểm tra nếu provider tồn tại -->
<c:if test="${not empty provider}">
    <div class="card shadow p-4 bg-white rounded">
        <table class="table table-bordered">
            <tr>
                <th>ID:</th>
                <td>${provider.id}</td>
            </tr>
            <tr>
                <th>Tên Nhà Cung Cấp:</th>
                <td>${provider.name}</td>
            </tr>
            <tr>
                <th>Địa Chỉ:</th>
                <td>${provider.address}</td>
            </tr>
            <tr>
                <th>Số Điện Thoại:</th>
                <td>${provider.phone}</td>
            </tr>
        </table>
        <div class="mt-3">
            <a href="${pageContext.request.contextPath}/admin/provider" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Quay lại danh sách
            </a>
        </div>
    </div>
</c:if>

<!-- Thông báo nếu không tìm thấy provider -->
<c:if test="${empty provider}">
    <div class="alert alert-danger" role="alert">
    Nhà cung cấp không tồn tại.
    </div>
    <a href="${pageContext.request.contextPath}/admin/provider" class="btn btn-secondary">
    <i class="fas fa-arrow-left"></i>
            Quay lại danh sách
    </a>
</c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>