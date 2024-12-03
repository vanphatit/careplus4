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
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center mb-4">${imp.id == null ? 'Thêm phiếu nhập mới' : 'Chỉnh sửa phiếu nhập'}</h1>

    <form method="post" action="${pageContext.request.contextPath}/vendor/import/save" class="shadow p-4 rounded bg-light">
        <!-- Import ID -->
        <div class="mb-3">
            <label for="id" class="form-label">Mã ID phiếu nhập</label>
            <input
                    type="text"
                    class="form-control"
                    id="id"
                    name="id"
                    value="${imp.id}"
            ${imp.id != null ? 'readonly' : ''}
                    required
            />
        </div>

        <!-- Provider -->
        <div class="mb-3">
            <label for="providerId" class="form-label">Tên nhà cung cấp</label>
            <select id="providerId" name="providerId" class="form-select" required>
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
            <label for="date" class="form-label">Ngày nhập</label>
            <input
                    type="date"
                    class="form-control"
                    id="date"
                    name="date"
                    value="${imp.date}"
                    required
            />
        </div>

        <!-- Total Amount -->
        <div class="mb-3">
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
