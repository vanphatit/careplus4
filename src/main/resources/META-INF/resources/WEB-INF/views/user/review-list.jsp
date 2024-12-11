<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                            <hr/>
                            <table class="table table-striped table-hover align-middle">
                                <thead class="text-center" style="background-color: #0077b6; color: white;">
                                <tr>
                                    <th>Mã đơn</th>
                                    <th>Ngày đánh giá</th>
                                    <th>Sản phẩm</th>
                                    <th>Đánh giá</th>
                                    <th>Bình luận</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="review" items="${reviews}">
                                    <tr>
                                        <td class="text-center">${review.bill.id}</td>
                                        <td class="text-center"><fmt:formatDate value="${review.date}" pattern="dd/MM/yyyy"/></td>
                                        <td>
                                            <div class="mb-0 ps-3">
                                                <c:forEach var="detail" items="${reviewDetailsMap[review]}">
                                                    <div>
                                                        <a href="/user/medicine/${detail.medicine.id}"
                                                           style="color: #0d1214 !important;"
                                                           class="text-decoration-none text-primary">
                                                                <strong>${detail.medicineName}</strong>
                                                        </a>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </td>
                                        <td class="text-center">
                                            <c:forEach var="detail" items="${reviewDetailsMap[review]}">
                                                <c:choose>
                                                    <c:when test="${detail.rating >= 4.5}">
                                                        <div><span class="badge bg-success">${detail.rating} sao</span></div>
                                                    </c:when>
                                                    <c:when test="${detail.rating >= 3.5}">
                                                        <div><span class="badge bg-warning text-dark">${detail.rating} sao</span></div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div><span class="badge bg-danger">${detail.rating} sao</span></div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <c:forEach var="detail" items="${reviewDetailsMap[review]}">
                                                <div>${detail.text}</div>
                                            </c:forEach>
                                        </td>
                                        <td class="text-center">
                                            <a href="/user/review/${review.bill.id}/delete" class="btn btn-danger btn-sm mx-2"
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa đánh giá này?')">
                                                <i class="fas fa-trash-alt"></i></a>
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
                                                    <a class="page-link" href="?page=${i}&size=${size}">${i + 1}</a>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>