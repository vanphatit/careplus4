<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<body class="bg-light">
<div class="container mt-5">
    <h1 class="text-center mb-4">Xóa nhận xóa phiếu nhập</h1>

<%--    <!-- Hiển thị lỗi nếu có -->--%>
<%--    <c:if test="${not empty error}">--%>
<%--        <div class="alert alert-danger" role="alert">--%>
<%--                ${error}--%>
<%--        </div>--%>
<%--    </c:if>--%>

    <p class="text-center">Bạn có muốn xóa phiếu nhập này không?</p>

    <!-- Hiển thị thông tin Import -->
    <div class="card shadow-sm mb-4">
        <div class="card-header bg-danger text-white">
            <h5 class="mb-0">Một số thông tin về phiếu nhập</h5>
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <tr>
                    <th>Mã ID phiếu nhập</th>
                    <td>${imp.id}</td>
                </tr>
                <tr>
                    <th>Tên nhà cung cấp</th>
                    <td>${imp.provider.name}</td>
                </tr>
                <tr>
                    <th>Ngày nhập</th>
                    <td>${imp.date}</td>
                </tr>
                <tr>
                    <th>Tổng thanh toán</th>
                    <td><fmt:formatNumber value="${imp.totalAmount}" type="number" maxFractionDigits="0" /></td>
                </tr>

            </table>
        </div>
    </div>

    <!-- Form xác nhận xóa -->
    <form method="post" action="${pageContext.request.contextPath}/vendor/import/delete/${imp.id}" class="text-center">
        <c:if test="${!hasImportDetail}">
            <button type="submit" class="btn btn-danger">
                <i class="fas fa-trash"></i> Xóa
            </button>
        </c:if>
        <a href="${pageContext.request.contextPath}/vendor/import" class="btn btn-secondary">
            <i class="fas fa-times"></i> Hủy
        </a>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
