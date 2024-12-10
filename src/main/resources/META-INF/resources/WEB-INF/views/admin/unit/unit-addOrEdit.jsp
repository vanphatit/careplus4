<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>

<div class="container mt-5">

    <!-- Breadcrumb Section -->
    <h1 class="mt-4">Quản lý Đơn vị</h1>
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
        <li class="breadcrumb-item active"> <a href="/admin/units"> Quản lý Đơn vị</a></li>
        <li class="breadcrumb-item active">${unit.isEdit ? "Chỉnh sửa Đơn vị" : "Thêm Đơn vị"}</li>
    </ol>

    <div class="card mx-auto shadow-lg" style="max-width: 500px;">
        <div class="card-header bg-primary text-white text-center">
            <h1 class="h4">${unit.isEdit ? "Chỉnh sửa Đơn vị" : "Thêm Đơn vị"}</h1>
        </div>
        <div class="card-body">
            <form action="/admin/unit/save" method="post">
                <input type="hidden" name="isEdit" value="${unit.isEdit}" />

                <c:if test="${unit.isEdit}">
                    <div class="mb-3">
                        <input type="text" id="id" name="id" value="${unit.id}" class="form-control" hidden="hidden" />
                    </div>
                </c:if>

                <div class="mb-3">
                    <label for="name" class="form-label">Tên đơn vị</label>
                    <input type="text" id="name" name="name" value="${unit.name}" class="form-control" required />
                    <c:if test="${not empty errors['name']}">
                        <div class="text-danger mt-1">${errors['name']}</div>
                    </c:if>
                </div>

                <div class="d-flex justify-content-between">
                    <button type="submit" class="btn btn-primary">${unit.isEdit ? "Cập nhật" : "Thêm"}</button>
                    <a href="/admin/units" class="btn btn-secondary">Huỷ</a>
                </div>
            </form>
        </div>
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
        </script>
    </div>
</div>