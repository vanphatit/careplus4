<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<body class="sb-nav-fixed">
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Quản lý đánh giá</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/user/userInfo">Thông tin tài khoản</a></li>
                    <li class="breadcrumb-item active">Đánh giá</li>
                </ol>
                <div class="mt-3">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <hr />
                            <table class="table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>Mã đơn</th>
                                    <th>Ngày đánh giá</th>
                                    <th>Sản phẩm</th>
                                    <th>Đánh giá</th>
                                    <th>Bình luận</th>
                                    <th>Xử lý</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="review" items="${reviews}">
                                    <tr>
                                        <td>${review.bill.id}</td>
                                        <td>${review.date}</td>
                                        <td>
                                            <ul>
                                                <c:forEach var="detail" items="${reviewDetailsMap[review]}">
                                                    <li>${detail.medicine.name}</li>
                                                </c:forEach>
                                            </ul>
                                        </td>
                                        <td>
                                            <ul>
                                                <c:forEach var="detail" items="${reviewDetailsMap[review]}">
                                                    <li>${detail.rating} sao</li>
                                                </c:forEach>
                                            </ul>
                                        </td>
                                        <td>
                                            <ul>
                                                <c:forEach var="detail" items="${reviewDetailsMap[review]}">
                                                    <li>${detail.text}</li>
                                                </c:forEach>
                                            </ul>
                                        </td>
                                        <td>
                                            <a href="/user/review/${review.bill.id}/delete" class="btn btn-danger btn-sm mx-2"
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa đánh giá này?')">Xóa</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                            <!-- Phân trang -->
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="?page=${currentPage - 1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                        <c:choose>
                                            <c:when test="${currentPage == i}">
                                                <li class="page-item active">
                                                    <a class="page-link" href="?page=${i}&size=${size}">${i + 1}</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item">
                                                    <a class="page-link" href="?page=${i}&size=${size}">${i}</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="?page=${currentPage + 1}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
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