<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>


<div class="container">
    <div class="detail-container">
        <h1>Chi tiết Nhà Sản Xuất</h1>

        <!-- Hiển thị thông báo thành công -->
        <c:if test="${not empty message}">
            <div class="alert alert-success" role="alert">
                    ${message}
            </div>
        </c:if>

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