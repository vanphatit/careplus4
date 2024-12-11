<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<div class="container my-5">
    <h1 class="text-center mb-4">Đánh giá hóa đơn</h1>
    <table class="table table-bordered table-hover">
        <thead style="background-color: #0077b6; color: white;">
        <tr>
            <th>Sản phẩm</th>
            <th>Đánh giá (1-5)</th>
            <th>Bình luận</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="medicine" items="${medicines}" varStatus="status">
            <tr>
                <form method="post" action="/user/review/${bill.id}" onsubmit="return validateForm()">
                    <td>
                        <div class="d-flex align-items-center">
                            <!-- Hiển thị ảnh sản phẩm -->
                            <img src="${pageContext.request.contextPath}/images/image?fileName=${medicine.image}" alt="${medicine.name}"
                                 style="width: 50px; height: 50px; object-fit: cover; margin: 20px;">
                            <!-- Tên sản phẩm -->
                                ${medicine.name}
                        </div>
                    </td>
                    <td>
                        <!-- Ẩn ID sản phẩm -->
                        <input type="hidden" name="medicineId" value="${medicine.id}">
                        <input type="number" name="rating" class="form-control" min="1.0" max="5.0" step="0.1" required>
                    </td>
                    <td>
                        <textarea name="comment" class="form-control" rows="3" required></textarea>
                    </td>
                    <td>
                        <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
                    </td>
                </form>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="text-center mt-4">
        <a href="/user/reviews" class="btn btn-secondary">Quay lại</a>
    </div>
</div>

<!-- Thêm script Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Kiểm tra dữ liệu trước khi gửi
    function validateForm() {
        const ratings = document.querySelectorAll('input[type="number"]');
        const comments = document.querySelectorAll('textarea');
        for (let i = 0; i < ratings.length; i++) {
            if ((ratings[i].value >= 1.0 && ratings[i].value <= 5.0) && comments[i].value.trim() !== "") {
                return true;
            }
        }
        alert("Vui lòng kiểm tra kỹ các đánh giá và bình luận!");
        return false;
    }
</script>