<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<div class="container my-5">
    <h1 class="text-center mb-4">Danh sách hóa đơn chưa đánh giá</h1>
    <table class="table table-bordered table-hover">
        <thead style="background-color: #0077b6; color: white;">
        <tr>
            <th>Ngày hóa đơn</th>
            <th>Tổng tiền</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="bill" items="${bills}">
            <tr>
                <td><fmt:formatDate value="${bill.date}" pattern="dd/MM/yyyy"/></td>
                <td>${bill.totalAmount}</td>
                <td>
                    <a href="/user/review/${bill.id}" class="btn btn-primary btn-sm">Đánh giá</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Hiển thị thông báo nếu danh sách rỗng -->
    <c:if test="${empty bills}">
        <div class="alert alert-info text-center mt-4">
            Không có hóa đơn nào cần đánh giá.
        </div>
    </c:if>

    <!-- Nút quay lại -->
    <div class="text-center mt-4">
        <a href="/home" class="btn btn-secondary">Quay lại trang chủ</a>
    </div>
</div>

<!-- Thêm script Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
