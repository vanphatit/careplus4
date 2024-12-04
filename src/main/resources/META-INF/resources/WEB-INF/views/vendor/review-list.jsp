<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<div class="container my-5" style="padding-left: 20px !important; padding-right: 10px">
    <h1 class="text-center mb-4">Danh sách Review</h1>
    <table class="table table-bordered table-hover">
        <thead style="background-color: rgb(0, 28, 64); color: white;">
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
                    <a href="/vendor/reviews/${review.id}" class="btn btn-info btn-sm">Chi tiết</a>
                    <a href="/vendor/reviews/${review.id}/delete" class="btn btn-danger btn-sm">Xóa</a>
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
                    <li class="page-item ${page == reviewPage.number ? 'active' : ''}">
                        <a class="page-link" href="?page=${page}&size=${reviewPage.size}">${page}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </c:if>

    <!-- Nút quay lại -->
    <div class="text-center mt-4">
        <a href="/vendor/dashboard" class="btn btn-secondary">Quay lại Dashboard</a>
    </div>

    <!-- Thêm script Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</div>