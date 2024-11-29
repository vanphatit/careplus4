<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết Review</title>
</head>
<body>
<h1>Chi tiết Review</h1>
<p><b>Người dùng:</b> ${review.user.name}</p>
<p><b>Hoá đơn số:</b> ${review.bill.id}</p>
<h2>Chi tiết Review</h2>
<table border="1">
    <thead>
    <tr>
        <th>Sản phẩm</th>
        <th>Đánh giá</th>
        <th>Bình luận</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="detail" items="${reviewDetails}">
        <tr>
            <td>${detail.medicine.name}</td>
            <td>${detail.rating}</td>
            <td>${detail.text}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<a href="/vendor/reviews">Quay lại</a>
</body>
</html>