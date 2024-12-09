<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Quản lý Đánh giá sản phẩm</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
                    <li class="breadcrumb-item active">Danh sách Đánh giá sản phẩm</li>
                </ol>

                <!-- Hiển thị thông báo -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <div class="mt-5">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <div class="d-flex justify-content-between">
                                <h3>Danh sách Đánh giá sản phẩm</h3>
                                <form action="/vendor/reviews/search" method="post" class="form-inline">
                                    <input type="text" name="searchText" placeholder="Nhập tên người dùng..." value="${searchText}" class="form-control"/>
                                    <button type="submit" class="btn btn-dark mx-2">Tìm kiếm</button>
                                </form>
                            </div>

                            <hr />
                            <table class="table table-bordered table-hover">
                                <thead style="background-color: rgb(0, 28, 64); color: white;">
                                <tr>
                                    <th>ID</th>
                                    <th>Người dùng</th>
                                    <th>Hóa đơn</th>
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
                                            <a href="/vendor/reviews/${review.id}" class="btn btn-info btn-sm">Chi tiết</a>
                                            <a href="/vendor/reviews/${review.id}/delete" class="btn btn-danger btn-sm"
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa review này?')">Xóa</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                            <!-- Phân trang -->
                            <c:if test="${not empty pageNumbers}">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center">
                                        <c:forEach var="page" items="${pageNumbers}">
                                            <li class="page-item ${page == (reviewPage.number + 1) ? 'active' : ''}">
                                                <a class="page-link" href="?page=${page}&size=${reviewPage.size}">${page}</a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </nav>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
