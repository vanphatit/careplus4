<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách Review</title>
</head>
<body>
<h1>Danh sách Review</h1>
<table border="1">
    <thead>
    <tr>
        <th>ID</th>
        <th>Người dùng</th>
        <th>Hoá đơn</th>
        <th>Ngày</th>
        <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="review" items="${reviewPage.content}">
        <tr>
            <td>${review.id}</td>
            <td>${review.user.name}</td>
            <td>${review.bill.id}</td>
            <td><fmt:formatDate value="${review.date}" pattern="dd/MM/yyyy"/></td>
            <td>
                <a href="/vendor/reviews/${review.id}">Chi tiết</a> |
                <a href="/vendor/reviews/${review.id}/delete">Xóa</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div>
    <c:if test="${not empty pageNumbers}">
        <ul>
            <c:forEach var="page" items="${pageNumbers}">
                <li><a href="?page=${page}&size=${reviewPage.size}">${page}</a></li>
            </c:forEach>
        </ul>
    </c:if>
</div>
</body>
</html>
