<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<body class="sb-nav-fixed">
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Quản lý danh mục</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Danh mục</li>
                </ol>
                <div class="mt-5">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <div class="d-flex justify-content-between">
                                <h3>Danh sách danh mục</h3>
                                <div class="d-flex align-items-center">
                                    <form action="/admin/category/search" method="get" class="form-inline">
                                        <input type="text" name="name" placeholder="Tên danh mục" value="${name}" class="form-control"/>
                                        <button type="submit" class="btn btn-dark mx-2">Tìm kiếm</button>
                                    </form>
                                </div>
                                <a href="/admin/category/create" class="btn btn-outline-info">Tạo mới</a>
                            </div>

                            <hr />
                            <table class=" table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>Mã</th>
                                    <th>Tên danh mục</th>
                                    <th>Trạng thái</th>
                                    <th>Loại</th>
                                    <th>Xử lý</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="category" items="${categories}">
                                    <tr>
                                        <th>${category.id}</th>
                                        <td>${category.name}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${category.status}">
                                                    Hoạt động
                                                </c:when>
                                                <c:otherwise>
                                                    Ngưng
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${category.parentCategory.id}</td>
                                        <td>
                                            <a href="/admin/category/${category.id}"
                                               class="btn btn-success">Chi tiết</a>
                                            <a href="/admin/category/update/${category.id}"
                                               class="btn btn-warning mx-2">Cập nhật</a>
                                            <a href="/admin/category/delete/${category.id}"
                                               class="btn btn-danger">Xóa</a>
                                        </td>
                                    </tr>

                                </c:forEach>

                                </tbody>
                            </table>
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="/admin/categories?page=${currentPage-1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <c:forEach begin="1" end="${pageNo}" var="i">
                                        <c:choose>
                                            <c:when test="${currentPage == i}">
                                                <li class="page-item active">
                                                    <a class="page-link" href="/admin/categories?page=${i}">${i}</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item">
                                                    <a class="page-link" href="/admin/categories?page=${i}">${i}</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <li class="page-item ${currentPage == pageNo ? 'disabled' : ''}">
                                        <a class="page-link" href="/admin/categories?page=${currentPage + 1}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                            <span class="sr-only">Next</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
</body>

</html>