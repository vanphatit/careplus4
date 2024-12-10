<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>

<div class="container mt-5">
    <!-- Breadcrumb Section -->
    <h1 class="mt-4">Quản lý Đơn vị</h1>
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
        <li class="breadcrumb-item active"> <a href="/admin/units"> Quản lý Đơn vị</a></li>
        <li class="breadcrumb-item active">Chi tiết Đơn vị</li>
    </ol>

    <div class="card mx-auto shadow-lg" style="max-width: 500px;">
        <div class="card-header text-center bg-primary text-white">
            <h1 class="h4">Unit Details</h1>
        </div>
        <div class="card-body">
            <p><strong>Unit ID:</strong> ${unit.id}</p>
            <p><strong>Unit Name:</strong> ${unit.name}</p>
        </div>
        <div class="card-footer text-center">
            <a href="/admin/unit/edit/${unit.id}" class="btn btn-warning me-2">Sửa</a>
            <a href="/admin/units" class="btn btn-secondary">Quay lại</a>
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