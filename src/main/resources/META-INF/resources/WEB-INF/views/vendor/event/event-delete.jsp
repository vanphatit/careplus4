<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Xóa Sự Kiện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="bg-light">
<div class="container mt-5">
    <h1 class="text-center text-danger mb-4">Xóa Sự Kiện</h1>
    <p class="text-center">Bạn có chắc chắn muốn xóa sự kiện này?</p>

    <div class="card shadow-sm">
        <div class="card-body">
            <table class="table table-bordered">
                <tr>
                    <th>ID:</th>
                    <td>${event.id}</td>
                </tr>
                <tr>
                    <th>Tên:</th>
                    <td>${event.name}</td>
                </tr>
                <tr>
                    <th>Ngày bắt đầu:</th>
                    <td>${event.dateStart}</td>
                </tr>
                <tr>
                    <th>Ngày kết thúc:</th>
                    <td>${event.dateEnd}</td>
                </tr>
                <tr>
                    <th>Giảm giá:</th>
                    <td>${event.discount}</td>
                </tr>
            </table>
        </div>
    </div>

    <div class="d-flex justify-content-between mt-4">
        <!-- Form xác nhận xóa -->
        <form action="${pageContext.request.contextPath}/vendor/event/delete/${event.id}" method="post">
            <button type="submit" class="btn btn-danger"><i class="fas fa-trash"></i> Xác nhận</button>
        </form>
        <!-- Nút hủy -->
        <a href="${pageContext.request.contextPath}/vendor/event" class="btn btn-secondary"><i class="fas fa-times"></i> Hủy</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
