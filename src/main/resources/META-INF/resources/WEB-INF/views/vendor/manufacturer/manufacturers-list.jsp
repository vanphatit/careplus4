<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>

<style>
    .search-bar {
        display: flex;
        align-items: center; /* Căn giữa theo chiều dọc */
        justify-content: center; /* Căn giữa theo chiều ngang */
        gap: 10px; /* Khoảng cách giữa các phần tử */
        margin-bottom: 20px;
    }

    .search-bar input {
        flex: 1; /* Input chiếm hết chiều rộng còn lại */
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
    }

    .search-bar button {
        padding: 8px 15px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        transition: 0.3s;
    }

    .search-bar button:hover {
        background-color: #0056b3;
    }
</style>

<div class="container">
    <div class="table-container">
        <h1 class="text-center text-primary">Danh sách Nhà Sản Xuất</h1>

        <!-- Search Bar -->
        <div class="search-bar d-flex justify-content-center align-items-center gap-2 mb-4">
            <form action="/vendor/manufacturer/search" method="get" class="d-flex w-100">
                <input type="text" name="name" class="form-control" placeholder="Tìm kiếm theo tên..." />
                <button type="submit" class="btn btn-primary">Tìm kiếm</button>
            </form>
        </div>

        <!-- Add Button -->
        <div class="text-center">
            <a href="<c:url value='/vendor/manufacturer/add'/>" class="btn btn-add">Thêm mới Nhà Sản Xuất</a>
        </div>

        <!-- Thông báo -->
        <c:if test="${not empty message}">
            <div class="alert alert-warning" role="alert">
                    ${message}
            </div>
        </c:if>

        <!-- Table -->
        <table class="table table-striped table-hover">
            <thead class="table-primary">
            <tr>
                <th class="text-center">ID</th>
                <th>Tên</th>
                <th class="text-center">Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="manufacturer" items="${manufacturers.content}">
                <tr>
                    <td class="text-center">${manufacturer.id}</td>
                    <td>${manufacturer.name}</td>
                    <td class="text-center">
                        <a href="<c:url value='/vendor/manufacturer/${manufacturer.id}'/>" class="btn btn-info btn-sm btn-action">Chi tiết</a>
                        <a href="<c:url value='/vendor/manufacturer/edit/${manufacturer.id}'/>" class="btn btn-warning btn-sm btn-action">Sửa</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <!-- Pagination -->
        <div class="pagination text-center">
            <c:if test="${not empty pageNumbers}">
                <nav>
                    <ul class="pagination justify-content-center">
                        <c:forEach var="page" items="${pageNumbers}">
                            <li class="page-item">
                                <a class="page-link" href="<c:url value='/vendor/manufacturers?page=${page}&size=${pageSize}'/>">${page}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </nav>
            </c:if>
        </div>
    </div>
</div>