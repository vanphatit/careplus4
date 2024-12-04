<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>

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

            <!-- Medicines Cards -->
            <div class="row">
                <c:forEach var="medicine" items="${medicines}">
                    <div class="col-md-4 mb-4">
                        <div class="medicine-card">
                            <img src="${pageContext.request.contextPath}/image?fileName=${medicine.image}" alt="${medicine.name}">
                            <div class="card-body">
                                <h5><strong><a href="${pageContext.request.contextPath}/user/medicine/${medicine.id}" class="manufacturer-name btn">${medicine.name}</a></strong></h5>
                                <p><strong>Loại:</strong></p>
                                <p class="manufacturer-name">${medicine.categoryName}</p>
                                <p><strong>Nhà sản xuất:</strong></p>
                                <p class="manufacturer-name">${medicine.manufacturerName}</p>
                                <p><strong>Đơn vị:</strong> ${medicine.unitName}</p>
                                <p><strong>Giá:</strong> ${medicine.unitCost}</p>
                                <p><strong>Đánh giá:</strong></p>
                                <div class="mt-2">
                                    <!-- Vùng hiển thị sao -->
                                    <div class="rating-stars" style="position: relative; display: inline-block; font-size: 20px; color: #ddd;">
                                        <!-- Sao rỗng -->
                                        <span style="color: #e4e5e9;">&#9733;&#9733;&#9733;&#9733;&#9733;</span>
                                        <!-- Sao đầy -->
                                        <span style="color: #ffc107; position: absolute; top: 0; left: 0; width: ${medicine.rating * 20}%; overflow: hidden; white-space: nowrap;">&#9733;&#9733;&#9733;&#9733;&#9733;</span>
                                    </div>
                                </div>
                                <form method="post" action="${pageContext.request.contextPath}/user/add-medicine-to-cart/${medicine.id}">
                                    <input type="hidden" name="medicineId" value="${medicine.id}">
                                    <button type="submit" class="btn btn-primary mt-2">Thêm vào giỏ hàng</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Pagination -->
            <div class="pagination justify-content-center">
                <c:forEach var="page" begin="1" end="${pageNumbers.size()}">
                    <a href="${pageContext.request.contextPath}/user/medicines?page=${page}" class="btn btn-outline-primary">${page}</a>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
