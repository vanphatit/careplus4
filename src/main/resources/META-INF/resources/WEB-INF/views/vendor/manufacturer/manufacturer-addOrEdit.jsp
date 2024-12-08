<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>

<div class="container">
    <div class="form-container">
        <h1>${manufacturer.isEdit ? 'Chỉnh sửa Nhà Sản Xuất' : 'Thêm mới Nhà Sản Xuất'}</h1>

        <!-- Thông báo lỗi -->
        <c:if test="${not empty message}">
            <div class="alert alert-danger" role="alert">
                    ${message}
            </div>
        </c:if>

        <!-- Form -->
        <form action="/vendor/manufacturer/save" method="post">
            <div class="mb-3">
                <c:if test="${manufacturer.isEdit}">
                    <label for="id" class="form-label">ID:</label>
                    <input type="text" class="form-control" id="id" value="${manufacturer.id}" readonly />
                </c:if>
            </div>

            <div class="mb-3">
                <label for="name" class="form-label">Tên:</label>
                <input type="text" class="form-control" id="name" name="name" value="${manufacturer.name}" required />
            </div>

            <input type="hidden" name="isEdit" value="${manufacturer.isEdit}" />

            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-primary">${manufacturer.isEdit ? 'Cập nhật' : 'Thêm mới'}</button>
                <a href="/vendor/manufacturers" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
