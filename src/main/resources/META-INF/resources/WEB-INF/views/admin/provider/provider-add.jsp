<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>${pro.id == null ? "Thêm Nhà Cung Cấp" : "Chỉnh Sửa Nhà Cung Cấp"}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="bg-light">
<div class="container mt-5">
    <h1 class="mb-4">${pro.id == null ? "Thêm Nhà Cung Cấp" : "Chỉnh Sửa Nhà Cung Cấp"}</h1>

    <form action="${pageContext.request.contextPath}/admin/provider/save" method="post" class="shadow p-4 rounded bg-white">
        <!-- ID Field -->
<%--        <div class="mb-3">--%>
<%--            <label for="id" class="form-label">ID:</label>--%>
<%--            <input--%>
<%--                    type="text"--%>
<%--                    class="form-control"--%>
<%--                    id="id"--%>
<%--                    name="id"--%>
<%--                    value="${pro.id}"--%>
<%--            ${pro.id != null ? "readonly" : "hidden"} />--%>
<%--        </div>--%>

        <!-- Name Field -->
        <div class="mb-3">
            <label for="name" class="form-label">Tên Nhà Cung Cấp:</label>
            <input
                    type="text"
                    class="form-control"
                    id="name"
                    name="name"
                    value="${pro.name}"
                    required />
        </div>

        <!-- Address Field -->
        <div class="mb-3">
            <label for="address" class="form-label">Địa Chỉ:</label>
            <input
                    type="text"
                    class="form-control"
                    id="address"
                    name="address"
                    value="${pro.address}" />
        </div>

        <!-- Phone Field -->
        <div class="mb-3">
            <label for="phone" class="form-label">Số Điện Thoại:</label>
            <input
                    type="text"
                    class="form-control"
                    id="phone"
                    name="phone"
                    value="${pro.phone}"
                    required />
        </div>

        <!-- Buttons -->
        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-save"></i> Lưu
            </button>
            <a href="${pageContext.request.contextPath}/admin/provider" class="btn btn-secondary">
                <i class="fas fa-times"></i> Hủy
            </a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
