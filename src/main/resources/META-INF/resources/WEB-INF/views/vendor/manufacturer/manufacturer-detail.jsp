<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>


<div class="container">
    <div class="detail-container">
        <h1>Chi tiết Nhà Sản Xuất</h1>

        <!-- Hiển thị thông báo thành công -->
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

        <!-- Bảng chi tiết -->
        <table class="table table-borderless">
            <tbody>
            <tr>
                <th>ID:</th>
                <td>${manufacturer.id}</td>
            </tr>
            <tr>
                <th>Tên:</th>
                <td>${manufacturer.name}</td>
            </tr>
            </tbody>
        </table>

        <!-- Nút quay lại -->
        <div class="text-center">
            <a href="/vendor/manufacturers" class="btn btn-primary">Quay lại danh sách</a>
        </div>
    </div>
</div>