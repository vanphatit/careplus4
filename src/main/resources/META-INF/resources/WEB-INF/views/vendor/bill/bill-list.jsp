<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<body class="sb-nav-fixed">
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Quản lý hóa đơn</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Hóa đơn</li>
                </ol>
                <div class="mt-3">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <form action="/vendor/bill/search" method="get" class="form-inline">
                                <input type="text" name="id" placeholder="Tìm theo mã hóa đơn" value="${id}" class="form-control"/>
                                <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                            </form>

                            <div class="d-flex justify-content-between mt-4">
                                <h3>Danh sách hóa đơn</h3>
                            </div>

                            <hr />
                            <table class=" table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>Mã hóa đơn</th>
                                    <th>Người nhận</th>
                                    <th>Địa chỉ</th>
                                    <th>Ngày tạo</th>
                                    <th>Thanh toán</th>
                                    <th>Trạng thái</th>
                                    <th>Xử lý</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="bill" items="${bills}">
                                    <tr>
                                        <th>${bill.id}</th>
                                        <td>${bill.name}</td>
                                        <td>${bill.address}</td>
                                        <td>${bill.date}</td>
                                        <td>${bill.method}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${bill.status == 'COMPLETED'}">
                                                    <span class="badge bg-success">COMPLETED</span>
                                                </c:when>
                                                <c:when test="${bill.status == 'PROCESSING'}">
                                                    <span class="badge bg-primary">PROCESSING</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-warning">${bill.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="/vendor/bill/${bill.id}"
                                               class="btn btn-success">Chi tiết </a>
                                            <a href="/vendor/bill/update/${bill.id}"
                                               class="btn btn-warning  mx-2">Cập nhật</a>
                                            <a href="/vendor/bill/delete/${bill.id}"
                                               class="btn btn-danger">Xóa</a>
                                        </td>
                                    </tr>

                                </c:forEach>

                                </tbody>
                            </table>
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="/vendor/bills?page=${currentPage-1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <c:forEach begin="1" end="${pageNo}" var="i">
                                        <c:choose>
                                            <c:when test="${currentPage == i}">
                                                <li class="page-item active">
                                                    <a class="page-link" href="/vendor/bills?page=${i}">${i}</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item">
                                                    <a class="page-link" href="/vendor/bills?page=${i}">${i}</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <li class="page-item ${currentPage == pageNo ? 'disabled' : ''}">
                                        <a class="page-link" href="/vendor/bills?page=${currentPage + 1}" aria-label="Next">
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