<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Xóa Nhà Cung Cấp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="bg-light">
<div class="container mt-5">
    <h1 class="mb-4">Xóa Nhà Cung Cấp</h1>

    <!-- Xác nhận thông báo -->
    <p class="text">Bạn có chắc chắn muốn xóa nhà cung cấp sau đây không?</p>

    <!-- Thông tin nhà cung cấp -->
    <div class="card shadow p-4 mb-4 bg-white rounded">
        <table class="table table-bordered">
            <tr>
                <th>ID:</th>
                <td>${pro.id}</td>
            </tr>
            <tr>
                <th>Tên Nhà Cung Cấp:</th>
                <td>${pro.name}</td>
            </tr>
            <tr>
                <th>Địa Chỉ:</th>
                <td>${pro.address}</td>
            </tr>
            <tr>
                <th>Số Điện Thoại:</th>
                <td>${pro.phone}</td>
            </tr>
        </table>
    </div>

    <!-- Nút hành động -->
    <div class="d-flex justify-content-between">
        <form action="${pageContext.request.contextPath}/admin/provider/delete/${pro.id}" method="post">
            <button type="submit" class="btn btn-danger"><i class="fas fa-trash-alt"></i> Xác nhận xóa</button>
        </form>
        <a href="${pageContext.request.contextPath}/admin/provider" class="btn btn-secondary">
            <i class="fas fa-times"></i> Hủy
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
