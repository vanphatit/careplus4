<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Event List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="bg-light">
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Quản lý sự kiện</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
                    <li class="breadcrumb-item active">Sự kiện</li>
                </ol>

<div class="container mt-5">
    <h3 class="mb-4">Danh sách sự kiện</h3>

    <!-- Form tìm kiếm -->
    <div class="d-flex align-items-center gap-2 mb-3">
        <input
                type="text"
                name="name"
                class="form-control"
                placeholder="Nhập từ khóa để tìm"
                value="${param.name}"
                style="width: 250px;"
        />
        <button type="submit" class="btn btn-primary">
            <i class="fas fa-search"></i> Tìm kiếm
        </button>
    </div>

    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/vendor/event/add" class="btn btn-success"><i class="fas fa-plus"></i> Thêm sự kiện mới
        </a>
    </div>

    <!-- Kiểm tra và hiển thị danh sách sự kiện -->
    <c:choose>
        <c:when test="${empty events}">
            <div class="alert alert-warning text-center" role="alert">
                No Events Found
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead class="table-primary">
                    <tr>
                        <th>STT</th>
                        <th>Mã sự kiện</th>
                        <th>Tên sự kiện</th>
                        <th>Ngày bắt đầu</th>
                        <th>Ngày kết thúc</th>
                        <th>Chiết khấu</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="event" items="${events}" varStatus="iter">
                        <tr>
                            <td>${iter.index + 1}</td>
                            <td>${event.id}</td>
                            <td>${event.name}</td>
                            <td><fmt:formatDate value="${event.dateStart}" pattern="yyyy-MM-dd" /></td>
                            <td><fmt:formatDate value="${event.dateEnd}" pattern="yyyy-MM-dd" /></td>
                            <td>${event.discount}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/vendor/event/edit/${event.id}" class="btn btn-warning btn-sm">
                                    <i class="fas fa-edit"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/vendor/event/delete/${event.id}"
                                   onclick="return confirm('Are you sure you want to delete this event?');"
                                   class="btn btn-danger btn-sm">
                                    <i class="fas fa-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Hiển thị phân trang -->
    <c:if test="${eventPage.totalPages > 1}">
        <nav>
            <ul class="pagination justify-content-center">
                <c:forEach var="pageNumber" items="${pageNumbers}">
                    <li class="page-item ${pageNumber == eventPage.number + 1 ? 'active' : ''}">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/vendor/event/searchpaginated?name=${param.name}&id=${param.id}&date=${param.date}&size=10&page=${pageNumber}">
                                ${pageNumber}
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
