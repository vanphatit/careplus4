<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Danh sách Import</title>
    <link rel="stylesheet" href="/resources/css/style.css"> <!-- Đường dẫn tới CSS -->
</head>
<body>
<div class="container">
    <h1>Danh sách Import</h1>

    <!-- Thông báo lỗi hoặc thành công -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <!-- Thanh tìm kiếm -->
    <form action="/vendor/import/searchpaginated" method="get" class="form-inline">
        <input type="text" name="id" placeholder="Tìm theo ID Import" value="${id}" class="form-control"/>
        <input type="text" name="providerId" placeholder="Tìm theo ID Provider" value="${providerId}" class="form-control"/>
        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
    </form>

    <!-- Bảng danh sách Import -->
    <table class="table table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>Provider</th>
            <th>Ngày nhập</th>
            <th>Tổng tiền</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="imp" items="${imports}">
            <tr>
                <td>${imp.id}</td>
                <td>${imp.provider.name}</td>
                <td><fmt:formatDate value="${imp.date}" pattern="yyyy-MM-dd"/></td>
                <td><fmt:formatNumber value="${imp.totalAmount}" pattern="#,###"/></td>
                <td>
                    <a href="/vendor/import/show/${imp.id}" class="btn btn-info">Chi tiết</a>
                    <a href="/vendor/import/edit/${imp.id}" class="btn btn-warning">Sửa</a>
                    <a href="/vendor/import/delete/${imp.id}" class="btn btn-danger"
                       onclick="return confirm('Bạn có chắc chắn muốn xóa?');">Xóa</a>
                    <a href="/vendor/import-detail/add-detail/${imp.id}" class="btn btn-success">Add Detail</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty importList}">
            <tr>
                <td colspan="5" class="text-center">Không có bản ghi nào</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <!-- Phân trang -->
    <c:if test="${not empty pageNumbers}">
        <nav>
            <ul class="pagination">
                <c:forEach var="pageNumber" items="${pageNumbers}">
                    <li class="page-item ${pageNumber == importPage.number + 1 ? 'active' : ''}">
                        <a class="page-link" href="/vendor/import?page=${pageNumber}">${pageNumber}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </c:if>

    <!-- Nút thêm mới -->
    <a href="/vendor/import/add" class="btn btn-success">Thêm Import mới</a>
    <a href="/vendor/medicine/add" class="btn btn-success">Thêm Medicine mới</a>
</div>
</body>
</html>
