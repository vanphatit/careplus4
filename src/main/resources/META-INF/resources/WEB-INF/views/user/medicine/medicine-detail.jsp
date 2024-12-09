<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết thuốc</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f9f9f9;
        }
        .medicine-details {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .medicine-details h1 {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .medicine-details img {
            max-width: 100%; /* Đảm bảo ảnh không vượt quá kích thước vùng */
            height: auto;
            border-radius: 10px;
        }
        .back-link {
            margin-top: 20px;
        }
        .back-link a {
            text-decoration: none;
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

        /* Đánh giá phần */
        .rating-stars {
            font-size: 1.5rem;
            color: #ffd700; /* Màu vàng cho sao */
        }

        .rating-stars .empty-stars {
            color: #e4e5e9; /* Màu sao rỗng */
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <!-- Tiêu đề -->
    <div class="text-center mb-4">
        <h1 class="text-primary">Chi tiết thuốc</h1>
    </div>

    <!-- Chi tiết thuốc -->
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="medicine-details p-4">
                <div class="row">
                    <div class="col-md-4 text-center">
                        <!-- Hình ảnh thuốc -->
                        <img src="${pageContext.request.contextPath}/images/image?fileName=${medicine.image}&width=400&height=400"
                             alt="${medicine.name}"
                             style="max-width: 100%; height: auto; border-radius: 10px;"
                             class="medicine-img"
                        />
                    </div>
                    <div class="col-md-8">
                        <!-- Thông tin thuốc -->
                        <table class="table table-borderless">
                            <tbody>
                            <tr>
                                <th scope="row">Tên thuốc:</th>
                                <td>${medicine.name}</td>
                            </tr>
                            <tr>
                                <th scope="row">Danh mục:</th>
                                <td>${medicine.categoryName}</td>
                            </tr>
                            <tr>
                                <th scope="row">Nhà sản xuất:</th>
                                <td>${medicine.manufacturerName}</td>
                            </tr>
                            <tr>
                                <th scope="row">Đơn vị:</th>
                                <td>${medicine.unitName}</td>
                            </tr>
                            <tr>
                                <th scope="row">Giá:</th>
                                <td>${medicine.unitCost} VND</td>
                            </tr>
                            <tr>
                                <th scope="row">Số lượng:</th>
                                <td>${medicine.stockQuantity}</td>
                            </tr>
                            <tr>
                                <th scope="row">Đánh giá:</th>
                                <td>${medicine.rating}</td>
                            </tr>
                            <tr>
                                <th scope="row">Ngày hết hạn:</th>
                                <td>${medicine.expiryDate}</td>
                            </tr>
                            <tr>
                                <th scope="row">Liều lượng:</th>
                                <td>${medicine.dosage}</td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- Form thêm vào giỏ hàng -->
                        <form method="post" action="${pageContext.request.contextPath}/user/add-medicine-to-cart/${medicine.id}" class="mt-4">
                            <div class="row align-items-center">
                                <input type="hidden" name="medicineId" value="${medicine.id}">
                                <!-- Chọn số lượng -->
                                <div class="quantity-selector" style="width: 50%">
                                    <label for="quantity" class="form-label">Chọn số lượng:</label>
                                    <div class="input-group">
                                        <!-- Nút giảm -->
                                        <button type="button" class="btn btn-outline-secondary" id="decrease-quantity">-</button>
                                        <!-- Input số lượng -->
                                        <input type="number" id="quantity" name="quantity" class="form-control text-center" value="1" min="1" max="${medicine.stockQuantity}" required>
                                        <!-- Nút tăng -->
                                        <button type="button" class="btn btn-outline-secondary" id="increase-quantity">+</button>
                                    </div>
                                </div>
                                <!-- Nút thêm vào giỏ hàng -->
                                <div class="col-6 text-end" style="margin-top: 21px">
                                    <input type="hidden" name="medicineId" value="${medicine.id}">
                                    <button type="submit" class="btn btn-success mt-3">
                                        <i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng
                                    </button>
                                </div>
                            </div>
                        </form>
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
                        <div style="background-color: #f8f9fa; border-left: 5px solid #0d6efd; padding: 15px; border-radius: 5px;">
                            <p>${description}</p>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="ingredients" role="tabpanel" aria-labelledby="ingredients-tab">
                        <h4>Thành phần</h4>
                        <div style="background-color: #f8f9fa; border-left: 5px solid #198754; padding: 15px; border-radius: 5px;">
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
                    </div>
                    <div class="tab-pane fade" id="usage" role="tabpanel" aria-labelledby="usage-tab">
                        <h4>Công dụng</h4>
                        <div style="background-color: #f8f9fa; border-left: 5px solid green; padding: 15px; border-radius: 5px;">
                            <p>${usage}</p>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="directions" role="tabpanel" aria-labelledby="directions-tab">
                        <h4>Cách dùng</h4>
                        <div style="background-color: #f8f9fa; border-left: 5px solid #0dcaf0; padding: 15px; border-radius: 5px;">
                            <p>${directions}</p>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="sideEffects" role="tabpanel" aria-labelledby="sideEffects-tab">
                        <h4>Tác dụng phụ</h4>
                        <div style="background-color: #fff4e5; border-left: 5px solid #dc3545; padding: 15px; border-radius: 5px;">
                            <p>${sideEffects}</p>
                        </div>
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

            <h3 class="text-primary mt-4">Sản phẩm liên quan</h3>
            <div id="related-products-carousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach var="chunk" items="${medicines_relative}" varStatus="status">
                        <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                            <div class="row justify-content-center">
                                <c:forEach var="product" items="${chunk}">
                                    <div class="col-md-4 col-sm-6"> <!-- Điều chỉnh kích thước cột -->
                                        <div class="product-card">
                                            <img src="${pageContext.request.contextPath}/images/image?fileName=${product.image}" style="height: 150px" class="d-block w-100" alt="${product.name}">
                                            <div class="product-info">
                                                <p>${product.name}</p>
                                                <p>${product.unitCost} VND</p>
                                                <a href="${pageContext.request.contextPath}/user/medicine/${product.id}" class="btn btn-primary">Chọn mua</a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Nút Previous -->
                <button class="carousel-control-prev" type="button" data-bs-target="#related-products-carousel" data-bs-slide="prev">
                    <span aria-hidden="true">Previous</span>
                </button>

                <!-- Nút Next -->
                <button class="carousel-control-next" type="button" data-bs-target="#related-products-carousel" data-bs-slide="next">
                    <span aria-hidden="true">Next</span>
                </button>
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

            <!-- Nút quay lại -->
            <div class="text-center back-link mt-4">
                <strong><a href="${pageContext.request.contextPath}/user/medicines" class="btn btn-outline-primary">Quay về</a></strong>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Lấy các phần tử nút và input
    const decreaseButton = document.getElementById('decrease-quantity');
    const increaseButton = document.getElementById('increase-quantity');
    const quantityInput = document.getElementById('quantity');

    // Xử lý giảm số lượng
    decreaseButton.addEventListener('click', () => {
        const currentValue = parseInt(quantityInput.value);
        if (currentValue > 1) {
            quantityInput.value = currentValue - 1;
        }
    });

    // Xử lý tăng số lượng
    increaseButton.addEventListener('click', () => {
        const currentValue = parseInt(quantityInput.value);
        const maxValue = parseInt(quantityInput.max);
        if (currentValue < maxValue) {
            quantityInput.value = currentValue + 1;
        }
    });
</script>

</body>
</html>
