<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:url value="/" var="URL"></c:url>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>CarePlus4 - Quản lý Đánh giá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        .custom-select {
            width: 25%;
            margin: 0 auto;
            font-size: 16px;
            border-radius: 8px;
            padding: 8px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            background-color: #f9f9f9;
            transition: all 0.3s ease-in-out;
        }
        .breadcrumb .badge {
            font-size: 14px;
            padding: 8px 12px;
            border-radius: 12px;
            display: inline-block;
            font-weight: 500;
        }
    </style>
</head>
<body>
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <div class="d-flex align-items-center mt-4">
                    <h1 class="mb-0 me-3" style="padding-bottom: 10px !important;">Quản lý Đánh giá sản phẩm</h1>
                </div>
                <ol class="breadcrumb d-flex justify-content-between align-items-center">
                    <div class="d-flex gap-2">
                        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item active">Đánh giá sản phẩm</li>
                    </div>
                    <div class="d-flex gap-3">
                        <span class="badge bg-success mx-2">Tích cực: <strong>${positiveCount}</strong></span>
                        <span class="badge bg-warning mx-2">Phân vân: <strong>${neutralCount}</strong></span>
                        <span class="badge bg-danger mx-2">Tiêu cực: <strong>${negativeCount}</strong></span>
                    </div>
                </ol>

                <div class="row">
                        <div class="col-12 mx-auto">
                            <div class="d-flex justify-content-between align-items-center">
                                <h3>Danh sách Đánh giá</h3>

                                <!-- Bộ lọc trạng thái -->
                                <form action="/vendor/reviews/filter" method="get" class="d-flex my-4">
                                    <select name="status" class="custom-select me-3" onchange="this.form.submit()">
                                        <option value="all">Tất cả trạng thái</option>
                                        <option value="positive" ${current_status == 'positive' ? 'selected' : ''}>Tích cực</option>
                                        <option value="neutral" ${current_status == 'neutral' ? 'selected' : ''}>Phân vân</option>
                                        <option value="negative" ${current_status == 'negative' ? 'selected' : ''}>Tiêu cực</option>
                                    </select>
                                </form>

                                <!-- Tìm kiếm -->
                                <div class="d-flex justify-content-center">
                                    <form action="/vendor/reviews/search" method="post" class="position-relative"
                                          style="width: 300px;">
                                        <input type="text" name="searchText" placeholder="Nhập tên, hóa đơn..."
                                               value="${searchText}" class="form-control" style="border-radius: 20px; padding-right: 45px;"/>
                                        <button type="submit" style="display: none">Tìm kiếm</button>
                                    </form>
                                </div>
                            </div>

                            <table class="table table-bordered table-hover">
                                <thead style="background-color: rgb(0, 28, 64); color: white;">
                                <tr>
                                    <th>#</th>
                                    <th>Người dùng</th>
                                    <th>Hóa đơn</th>
                                    <th>Ngày</th>
                                    <th>Thuốc</th>
                                    <th>Đánh giá</th>
                                    <th>Bình luận</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="review" items="${reviewPage.content}">
                                    <tr>
                                        <td rowspan="${fn:length(reviewDetailsMap[review]) + 1}">
                                            <a href="/vendor/reviews/${review.id}/delete"
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa đánh giá này?')">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
                                        </td>
                                        <td rowspan="${fn:length(reviewDetailsMap[review]) + 1}">
                                                ${review.user.name}
                                        </td>
                                        <td rowspan="${fn:length(reviewDetailsMap[review]) + 1}">
                                            <a href="/admin/bill/${review.bill.id}" style="color: #0d1214 !important;"
                                               class="text-decoration-none text-primary">
                                                <strong>${review.bill.id}</strong>
                                            </a>
                                        </td>
                                        <td rowspan="${fn:length(reviewDetailsMap[review]) + 1}">
                                            <fmt:formatDate value="${review.date}" pattern="dd/MM/yyyy"/>
                                        </td>
                                    </tr>
                                    <c:if test="${not empty reviewDetailsMap[review]}">
                                        <c:forEach var="detail" items="${reviewDetailsMap[review]}">
                                            <tr>
                                                <td>
                                                    <a href="/vendor/medicine/${detail.medicine.id}" style="color: #0d1214 !important;"
                                                       class="text-decoration-none text-primary">
                                                        <strong>${detail.medicine.name}</strong>
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
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>

                            <!-- Phân trang -->
                            <nav aria-label="Page navigation">
                                <ul class="pagination justify-content-center">
                                    <!-- Nút Previous -->
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="javascript:void(0)" onclick="changePage(${currentPage - 1})">Previous</a>
                                        </li>
                                    </c:if>

                                    <!-- Danh sách số trang -->
                                    <c:forEach var="page" items="${pageNumbers}">
                                        <c:choose>
                                            <c:when test="${page == -1}">
                                                <!-- Dấu "..." -->
                                                <li class="page-item disabled"><a class="page-link">...</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item ${page == currentPage ? 'active' : ''}">
                                                    <a class="page-link" href="javascript:void(0)" onclick="changePage(${page})">${page}</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>

                                    <!-- Nút Next -->
                                    <c:if test="${currentPage < pageNumbers[pageNumbers.size() - 1]}">
                                        <li class="page-item">
                                            <a class="page-link" href="javascript:void(0)" onclick="changePage(${currentPage + 1})">Next</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </div>
                    </div>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    <c:if test="${not empty success}">
    Swal.fire({
        icon: 'success',
        title: 'Thành công!',
        text: '${success}',
        confirmButtonText: 'OK'
    });
    </c:if>
    <c:if test="${not empty error}">
    Swal.fire({
        icon: 'error',
        title: 'Lỗi!',
        text: '${error}',
        confirmButtonText: 'OK'
    });
    </c:if>
    function changePage(page) {
        let currentUrl = new URL(window.location.href);

        // Loại bỏ các tham số không cần thiết
        currentUrl.searchParams.delete('success');
        currentUrl.searchParams.delete('error');

        // Cập nhật tham số `page` và `size`
        currentUrl.searchParams.set('page', page);
        currentUrl.searchParams.set('size', '${pageSize}');

        // Chuyển hướng đến URL mới
        window.location.href = currentUrl.toString();
    }
</script>
</body>
</html>