<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Import Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="bg-light">
<div class="container mt-5">
    <h1 class="text-center mb-4">Một số thông tin về phiếu nhập</h1>

    <!-- Hiển thị thông tin chung về Import -->
    <c:choose>
        <c:when test="${importEntity != null}">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Thông tin phiếu nhập</h5>
                </div>
                <div class="card-body">
                    <table class="table table-bordered">
                        <tr>
                            <th>Mã ID phiếu nhập</th>
                            <td>${importEntity.id}</td>
                        </tr>
                        <tr>
                            <th>Mã ID nhà cung cấp</th>
                            <td>${importEntity.provider.id}</td>
                        </tr>
                        <tr>
                            <th>Tên nhà cung cấp</th>
                            <td>${importEntity.provider.name}</td>
                        </tr>
                        <tr>
                            <th>Ngày nhập</th>
                            <td><fmt:formatDate value="${importEntity.date}" pattern="yyyy-MM-dd" /></td>
                        </tr>
                        <tr>
                            <th>Tổng thanh toán</th>
                            <td><fmt:formatNumber value="${importEntity.totalAmount}" type="number" groupingUsed="true" /></td>
                        </tr>
                    </table>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-warning text-center" role="alert">
                No import details available.
            </div>
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/vendor/import" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to List</a>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Hiển thị danh sách chi tiết ImportDetail -->
    <c:choose>
        <c:when test="${importDetails != null}">
            <h2 class="text-center my-4">Danh sách phiếu nhập chi tiết</h2>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-primary">
                    <tr>
                        <th>STT</th>
                        <th>Mã thuốc</th>
                        <th>Tên thuốc</th>
                        <th>Số lượng</th>
                        <th>Đơn giá</th>
                        <th>Thanh toán</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="detail" items="${importDetails}" varStatus="iter">
                        <tr>
                            <td>${iter.index + 1}</td>
                            <td>${detail.medicine.id}</td>
                            <td>${detail.medicine.name}</td>
                            <td>${detail.quantity}</td>
                            <td>
                                <fmt:formatNumber value="${detail.unitPrice}" type="number" groupingUsed="true" />
                            </td>
                            <td>
                                <fmt:formatNumber value="${detail.subTotal}" type="number" groupingUsed="true" />
                            </td>
                            <td>
                                <button class="btn btn-danger btn-sm" onclick="confirmDelete(${detail.id});">
                                    <i class="fas fa-trash"></i> Xóa
                                </button>
                                <button class="btn btn-warning btn-sm" onclick="confirmEdit(${detail.id});">
                                    <i class="fas fa-edit"></i> Sửa
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-warning text-center" role="alert">
                No import items found for this import.
            </div>
        </c:otherwise>
    </c:choose>

    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/vendor/import" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Quay lại</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    // Kiểm tra nếu có message
    <c:if test="${not empty message}">
    Swal.fire({
        icon: 'success',
        title: 'Thành công!',
        text: '${message}',
        confirmButtonText: 'OK'
    });
    </c:if>

    // Kiểm tra nếu có error
    <c:if test="${not empty error}">
    Swal.fire({
        icon: 'error',
        title: 'Lỗi!',
        text: '${error}',
        confirmButtonText: 'OK'
    });
    </c:if>
</script>
<script>
    function confirmDelete(id) {
        Swal.fire({
            title: 'Bạn có chắc chắn?',
            text: "Hành động này không thể hoàn tác!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Xóa',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                // Chuyển hướng tới URL xóa
                window.location.href = `/vendor/import-detail/delete-detail/` + id;
            }
        });
    }

    function confirmEdit(id) {
        Swal.fire({
            title: 'Bạn có chắc chắn?',
            text: "Hành động này không thể hoàn tác!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sửa',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                // Chuyển hướng tới URL sửa
                window.location.href = `/vendor/import-detail/edit-detail/` + id;
            }
        });
    }
</script>

</body>
</html>
