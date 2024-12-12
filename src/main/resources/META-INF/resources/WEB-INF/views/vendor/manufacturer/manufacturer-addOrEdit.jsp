<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>

<div class="container">

    <!-- Breadcrumb Section -->
    <h1 class="mt-4">Quản lý Nhà Sản Xuất</h1>
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
        <li class="breadcrumb-item active"> <a href="/admin/units"> Nhà Sản Xuất</a></li>
        <li class="breadcrumb-item active">${manufacturer.isEdit ? 'Chỉnh sửa Nhà Sản Xuất' : 'Thêm mới Nhà Sản Xuất'}</li>
    </ol>

    <div class="form-container">
        <h1>${manufacturer.isEdit ? 'Chỉnh sửa Nhà Sản Xuất' : 'Thêm mới Nhà Sản Xuất'}</h1>

        <!-- Thông báo lỗi -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            <c:if test="${not empty message}">
            Swal.fire({
                icon: 'success',
                title: 'Thành công!',
                text: '${message}',
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
        </script>

        <!-- Form -->
        <form action="/vendor/manufacturer/save" method="post">
            <div class="mb-3">
                <c:if test="${manufacturer.isEdit}">
                    <input type="text" class="form-control" name="id" id="id" value="${manufacturer.id}" hidden="hidden" />
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
