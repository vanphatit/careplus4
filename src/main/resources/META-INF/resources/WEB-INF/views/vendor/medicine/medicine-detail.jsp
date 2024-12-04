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
        .medicine-img {
            width: 100%; /* Đảm bảo ảnh co dãn theo vùng chứa */
            max-width: 400px; /* Giới hạn chiều rộng tối đa */
            height: 400px; /* Chiều cao cố định */
            border-radius: 10px;
            object-fit: contain;
        }

        @media (max-width: 768px) {
            .medicine-img {
                width: 300px; /* Chiều rộng nhỏ hơn trên màn hình nhỏ */
                height: 300px;
            }
        }

        @media (max-width: 576px) {
            .medicine-img {
                width: 200px; /* Chiều rộng nhỏ hơn nữa */
                height: 200px;
            }
        }

        .nav-tabs .nav-item .nav-link {
            font-weight: bold;
        }

        .nav-tabs {
            border-bottom: 2px solid #ddd;
        }

        .nav-tabs .nav-link {
            border: none;
            color: #555;
        }

        .nav-tabs .nav-link.active {
            border-bottom: 3px solid #007bff; /* Dòng kẻ dưới khi được chọn */
            color: #007bff;
        }

        .tab-content {
            margin-top: 20px;
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
            <div class="medicine-detail p-4">
                <div class="row">
                    <div class="col-md-4 text-center">
                        <!-- Hình ảnh thuốc -->
                        <img src="${pageContext.request.contextPath}/image?fileName=${medicine.image}&width=400&height=400"
                             alt="${medicine.name}"
                             style="max-width: 100%; height: auto; border-radius: 10px;"
                             class="medicine-img"
                        />
                    </div>
                    <div class="col-md-8">
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
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Tabs -->
            <div class="mt-5">
                <!-- Tiêu đề -->
                <div class="text-center mb-4">
                    <h1 class="text-primary fw-bold">Thông tin chi tiết</h1>
                </div>

                <ul class="nav nav-tabs justify-content-center" id="medicineTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="description-tab" data-bs-toggle="tab" data-bs-target="#description" type="button" role="tab" aria-controls="description" aria-selected="true">Mô tả sản phẩm</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="ingredients-tab" data-bs-toggle="tab" data-bs-target="#ingredients" type="button" role="tab" aria-controls="ingredients" aria-selected="false">Thành phần</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="usage-tab" data-bs-toggle="tab" data-bs-target="#usage" type="button" role="tab" aria-controls="usage" aria-selected="false">Công dụng</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="directions-tab" data-bs-toggle="tab" data-bs-target="#directions" type="button" role="tab" aria-controls="directions" aria-selected="false">Cách dùng</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="sideEffects-tab" data-bs-toggle="tab" data-bs-target="#sideEffects" type="button" role="tab" aria-controls="sideEffects" aria-selected="false">Tác dụng phụ</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="precautions-tab" data-bs-toggle="tab" data-bs-target="#precautions" type="button" role="tab" aria-controls="precautions" aria-selected="false">Cảnh báo</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="storage-tab" data-bs-toggle="tab" data-bs-target="#storage" type="button" role="tab" aria-controls="storage" aria-selected="false">Bảo quản</button>
                    </li>
                </ul>
                <div class="tab-content mt-4" id="medicineTabsContent">
                    <div class="tab-pane fade show active" id="description" role="tabpanel" aria-labelledby="description-tab">
                        <h4>Mô tả</h4>
                        <p>${description}</p>
                    </div>
                    <div class="tab-pane fade" id="ingredients" role="tabpanel" aria-labelledby="ingredients-tab">
                        <h4>Thành phần</h4>
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th>Thông tin thành phần</th>
                                <th>Hàm lượng</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="ingredient" items="${ingredients}" varStatus="status">
                                <!-- Bỏ qua phần tử đầu tiên -->
                                <c:if test="${status.index != 0}">
                                    <tr>
                                        <td>${ingredient['Thông tin thành phần']}</td>
                                        <td>${ingredient['Hàm lượng']}</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane fade" id="usage" role="tabpanel" aria-labelledby="usage-tab">
                        <h4>Công dụng</h4>
                        <p>${usage}</p>
                    </div>
                    <div class="tab-pane fade" id="directions" role="tabpanel" aria-labelledby="directions-tab">
                        <h4>Cách dùng</h4>
                        <p>${directions}</p>
                    </div>
                    <div class="tab-pane fade" id="sideEffects" role="tabpanel" aria-labelledby="sideEffects-tab">
                        <h4>Tác dụng phụ</h4>
                        <p>${sideEffects}</p>
                    </div>
                    <div class="tab-pane fade" id="precautions" role="tabpanel" aria-labelledby="precautions-tab">
                        <h4>Cảnh báo</h4>
                        <div style="background-color: #fff4e5; border-left: 5px solid #ffc107; padding: 15px; border-radius: 5px;">
                            <p>${precautions}</p>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="storage" role="tabpanel" aria-labelledby="storage-tab">
                        <h4>Bảo quản</h4>
                        <p>${storage}</p>
                    </div>
                </div>
            </div>

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
                                    <span style="color: #ffc107; position: absolute; top: 0; left: 0; width: ${review.rating * 20}%; overflow: hidden; white-space: nowrap;">&#9733;&#9733;&#9733;&#9733;&#9733;</span>
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
