<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<div class="container: my-5" style="padding-left: 20px !important; padding-right: 10px">
    <h1 class="text-center mb-4">Chi tiết Review</h1>

    <!-- Thông tin người dùng và hóa đơn -->
    <div class="mb-4">
        <p><strong>Người dùng:</strong> ${review.user.name}</p>
        <p><strong>Hoá đơn số:</strong> ${review.bill.id}</p>
    </div>

    <h2 class="mb-4">Chi tiết Review</h2>

    <!-- Bảng chi tiết review -->
    <table class="table table-bordered table-hover">
        <thead style="background-color: rgb(0, 28, 64); color: white;">
        <tr>
            <th>Sản phẩm</th>
            <th>Đánh giá</th>
            <th>Bình luận</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="detail" items="${reviewDetails}">
            <tr>
                <td>${detail.medicine.name}</td>
                <td>${detail.rating} sao</td>
                <td>${detail.text}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Nút quay lại -->
    <div class="text-center mt-4">
        <a href="/vendor/reviews" class="btn btn-secondary">Quay lại</a>
    </div>

    <!-- Thêm script Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</div>