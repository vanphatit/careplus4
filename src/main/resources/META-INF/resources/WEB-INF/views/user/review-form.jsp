<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đánh giá hóa đơn</title>
    <script>
        // Kiểm tra dữ liệu trước khi gửi
        function validateForm() {
            const ratings = document.querySelectorAll('input[type="number"]');
            const comments = document.querySelectorAll('textarea');
            for (let i = 0; i < ratings.length; i++) {
                if (ratings[i].value < 1 || ratings[i].value > 5) {
                    alert("Vui lòng nhập điểm đánh giá từ 1 đến 5 cho sản phẩm!");
                    return false;
                }
                if (comments[i].value.trim() === "") {
                    alert("Vui lòng nhập bình luận cho tất cả các sản phẩm!");
                    return false;
                }
            }
            return true;
        }
    </script>
</head>
<body>
<h1>Đánh giá hóa đơn</h1>
<h2>Chi tiết hóa đơn</h2>
<table border="1">
    <thead>
    <tr>
        <th>Sản phẩm</th>
        <th>Đánh giá (1-5)</th>
        <th>Bình luận</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="medicine" items="${medicines}" varStatus="status">
        <form method="post" action="/user/${user.phoneNumber}/review/${bill.id}" onsubmit="return validateForm()">
            <tr>
                <td>${medicine.name}</td>
                <td>
                    <!-- Ẩn ID sản phẩm -->
                    <input type="hidden" name="medicineId" value="${medicine.id}">
                    <input type="number" name="rating" min="1" max="5" required>
                </td>
                <td>
                    <textarea name="comment" rows="3" cols="30" required></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <input type="submit" value="Đánh giá">
                </td>
        </form>
    </c:forEach>
    </tbody>
</table>

<a href="/user/${user.phoneNumber}/reviews">Quay lại</a>
</body>
</html>