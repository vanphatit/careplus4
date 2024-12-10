<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>

<div class="container mt-5">

    <!-- Breadcrumb Section -->
    <h1 class="mt-4">Quản lý Đơn vị</h1>
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
        <li class="breadcrumb-item active">Danh sách đơn vị</li>
    </ol>

    <h1 class="text-left text-primary mb-4">Danh sách đơn vị</h1>

    <!-- Search and Add Buttons -->
    <div class="row mb-4">
        <div class="col-md-8">
            <form action="/admin/unit/search" method="get" class="d-flex">
                <input type="text" id="search" name="name" placeholder="Tìm kiếm theo tên" class="form-control">
                <button type="submit" class="btn btn-primary" style="margin: 3px 10px">Search</button>
            </form>
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-md-4 text-end">
            <a href="/admin/unit/add" class="btn btn-success">Thêm đơn vị</a>
        </div>
    </div>

    <!-- Units Table -->
    <div class="table-responsive">
        <table class="table table-bordered table-striped align-middle">
            <thead class="table-primary">
            <tr>
                <th scope="col" class="text-center">Mã đơn vị</th>
                <th scope="col">Tên đơn vị</th>
                <th scope="col" class="text-center">Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${units.content}" var="unit">
                <tr>
                    <td class="text-center">${unit.id}</td>
                    <td>${unit.name}</td>
                    <td class="text-center">
                        <div class="d-flex justify-content-center gap-2">
                            <a href="<c:url value='/admin/unit/${unit.id}'/>" style="margin: 0 10px"
                               class="btn btn-info btn-sm text-white">Chi tiết</a>
                            <a href="javascript:void(0);"
                               class="btn btn-warning btn-sm"
                               style="margin: 0 10px"
                               onclick="confirmEditWithSweetAlert('${unit.id}', '${unit.name}');">Sửa</a>
                            <a href="javascript:void(0);"
                               class="btn btn-danger btn-sm"
                               style="margin: 0 10px"
                               onclick="confirmDeleteWithSweetAlert('${unit.id}', '${unit.name}');">Xóa</a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Pagination -->
    <nav>
        <ul class="pagination justify-content-center">
            <c:if test="${not empty pageNumbers}">
                <c:forEach items="${pageNumbers}" var="pageNumber">
                    <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                        <a href="/admin/units?page=${pageNumber}&size=${pageSize}" class="page-link">${pageNumber}</a>
                    </li>
                </c:forEach>
            </c:if>
        </ul>
    </nav>
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

    function confirmDeleteWithSweetAlert(id, name) {
        Swal.fire({
            title: 'Xác nhận xóa',
            text: `Bạn có chắc chắn muốn xóa đơn vị ` + name + ` không?`,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Xóa',
            cancelButtonText: 'Huỷ'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = `/admin/unit/delete/` + id;
            }
        });
    }

    function confirmEditWithSweetAlert(id, name) {
        Swal.fire({
            title: 'Xác nhận chỉnh sửa',
            text: `Bạn có chắc chắn muốn chỉnh sửa đơn vị ` + name + ` không?`,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Chỉnh sửa',
            cancelButtonText: 'Huỷ'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = `/admin/unit/edit/` + id;
            }
        });
    }
</script>
