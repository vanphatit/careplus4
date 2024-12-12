<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>


<div class="container">

    <!-- Breadcrumb Section -->
    <h1 class="mt-4">Quản lý Nhà Sản Xuất</h1>
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
        <li class="breadcrumb-item active"> <a href="/admin/units"> Nhà Sản Xuất</a></li>
        <li class="breadcrumb-item active">Chi tiết Nhà Sản Xuất</li>
    </ol>

    <div class="container mt-4">
        <div class="card shadow-lg border-0 rounded">
            <div class="card-header bg-primary text-white text-center">
                <h5>Chi tiết Nhà Sản Xuất</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <tbody>
                        <tr>
                            <th class="bg-light text-end" style="width: 30%; font-weight: bold;">ID:</th>
                            <td class="text-start">${manufacturer.id}</td>
                        </tr>
                        <tr>
                            <th class="bg-light text-end" style="width: 30%; font-weight: bold;">Tên:</th>
                            <td class="text-start">${manufacturer.name}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="text-center mt-4">
                    <a href="/vendor/manufacturers" class="btn btn-secondary px-4">
                        <i class="fas fa-arrow-left"></i> Quay lại danh sách
                    </a>
                </div>
            </div>
        </div>
    </div>
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
        title: 'Lỗi!',
        text: '${error}',
        confirmButtonText: 'OK'
    });
    </c:if>
</script>