<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>

<style>
    .search-bar {
        display: flex;
        align-items: center; /* Căn giữa theo chiều dọc */
        justify-content: center; /* Căn giữa theo chiều ngang */
        gap: 10px; /* Khoảng cách giữa các phần tử */
        margin-bottom: 20px;
    }

    .search-bar input {
        flex: 1; /* Input chiếm hết chiều rộng còn lại */
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
    }

    .search-bar button {
        padding: 8px 15px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        transition: 0.3s;
    }

    .search-bar button:hover {
        background-color: #0056b3;
    }

    .d-flex.align-items-center h2 {
        font-size: 1.5rem;
        font-weight: bold;
    }

    .d-flex.align-items-center .btn {
        font-size: 0.875rem;
        padding: 0.5rem 1rem;
    }
</style>

<div class="container">

    <!-- Breadcrumb Section -->
    <h1 class="mt-4">Quản lý Nhà Sản Xuất</h1>
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
        <li class="breadcrumb-item active">Nhà Sản Xuất</li>
    </ol>

    <div class="table-container">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div class="d-flex align-items-center">
                <h2 class="me-3 mb-0 text-primary" style="margin: 0 20px">Danh sách Nhà Sản Xuất</h2>
                <a href="/vendor/manufacturer/add" class="btn btn-success btn-sm d-flex align-items-center">
                    <i class="fas fa-plus me-1"></i> Thêm mới
                </a>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-8">
                <form action="/vendor/manufacturer/search" method="get" class="search-bar d-flex">
                    <input type="text" id="search" name="name" placeholder="Tìm kiếm theo tên" class="form-control">
                    <button type="submit" class="btn btn-primary" style="margin: 3px 10px">Search</button>
                </form>
            </div>
        </div>

        <!-- Table -->
        <div class="table-responsive shadow-sm rounded">
            <table class="table table-striped table-hover table-bordered">
                <thead class="table-primary">
                <tr>
                    <th class="text-center" style="width: 15%;">ID</th>
                    <th style="width: 60%;">Tên</th>
                    <th class="text-center" style="width: 25%;">Hành động</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach var="manufacturer" items="${manufacturers.content}">
                        <tr>
                            <td class="text-center">${manufacturer.id}</td>
                            <td>${manufacturer.name}</td>
                            <td class="text-center">
                                <div class="d-flex justify-content-center gap-2">
                                    <a href="<c:url value='/vendor/manufacturer/${manufacturer.id}'/>" style="margin: 0 10px"
                                       class="btn btn-info btn-sm text-white">Chi tiết</a>
                                    <a href="javascript:void(0);"
                                       class="btn btn-warning btn-sm"
                                       style="margin: 0 10px"
                                       onclick="confirmEditWithSweetAlert('${manufacturer.id}', '${manufacturer.name}');">Sửa</a>
                                    <a href="javascript:void(0);"
                                       class="btn btn-danger btn-sm"
                                       style="margin: 0 10px"
                                       onclick="confirmDeleteWithSweetAlert('${manufacturer.id}', '${manufacturer.name}');">Xóa</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <div class="pagination text-center">
            <c:if test="${not empty pageNumbers}">
                <nav>
                    <ul class="pagination justify-content-center">
                        <c:forEach var="page" items="${pageNumbers}">
                            <li class="page-item">
                                <a class="page-link" href="<c:url value='/vendor/manufacturers?page=${page}&size=${pageSize}'/>">${page}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </nav>
            </c:if>
        </div>
    </div>
</div>

<!-- Thông báo -->
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

<script>
    function confirmDeleteWithSweetAlert(id, name) {
        Swal.fire({
            title: 'Bạn có chắc chắn muốn xóa?',
            text: "Nhà sản xuất: " + name,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Xóa',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "/vendor/manufacturer/delete/" + id;
            }
        });
    }

    function confirmEditWithSweetAlert(id, name) {
        Swal.fire({
            title: 'Bạn có chắc chắn muốn sửa?',
            text: "Nhà sản xuất: " + name,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Sửa',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "/vendor/manufacturer/edit/" + id;
            }
        });
    }
</script>