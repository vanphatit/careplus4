<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medicine Detail</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f9f9f9;
        }
        .medicine-detail {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .medicine-image {
            max-width: 200px;
            border-radius: 10px;
        }
        .rating-stars {
            display: inline-block;
            position: relative;
            font-size: 1.5rem;
            color: #ffc107; /* Màu vàng */
        }

        .rating-stars::before {
            content: "★★★★★"; /* Nền đầy sao */
            color: #e4e5e9; /* Màu sao rỗng */
            display: block;
            position: absolute;
            top: 0;
            left: 0;
            overflow: hidden;
            width: 100%; /* Mặc định full width */
        }

        .rating-stars span {
            display: inline-block;
            position: relative;
            overflow: hidden;
            color: #ffc107; /* Màu sao đầy */
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <!-- Tiêu đề -->
    <div class="text-center mb-4">
        <h1 class="text-primary">Chi tiết thuốc ${medicine.name}</h1>
    </div>

    <!-- Chi tiết thuốc -->
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="medicine-detail">
                <table class="table table-borderless">
                    <tbody>
                    <tr>
                        <th scope="row">Mã thuốc</th>
                        <td>${medicine.id}</td>
                    </tr>
                    <tr>
                        <th scope="row">Tên thuốc</th>
                        <td>${medicine.name}</td>
                    </tr>
                    <tr>
                        <th scope="row">Description</th>
                        <td>${medicine.description}</td>
                    </tr>
                    <tr>
                        <th scope="row">Giá bán</th>
                        <td>${medicine.unitCost}</td>
                    </tr>
                    <tr>
                        <th scope="row">Ngày hết hạn</th>
                        <td>${medicine.expiryDate}</td>
                    </tr>
                    <tr>
                        <th scope="row">Ngày nhập</th>
                        <td>${medicine.importDate}</td>
                    </tr>
                    <tr>
                        <th scope="row">Số lượng tồn</th>
                        <td>${medicine.stockQuantity}</td>
                    </tr>
                    <tr>
                        <th scope="row">Liều lượng</th>
                        <td>${medicine.dosage}</td>
                    </tr>
                    <tr>
                        <th scope="row">Số sao</th>
                        <td>${medicine.rating}</td>
                    </tr>
                    <tr>
                        <th scope="row">Nhà sản xuất</th>
                        <td>${medicine.manufacturer.name}</td>
                    </tr>
                    <tr>
                        <th scope="row">Danh mục</th>
                        <td>${medicine.category.name}</td>
                    </tr>
                    <tr>
                        <th scope="row">Đơn vị</th>
                        <td>${medicine.unit.name}</td>
                    </tr>
                    <tr>
                        <th scope="row">Hình ảnh</th>
                        <td>
                            <img src="${pageContext.request.contextPath}/medicine/image?fileName=${medicine.image}"
                                 alt="Medicine Image"
                                 class="medicine-image img-thumbnail">
                        </td>
                    </tr>
                    </tbody>
                </table>

                <!-- Bọc toàn bộ danh sách review trong một div -->
                <div class="reviews-container mt-4">
                    <h3 class="text-primary">Danh sách đánh giá</h3>
                    <c:forEach var="review" items="${reviews.content}">
                        <div class="review-item p-3 mb-3" style="background-color: #f8f9fa; border-radius: 10px; box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);">
                            <div class="d-flex justify-content-between">
                                <span class="fw-bold">${review.userName}</span>
                                <span class="text-muted">
                    <fmt:formatDate value="${review.date}" pattern="dd/MM/yyyy" />
                </span>
                            </div>
                            <div class="mt-2">
                                <!-- Vùng hiển thị sao -->
                                <div class="rating-stars" style="position: relative; display: inline-block; font-size: 20px; color: #ddd;">
                                    <!-- Sao rỗng -->
                                    <span style="color: #ddd;">&#9733;&#9733;&#9733;&#9733;&#9733;</span>
                                    <!-- Sao đầy -->
                                    <span style="color: #ffc107; position: absolute; top: 0; left: 0; width: ${review.rating * 20}%; overflow: hidden; white-space: nowrap;">
                        &#9733;&#9733;&#9733;&#9733;&#9733;
                    </span>
                                </div>
                            </div>
                            <p class="mt-2">${review.review}</p>
                        </div>
                    </c:forEach>
                </div>

                <!-- Pagination -->
                <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <c:forEach var="page" items="${pageNumbers}">
                            <li class="page-item ${page == currentPage ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/vendor/medicine/detail/${medicine.id}?page=${page}&size=${pageSize}">
                                        ${page}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </nav>

                <div class="text-center mt-4">
                    <a href="${pageContext.request.contextPath}/vendor/medicines" class="btn btn-outline-primary">Quay về</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
