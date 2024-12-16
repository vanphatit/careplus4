<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>${imp.id == null ? 'Add New Import' : 'Edit Import'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        .custom-select {
            width: 25%;
            margin: 0 auto; /* Căn giữa */
            font-size: 16px;
            border-radius: 8px; /* Bo góc */
            padding: 8px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Hiệu ứng đổ bóng */
            background-color: #f9f9f9; /* Màu nền nhạt */
            transition: all 0.3s ease-in-out;
        }

        .custom-select:hover {
            border-color: #007bff; /* Đổi màu viền khi hover */
            background-color: #ffffff; /* Màu nền khi hover */
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <!-- Breadcrumb Section -->
    <h1 class="mt-4">Quản lý Phiếu nhập</h1>
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
        <li class="breadcrumb-item active"><a href="${pageContext.request.contextPath}/vendor/import">Danh sách phiếu nhập</a></li>
        <li class="breadcrumb-item active">${imp.id == null ? 'Thêm phiếu nhập mới ' : 'Chỉnh sửa phiếu nhập'}</li>
    </ol>

    <h3 class="text-center mb-4">${imp.id == null ? 'Thêm phiếu nhập mới' : 'Chỉnh sửa phiếu nhập'}</h3>

    <form method="post" action="${pageContext.request.contextPath}/vendor/import/save" class="shadow p-4 rounded bg-light">
        <!-- Import ID -->
        <div class="mb-3">
            <c:if test="${imp.id != null}">
                <label for="id" class="form-label">Mã phiếu nhập</label>
                <input
                        type="text"
                        class="form-control"
                        id="id"
                        name="id"
                        value="${imp.id}"
                        readonly
                />
            </c:if>
            <c:if test="${imp.id == null}">
                <input
                        type="text"
                        class="form-control"
                        id="id"
                        name="id"
                        value=""
                        hidden="hidden"
                />
            </c:if>
        </div>

        <!-- Provider -->
        <div class="col-md-4 mb-3">
            <label for="providerId" class="form-label"><strong>Tên nhà cung cấp</strong></label>
            <select id="providerId" name="providerId" class="form-select custom-select" required>
                <c:forEach var="provider" items="${providers}">
                    <option value="${provider.id}"
                        ${imp.providerId != null && provider.id == imp.providerId ? 'selected' : ''}>
                            ${provider.id} - ${provider.name}
                    </option>
                </c:forEach>
            </select>
        </div>

        <!-- Import Date -->
        <div class="mb-3">
            <c:if test="${imp.id != null}">
                <label for="date" class="form-label">Ngày nhập</label>
                <input
                        type="date"
                        class="form-control"
                        id="date"
                        name="date"
                        value="${imp.date}"
                        required
                />
            </c:if>
            <c:if test="${imp.id == null}">
                <input
                        type="date"
                        class="form-control"
                        id="date"
                        name="date"
                        value="${now}"
                        required
                        hidden="hidden"
                />
            </c:if>
        </div>

        <!-- Total Amount -->
        <div class="mb-3">
            <c:if test="${imp.id != null}">
                <label for="totalAmount" class="form-label">Tổng thanh toán</label>
                <input
                        type="number"
                        class="form-control"
                        id="totalAmount"
                        name="totalAmount"
                        value="${imp.totalAmount}"
                        step="0.01"
                        required
                />
            </c:if>
            <c:if test="${imp.id == null}">
                <input
                        type="number"
                        class="form-control"
                        id="totalAmount"
                        name="totalAmount"
                        value="0"
                        step="0.01"
                        hidden="hidden"
                />
            </c:if>
        </div>

        <!-- Action Buttons -->
        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Lưu</button>
            <a href="${pageContext.request.contextPath}/vendor/import" class="btn btn-secondary"><i class="fas fa-times"></i> Hủy</a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
