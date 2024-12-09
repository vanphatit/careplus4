<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Review</title>
    <!-- Thêm Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .card {
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        .table th {
            background-color: rgb(0, 28, 64);
            color: white;
        }
    </style>
</head>
<body>
<div class="container my-5">
    <h1 class="mb-4 text-primary">Chi tiết Review</h1>
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/vendor/">Dashboard</a></li>
            <li class="breadcrumb-item"><a href="/vendor/reviews">Danh sách Reviews</a></li>
            <li class="breadcrumb-item active" aria-current="page">Chi tiết Review</li>
        </ol>
    </nav>

    <div class="card p-4">
        <!-- Thông tin người dùng và hóa đơn -->
        <div class="mb-4">
            <p><strong>Người dùng:</strong>
                <c:choose>
                    <c:when test="${user.role.name == 'ADMIN'}">
                        <span class="text-primary">
                            <a href="/admin/user/${review.user.phoneNumber}" class="text-decoration-none text-primary">
                                    ${review.user.name}
                            </a>
                        </span>
                    </c:when>
                    <c:otherwise>
                        <span class="text-primary">${review.user.name}</span>
                    </c:otherwise>
                </c:choose>
            </p>
            <p><strong>Hoá đơn số:</strong> <span class="text-success">${review.bill.id}</span></p>
        </div>

        <!-- Bảng chi tiết review -->
        <h2 class="mb-4 text-secondary">Danh sách sản phẩm được review</h2>
        <table class="table table-bordered table-hover">
            <thead>
            <tr>
                <th>Sản phẩm</th>
                <th>Đánh giá</th>
                <th>Bình luận</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="detail" items="${reviewDetails}">
                <tr>
                    <td>
                        <a href="/user/medicine/${detail.medicine.id}" class="text-decoration-none text-primary">
                                ${detail.medicine.name}
                        </a>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${detail.rating >= 4.5}">
                                <span class="badge bg-success">${detail.rating} sao</span>
                            </c:when>
                            <c:when test="${detail.rating >= 3.5}">
                                <span class="badge bg-warning text-dark">${detail.rating} sao</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger">${detail.rating} sao</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${detail.text}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <!-- Nút quay lại -->
        <div class="text-center mt-4">
            <a href="/vendor/reviews" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Quay lại
            </a>
        </div>
    </div>
</div>

<!-- Thêm script Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
