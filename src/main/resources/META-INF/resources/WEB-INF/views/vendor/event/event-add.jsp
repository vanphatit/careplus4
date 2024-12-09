<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>${eve.id == null ? 'Thêm sự kiện mới' : 'Chỉnh sửa sự kiện'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="bg-light">
<div class="container mt-5">
    <h1 class="text-center mb-4">${eve.id == null ? 'Thêm sự kiện mới' : 'Chỉnh sửa sự kiện'}</h1>

    <div class="card shadow-sm">
        <div class="card-body">
            <form:form modelAttribute="eve" method="post" action="${pageContext.request.contextPath}/vendor/event/save">
                <input type="hidden" name="isEdit" value="${eve.isEdit}">
                <!-- ID -->
                <div class="mb-3">
                    <c:if test="${eve.isEdit}">
                        <label for="id" class="form-label">ID:</label>
                        <input
                                type="text"
                                class="form-control"
                                id="id"
                                name="id"
                                value="${eve.id}" readonly
                        />
                    </c:if>
                </div>

                <!-- Name -->
                <div class="mb-3">
                    <form:label path="name" class="form-label">Tên sự kiện:</form:label>
                    <form:input path="name" class="form-control" />
                </div>

                <!-- Start Date -->
                <div class="mb-3">
                    <form:label path="dateStart" class="form-label">Ngày bắt đầu:</form:label>
                    <form:input path="dateStart" type="date" class="form-control" />
                </div>

                <!-- End Date -->
                <div class="mb-3">
                    <form:label path="dateEnd" class="form-label">Ngày kết thúc:</form:label>
                    <form:input path="dateEnd" type="date" class="form-control" />
                </div>

                <!-- Discount -->
                <div class="mb-3">
                    <form:label path="discount" class="form-label">Giảm giá (%):</form:label>
                    <form:input path="discount" class="form-control" />
                </div>

                <!-- Buttons -->
                <div class="d-flex justify-content-between">
                    <!-- Nút lưu -->
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Lưu</button>
                    <!-- Nút quay lại -->
                    <a href="${pageContext.request.contextPath}/vendor/event" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Quay lại</a>
                </div>
            </form:form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.querySelector("form");
        const startDateInput = document.querySelector("[name='dateStart']");
        const endDateInput = document.querySelector("[name='dateEnd']");
        const saveButton = form.querySelector("[type='submit']");

        form.addEventListener("submit", function (event) {
            const startDate = new Date(startDateInput.value);
            const endDate = new Date(endDateInput.value);

            // Kiểm tra nếu "Ngày kết thúc" không sau "Ngày bắt đầu"
            if (endDate <= startDate) {
                event.preventDefault(); // Ngăn form gửi đi
                alert("Ngày kết thúc phải sau ngày bắt đầu!");
            }
        });
    });
</script>
</body>
</html>
