<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>

<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Quản lý người dùng</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Người dùng</li>
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
                                <h3>Danh sách người dùng</h3>
                                <div class="d-flex align-items-center">
                                    <form action="/admin/user/search" method="post" class="form-inline">
                                        <input type="text" name="searchT" placeholder="Tên người dùng hoặc số điện thoại" value="${seachText}" class="form-control"/>
                                        <button type="submit" class="btn btn-dark mx-2">Tìm kiếm</button>
                                    </form>
                                </div>
                                <a href="/admin/user/new" class="btn btn-outline-info">Tạo mới</a>
                            </div>

                            <hr />
                            <table class="table table-bordered table-hover">
                                <thead style="background-color: rgb(0, 28, 64); color: white;">
                                <tr>
                                    <th>Số điện thoại</th>
                                    <th>Tên</th>
                                    <th>Email</th>
                                    <th>Địa chỉ</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="user" items="${usersPage.content}">
                                    <tr>
                                        <td>${user.phoneNumber}</td>
                                        <td>${user.name}</td>
                                        <td>${user.email}</td>
                                        <td>${user.address}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${user.status}">
                                                    <span class="badge bg-success">Hoạt động</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">Ngưng</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="/admin/user/${user.phoneNumber}" class="btn btn-success btn-sm">Chi tiết</a>
                                            <a href="/admin/user/update/${user.phoneNumber}" class="btn btn-warning btn-sm mx-2">Cập nhật</a>
                                            <c:choose>
                                                <c:when test="${user.status}">
                                                    <a href="/admin/user/delete/${user.phoneNumber}" class="btn btn-danger btn-sm"
                                                       onclick="return confirm('Bạn có chắc chắn muốn tắt hoạt động người dùng này?')">Tắt hoạt động</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="/admin/user/activate/${user.phoneNumber}" class="btn btn-primary btn-sm"
                                                       onclick="return confirm('Bạn có chắc chắn muốn kích hoạt người dùng này?')">Kích hoạt</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                            <!-- Phân trang -->
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="/admin/users?page=${currentPage - 1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <c:forEach begin="1" end="${pageNo}" var="i">
                                        <c:choose>
                                            <c:when test="${currentPage == i}">
                                                <li class="page-item active">
                                                    <a class="page-link" href="/admin/users?page=${i}">${i}</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item">
                                                    <a class="page-link" href="/admin/users?page=${i}">${i}</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <li class="page-item ${currentPage == pageNo ? 'disabled' : ''}">
                                        <a class="page-link" href="/admin/users?page=${currentPage + 1}" aria-label="Next">
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>