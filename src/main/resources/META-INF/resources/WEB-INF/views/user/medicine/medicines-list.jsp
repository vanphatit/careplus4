<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>

<style>
    h5 a.btn {
        display: block; /* Hoặc inline-block nếu cần */
        white-space: normal; /* Cho phép xuống dòng nếu quá dài */
        text-align: center; /* Đảm bảo căn giữa */
        overflow: hidden; /* Ngăn tràn */
        text-overflow: ellipsis; /* Hiện dấu ... nếu bị tràn */
        word-wrap: break-word; /* Tự động xuống dòng nếu quá dài */
        font-size: 16px; /* Tùy chỉnh kích cỡ chữ */
        font-weight: bold; /* Đảm bảo chữ đậm */
        margin: 0; /* Đảm bảo không có khoảng trống dư thừa */
        padding: 0; /* Xóa khoảng đệm */
    }

    h5 a.btn:hover {
        color: #0d6efd; /* Màu khi hover */
        text-decoration: underline; /* Hiệu ứng gạch chân khi hover */
    }

    .product-card h5 a {
        white-space: normal; /* Cho phép xuống dòng */
        overflow: hidden; /* Ngăn nội dung tràn */
        text-overflow: ellipsis; /* Hiển thị dấu ba chấm nếu cần */
        display: block; /* Đảm bảo tên không bị cắt ngang */
    }

</style>

<div class="container mt-4">
    <div class="row">
        <!-- Filter Section (Left Sidebar) -->
        <div class="col-md-3">
            <div class="section-container filter-container">
                <h5 class="text-center">Bộ Lọc Nâng Cao</h5>
                <form method="post" action="${pageContext.request.contextPath}/user/medicine/filter">
                    <div class="mb-3">
                        <label for="unitCostMin" class="form-label">Giá bán</label>
                        <div class="d-flex">
                            <input type="number" name="unitCostMin" id="unitCostMin" class="form-control" min="0" placeholder="Từ" value="${unitCostMin}">
                            <input type="number" name="unitCostMax" id="unitCostMax" class="form-control" min="0" placeholder="Đến" value="${unitCostMax}">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="ratingMin" class="form-label">Đánh giá</label>
                        <div class="d-flex">
                            <input type="number" name="ratingMin" id="ratingMin" class="form-control" placeholder="Từ" min="0" max="5" step="0.1" value="${ratingMin}">
                            <input type="number" name="ratingMax" id="ratingMax" class="form-control" placeholder="Đến" max="5" step="0.1" value="${ratingMax}">
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary">Áp dụng Lọc</button>
                </form>
            </div>
        </div>

        <!-- Medicines List Section (Right Content) -->
        <div class="col-md-9">
            <h1 class="text-center mb-4">Danh sách thuốc trong kho</h1>

            <!-- Search Bar -->
            <div class="section-container mb-4">
                <form method="post" action="${pageContext.request.contextPath}/user/medicine/search" class="d-flex">
                    <input type="text" name="keyword" class="form-control me-2" placeholder="Tìm kiếm theo tên, loại, nhà sản xuất, mô tả, đơn vị và liều dùng" value="${keyword}">
                    <button type="submit" class="btn btn-primary">Tìm</button>
                </form>
            </div>

            <div class="row justify-content-start">
                <c:forEach var="medicine" items="${medicines}">
                    <div class="col-md-4 mb-4 d-flex align-items-stretch">
                        <div class="medicine-card shadow-sm rounded p-3 d-flex flex-column">
                            <img src="${pageContext.request.contextPath}/images/image?fileName=${medicine.image}" style="height: 150px; object-fit: contain;" class="img-fluid" alt="${medicine.name}">
                            <div class="card-body d-flex flex-column">
                                <h5 class="text-center">
                                    <a href="${pageContext.request.contextPath}/user/medicine/${medicine.id}" class="btn">${medicine.name}</a>
                                </h5>
                                <p><strong>Đơn vị:</strong> ${medicine.unitName}</p>
                                <p><strong>Giá:</strong> ${medicine.unitCost}</p>
                                <p><strong>Đánh giá:</strong></p>
                                <div class="mt-2">
                                    <div class="rating-stars" style="position: relative; display: inline-block; font-size: 20px; color: #ddd;">
                                        <span style="color: #e4e5e9;">&#9733;&#9733;&#9733;&#9733;&#9733;</span>
                                        <span style="color: #ffc107; position: absolute; top: 0; left: 0; width: ${medicine.rating * 20}%; overflow: hidden; white-space: nowrap;">&#9733;&#9733;&#9733;&#9733;&#9733;</span>
                                    </div>
                                </div>
                                <form method="post" action="${pageContext.request.contextPath}/user/add-medicine-to-cart/${medicine.id}" class="mt-auto">
                                    <input type="hidden" name="medicineId" value="${medicine.id}">
                                    <input type="hidden" name="quantity" value="1">
                                    <button type="submit" class="btn btn-primary mt-2 w-100">Thêm vào giỏ hàng</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <!-- Tính số cột rỗng cần thêm -->
                <c:set var="remainingColumns" value="${3 - (medicines.size() % 3)}" />
                <c:if test="${remainingColumns < 3}">
                    <c:forEach var="i" begin="1" end="${remainingColumns}">
                        <div class="col-md-4 mb-4"></div>
                    </c:forEach>
                </c:if>
            </div>

            <!-- Pagination -->
            <div class="pagination justify-content-center">
                <c:forEach var="page" begin="1" end="${pageNumbers.size()}">
                    <a href="${pageContext.request.contextPath}/user/medicines?page=${page}" class="btn btn-outline-primary">${page}</a>
                </c:forEach>
            </div>
            <br>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    <c:if test="${not empty message}">
    Swal.fire({
        icon: 'success',
        title: 'Thành công!',
        text: '${message}',
        confirmButtonText: 'OK'
    });
    </c:if>
    <c:if test="${not empty error}">
    Swal.fire({
        icon: 'error',
        title: 'Lỗi!',
        text: '${error}',
        confirmButtonText: 'OK'
    });
    </c:if>
</script>

