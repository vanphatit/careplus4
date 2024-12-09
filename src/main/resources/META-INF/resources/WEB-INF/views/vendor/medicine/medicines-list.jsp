<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medicines List</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f7f8fa;
            font-family: Arial, sans-serif;
        }

        .section-container {
            background-color: #ffffff; /* Màu nền trắng */
            border-radius: 10px; /* Bo góc */
            padding: 20px; /* Khoảng cách bên trong */
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng */
            margin-bottom: 20px; /* Khoảng cách dưới */
        }

        /*.filter-container h5 {*/
        /*    font-size: 1.2rem;*/
        /*    font-weight: bold;*/
        /*    color: #007bff; !* Màu xanh nổi bật *!*/
        /*    text-align: center;*/
        /*    margin-bottom: 15px;*/
        /*}*/

        .btn {
            border-radius: 5px;
        }

        .btn-success {
            margin-top: 10px;
        }

        .table-container {
            background-color: #ffffff;
            border-radius: 5px;
            padding: 20px;
            box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.1);
        }

        .table th {
            background-color: #f1f3f5;
            color: #495057;
            font-weight: bold;
        }

        .table td {
            vertical-align: middle;
        }

        .alert {
            padding: 15px;
            border-radius: 5px;
            position: relative;
            box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.1);
        }

        .alert-dismissible .btn-close {
            position: absolute;
            background: #c82333;
            color: #fff;
            top: 10px;
            right: 10px;
        }

        .alert .btn-close:hover {
            color: #fff;
            background-color: #0895a5;
        }

        .col-md-6 {
            display: block;
        }

        /* Cải thiện toàn bộ Filter Options */
        .filter-container {
            background: linear-gradient(135deg, #f5f7fa, #e4e9f0); /* Gradient nhạt */
            border-radius: 15px; /* Bo góc lớn hơn */
            padding: 20px; /* Thêm khoảng cách bên trong */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ */
            margin-bottom: 20px;
        }

        .filter-container h5 {
            font-size: 1.5rem;
            font-weight: bold;
            color: #007bff; /* Màu xanh nổi bật */
            text-align: center;
            margin-bottom: 15px;
        }

        .filter-container label {
            font-size: 0.9rem;
            font-weight: 600;
            color: #495057; /* Màu chữ tinh tế */
            margin-bottom: 5px;
        }

        .filter-container .form-control,
        .filter-container .form-select {
            background-color: #ffffff; /* Màu nền trắng */
            border: 1px solid #ced4da; /* Viền màu xám nhạt */
            border-radius: 10px; /* Bo góc */
            padding: 10px 15px; /* Khoảng cách bên trong */
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1); /* Hiệu ứng chìm */
            transition: all 0.3s ease; /* Hiệu ứng mượt */
            font-size: 1rem; /* Cỡ chữ đồng nhất */
            color: #495057; /* Màu chữ tinh tế */
        }

        .filter-container .form-control:focus,
        .filter-container .form-select:focus {
            max-width: 100%; /* Chiều rộng tối đa */
            height: 45px; /* Chiều cao thống nhất */
        }

        .filter-container button {
            background-color: #007bff; /* Màu xanh hiện đại */
            border: none;
            color: white;
            font-weight: bold;
            border-radius: 10px;
            padding: 10px 20px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .filter-container button:hover {
            background-color: #0056b3; /* Đổi màu khi hover */
            transform: scale(1.05); /* Phóng to nhẹ khi hover */
        }

        /* Đặt khoảng cách giữa các trường Filter */
        .filter-container .mb-3 {
            margin-bottom: 20px;
        }
    </style>

</head>
<body>
<div class="container mt-4">
    <div class="row">
        <!-- Filter Section: 1/3 -->
        <div class="col-md-2">
            <div class="section-container filter-container">
                <h5 class="text-center">Bộ Lọc Nâng Cao</h5>
                <form method="post" action="${pageContext.request.contextPath}/vendor/medicine/filter">

                    <!-- Unit Cost Min/Max -->
                    <div class="mb-3">
                        <label for="unitCostMin" class="form-label">Giá bán</label>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label hidden="hidden" for="unitCostMin" class="form-label">Unit Cost Min</label>
                                <input type="number" name="unitCostMin" id="unitCostMin" class="form-control shadow-sm" min="0" step="10000" placeholder="Từ" value="${unitCostMin}">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label hidden="hidden" for="unitCostMax" class="form-label">Unit Cost Max</label>
                                <input type="number" name="unitCostMax" id="unitCostMax" class="form-control shadow-sm" min="0" step="10000" placeholder="Đến" value="${unitCostMax}">
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Đánh giá</label>
                        <div class="row">
                            <!-- Rating Min/Max -->
                            <div class="col-md-6 mb-3">
                                <label hidden="hidden" for="ratingMin" class="form-label">Rating Min</label>
                                <input type="number" name="ratingMin" id="ratingMin" class="form-control shadow-sm" placeholder="Từ" min="0.0" max="5.0" step="0.1" value="${ratingMin}">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label hidden="hidden" for="ratingMax" class="form-label">Rating Max</label>
                                <input type="number" name="ratingMax" id="ratingMax" class="form-control shadow-sm" placeholder="Đến" step="0.1" value="${ratingMax}">
                            </div>
                        </div>
                    </div>

                    <!-- Expiry Date Min/Max -->
                    <div class="mb-3">
                        <label for="expiryDateMin" class="form-label">Ngày hết hạn từ:</label>
                        <input type="date" name="expiryDateMin" id="expiryDateMin" class="form-control shadow-sm" value="${expiryDateMin}">
                    </div>
                    <div class="mb-3">
                        <label for="expiryDateMax" class="form-label">Đến</label>
                        <input type="date" name="expiryDateMax" id="expiryDateMax" class="form-control shadow-sm" value="${expiryDateMax}">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Lượng tồn kho</label>
                        <div class="row">
                            <!-- Stock Quantity Min/Max -->
                            <div class="col-md-6 mb-3">
                                <label hidden="hidden" for="stockQuantityMin" class="form-label">Stock Min</label>
                                <input type="number" name="stockQuantityMin" id="stockQuantityMin" class="form-control shadow-sm" placeholder="Từ" min="0" value="${stockQuantityMin}">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label hidden="hidden" for="stockQuantityMax" class="form-label">Stock Max</label>
                                <input type="number" name="stockQuantityMax" id="stockQuantityMax" class="form-control shadow-sm" placeholder="Đến" min="0" value="${stockQuantityMax}">
                            </div>
                        </div>
                    </div>

                    <!-- Import Date Min/Max -->
                    <div class="mb-3">
                        <label for="importDateMin" class="form-label">Ngày nhập từ:</label>
                        <input type="date" name="importDateMin" id="importDateMin" class="form-control shadow-sm" value="${importDateMin}">
                    </div>
                    <div class="mb-3">
                        <label for="importDateMax" class="form-label">Đến:</label>
                        <input type="date" name="importDateMax" id="importDateMax" class="form-control shadow-sm" value="${importDateMax}">
                    </div>

                    <!-- Apply Filters -->
                    <button type="submit" class="btn btn-success w-100">Áp dụng và lọc</button>
                </form>
            </div>
        </div>

        <!-- Main Content: 2/3 -->
        <div class="col-md-10">
            <h1 class="text-center mb-4">Danh sách thuốc trong kho</h1>
            <!-- Search Section -->
            <div class="section-container mb-4">
                <form method="post" action="${pageContext.request.contextPath}/vendor/medicine/search" class="d-flex">
                    <input type="text" name="keyword" class="form-control me-2 shadow-sm" placeholder="Tìm kiếm theo tên, loại, nhà sản xuất, mô tả, đơn vị và liều dùng" value="${keyword}">
                    <button type="submit" class="btn btn-primary px-4 shadow-sm">Tìm</button>
                </form>
            </div>

            <!-- Notification -->
            <c:if test="${not empty message}">
                <div class="alert alert-info alert-dismissible fade show" role="alert">
                    <strong>${message}</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"> Đóng </button>
                </div>
            </c:if>

            <!-- Table Section -->
            <div class="table-container">
                <table class="table table-bordered table-striped">
                    <thead class="table-light">
                    <tr>
                        <th>Mã thuốc</th>
                        <th>Tên thuốc</th>
                        <th>Loại thuốc</th>
                        <th>Tên nhà sản xuất</th>
                        <th>Giá bán</th>
                        <th>Lượng tồn kho</th>
                        <th>Hoạt động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="medicine" items="${medicines.content}">
                        <tr>
                            <td>${medicine.id}</td>
                            <td>${medicine.name}</td>
                            <td>${medicine.category.name}</td>
                            <td>${medicine.manufacturer.name}</td>
                            <td>${medicine.unitCost}</td>
                            <td>${medicine.stockQuantity}</td>
                            <td>
                                <div class="d-flex gap-2 justify-content-center">
                                    <a href="${pageContext.request.contextPath}/vendor/medicine/${medicine.id}" class="btn btn-info btn-sm text-white">Xem</a>
                                    <a href="${pageContext.request.contextPath}/vendor/medicine/edit/${medicine.id}" class="btn btn-warning btn-sm">Sửa</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center">
                    <c:forEach var="page" begin="1" end="${pageNumbers.size()}">
                        <li class="page-item ${page == currentPage ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/vendor/medicines?page=${page}&size=${pageSize}&search=${searchKeyword}">
                                    ${page}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
