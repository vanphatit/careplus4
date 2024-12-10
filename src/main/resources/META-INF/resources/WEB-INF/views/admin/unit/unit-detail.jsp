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
            <h1 class="h4">Chi tiết Đơn vị</h1>
        </div>
        <div class="card-body">
            <p><strong>Mã đơn vị:</strong> ${unit.id}</p>
            <p><strong>Tên đơn vị:</strong> ${unit.name}</p>
        </div>
        <div class="card-footer text-center">
            <a href="javascript:void(0);"
               class="btn btn-warning"
               onclick="confirmEditWithSweetAlert('${unit.id}', '${unit.name}');">Sửa</a>
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
            <c:if test="${not empty error}">
            Swal.fire({
                icon: 'error',
                title: 'Thất bại!',
                text: '${error}',
                confirmButtonText: 'OK'
            });
            </c:if>

            function confirmEditWithSweetAlert(id, name) {
                Swal.fire({
                    title: 'Bạn có chắc chắn muốn sửa đơn vị này?',
                    text: "Đơn vị: " + name,
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Sửa'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = "${URL}admin/unit/edit/" + id;
                    }
                });
            }
        </script>
    </div>
</div>