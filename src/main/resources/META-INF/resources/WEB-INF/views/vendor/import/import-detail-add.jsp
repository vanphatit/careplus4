<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Thêm phiếu nhập chi tiết</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center mb-4">${detail.importDetailId == null ? 'Thêm' : 'Cập nhật'} phiếu nhập chi tiết</h1>
    <h4 class="text-center">Dành cho phiếu nhập có mã là: <strong>${importId}</strong></h4>

    <!-- Ghi chú -->
    <c:if test="${medicineId == null}">
        <div class="alert alert-info mt-4" role="alert">
            <p class="mb-0 text-center">
                <i class="fas fa-info-circle"></i>
                <strong>Ghi chú:</strong> Cần thêm thuốc mới trước khi thêm phiếu nhập chi tiết của nó.
            </p>
            <div class="d-flex justify-content-center mt-3">
                <a href="${pageContext.request.contextPath}/vendor/medicine/add?importId=${importId}" class="btn btn-success d-flex align-items-center justify-content-center">
                    <i class="fas fa-plus me-2"></i> Thêm thuốc mới
                </a>
            </div>
        </div>
    </c:if>

    <!-- Form thêm Import Detail -->
    <c:if test="${detail.importDetailId == null}">
        <form action="${pageContext.request.contextPath}/vendor/import-detail/save-detail/${importId}" method="post" class="mt-4">
            <div class="mb-3">
                <input type="text" hidden="hidden" id="medicineId" name="medicineId" class="form-control" value="${medicineId}" required>
            </div>
            <div class="mb-3">
                <label for="quantity" class="form-label">Số lượng</label>
            <input type="number" id="quantity" name="quantity" class="form-control" value="${detail.quantity}" required>
            </div>
            <div class="mb-3">
                <label for="unitPrice" class="form-label">Đơn giá</label>
                <input type="number" id="unitPrice" name="unitPrice" class="form-control" value="${detail.unitPrice}" step="0.01" required>
            </div>
            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Lưu</button>
                <a href="${pageContext.request.contextPath}/vendor/import" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Quay lại</a>
            </div>
        </form>
    </c:if>

    <!-- Form cập nhật Import Detail -->
    <c:if test="${detail.importDetailId != null}">
        <form action="${pageContext.request.contextPath}/vendor/import-detail/edit-detail/${detail.importDetailId}" method="post" class="mt-4">
            <input type="hidden" id="importId" name="importId" value="${importId}">
            <div class="mb-3">
                <c:if test="${medicineId == null}">
                    <input type="text" readonly id="medicineId" name="medicineId" class="form-control" value="${detail.medicineId}" required>
                </c:if>
                <c:if test="${medicineId != null}">
                    <input type="text" readonly id="medicineId" name="medicineId" class="form-control" value="${medicineId}" required>
                </c:if>
            </div>
            <div class="mb-3">
                <label for="quantity" class="form-label">Số lượng</label>
                <input type="number" id="quantity" name="quantity" class="form-control" value="${detail.quantity}" required>
            </div>
            <div class="mb-3">
                <label for="unitPrice" class="form-label">Đơn giá</label>
                <input type="number" id="unitPrice" name="unitPrice" class="form-control" value="${detail.unitPrice}" step="0.01" required>
            </div>
            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Lưu</button>
                <a href="${pageContext.request.contextPath}/vendor/import/show/${importId}" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Quay lại</a>
            </div>
        </form>
    </c:if>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
