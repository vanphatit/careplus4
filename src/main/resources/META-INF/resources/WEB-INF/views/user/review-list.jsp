<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách đánh giá của bạn</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .review-section {
            margin-bottom: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .pagination {
            margin-top: 20px;
            text-align: center;
        }
        .pagination a {
            margin: 0 5px;
            text-decoration: none;
            padding: 5px 10px;
            border: 1px solid #ccc;
        }
        .pagination a.active {
            font-weight: bold;
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<h1>Danh sách đánh giá của bạn</h1>

<!-- Lặp qua danh sách Review -->
<c:forEach var="review" items="${reviews}">
    <div class="review-section">
        <!-- Thông tin Review -->
        <h2>Hóa đơn: ${review.bill.id}</h2>
        <a href="/user/${user.phoneNumber}/review/${review.bill.id}/delete"
           onclick="return confirm('Bạn có chắc chắn muốn xóa đánh giá này?')">Xoá</a>
        <p><strong>Ngày đánh giá:</strong> ${review.date}</p>

        <!-- Hiển thị danh sách ReviewDetail -->
        <table>
            <thead>
            <tr>
                <th>Sản phẩm</th>
                <th>Điểm đánh giá</th>
                <th>Bình luận</th>
            </tr>
            </thead>
            <tbody>
            <!-- Lấy danh sách ReviewDetail từ reviewDetailsMap -->
            <c:forEach var="detail" items="${reviewDetailsMap[review]}">
                <tr>
                    <td>${detail.medicine.name}</td>
                    <td>${detail.rating}</td>
                    <td>${detail.text}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</c:forEach>

<!-- Phân trang -->
<div class="pagination">
    <c:if test="${totalPages > 0}">
        <c:forEach var="i" begin="0" end="${totalPages - 1}">
            <a href="?page=${i}&size=${size}" class="${i == currentPage ? 'active' : ''}">
                    ${i + 1}
            </a>
        </c:forEach>
    </c:if>
</div>

<a href="/home">Quay lại</a>
</body>
</html>