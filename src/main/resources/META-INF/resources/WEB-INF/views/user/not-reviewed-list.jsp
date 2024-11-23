<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Hóa đơn chưa được đánh giá</title>
</head>
<body>
<h1>Danh sách hóa đơn chưa đánh giá</h1>
<table border="1">
    <thead>
    <tr>
        <th>Ngày hóa đơn</th>
        <th>Tổng tiền</th>
        <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="bill" items="${bills}">
        <tr>
            <td><fmt:formatDate value="${bill.date}" pattern="dd/MM/yyyy"/></td>
            <td>${bill.totalAmount}</td>
            <td><a href="/user/${id}/review/${bill.id}">Đánh giá</a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>