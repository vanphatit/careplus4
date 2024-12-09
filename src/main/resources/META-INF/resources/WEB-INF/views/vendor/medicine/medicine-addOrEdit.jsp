<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${medicine.id != null ? 'Edit Medicine' : 'Add Medicine'}</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f9f9f9;
        }
        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .form-label {
            font-weight: bold;
        }
        .form-label {
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
        textarea#description {
            resize: vertical; /* Cho phép người dùng điều chỉnh chiều cao */
        }
        img {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 5px;
            max-width: 200px;
        }
        .custom-select {
            width: 25%;
            margin: 0 auto; /* Căn giữa */
            font-size: 16px;
            border-radius: 8px; /* Bo góc */
            padding: 8px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Hiệu ứng đổ bóng */
            background-color: #f9f9f9; /* Màu nền nhạt */
            transition: all 0.3s ease-in-out;
        }

        .custom-select:hover {
            border-color: #007bff; /* Đổi màu viền khi hover */
            background-color: #ffffff; /* Màu nền khi hover */
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center text-primary">${medicine.id != null ? 'Cập nhật thông tin thuốc' : 'Thêm thuốc mới'}</h1>

    <!-- Hiển thị thông báo lỗi nếu có -->
    <c:if test="${not empty message}">
        <div class="alert alert-danger text-center">${message}</div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/vendor/medicine/save" enctype="multipart/form-data" class="mt-4">
        <!-- Hidden Field: ID -->
        <input type="hidden" name="id" value="${medicine.id}">
        <input type="hidden" name="isEdit" value="${medicine.id != null ? true : false}">

        <input type="hidden" name="rating" value="${medicine.id != null ? medicine.rating : 0.0}">
        <input type="hidden" name="unitCost" value="${medicine.id != null ? medicine.unitCost : 0.0}">

        <div class="row">
            <!-- Name -->
            <div class="col-md-6 mb-3">
                <label for="name" class="form-label">Tên thuốc:</label>
                <input type="text" id="name" name="name" class="form-control" placeholder="Nhập tên thuốc" value="${medicine.name}" required>
            </div>
            <!-- Dosage -->
            <div class="col-md-6 mb-3">
                <label for="dosage" class="form-label">Liều dùng:</label>
                <input type="text" id="dosage" name="dosage" class="form-control" placeholder="Nhập liều dùng" value="${medicine.dosage}">
            </div>
        </div>

        <div class="row">
            <!-- Expiry Date -->
            <div class="col-md-6 mb-3">
                <label for="expiryDate" class="form-label">Ngày hết hạn:</label>
                <input type="date" id="expiryDate" name="expiryDate" class="form-control" value="${medicine.expiryDate}">
            </div>
            <!-- Import Date -->
            <div class="col-md-6 mb-3">
                <label for="importDate" class="form-label">Ngày nhập:</label>
                <c:if test="${medicine.id == null}">
                    <input type="date" id="importDate" disabled name="importDate" class="form-control" value="${CURRENTDATE}">
                </c:if>
                <c:if test="${medicine.id != null}">
                    <input type="date" id="importDate" name="importDate" class="form-control" value="${medicine.importDate}">
                </c:if>
            </div>
        </div>

        <div class="row">
            <!-- Stock Quantity -->
            <div class="col-md-6 mb-3">
                <c:if test="${medicine.id == null}">
                    <input type="number" id="stockQuantity" name="stockQuantity" class="form-control" hidden="hidden" value="0" required>
                    <input type="text" id="importId" name="importId" hidden="hidden" class="form-control" value="${importId}">
                </c:if>
                <c:if test="${medicine.id != null}">
                    <label for="stockQuantity" class="form-label">Số lượng tồn:</label>
                    <input type="number" id="stockQuantity" name="stockQuantity" class="form-control" value="${medicine.stockQuantity}" readonly required disabled>
                </c:if>
            </div>
        </div>

        <div class="row">
            <!-- Manufacturer -->
            <div class="col-md-4 mb-3">
                <label for="manufacturerId" class="form-label">Nhà sản xuất:</label>
                <br>
                <select id="manufacturerId" name="manufacturerId" class="form-select custom-select" required>
                    <c:forEach var="manufacturer" items="${manufacturers}">
                        <option value="${manufacturer.id}"
                                <c:if test="${manufacturer.id == medicine.manufacturerId}">selected</c:if>>
                                ${manufacturer.name}
                        </option>
                    </c:forEach>
                </select>
            </div>
                <!-- Category -->
                <div class="col-md-4 mb-3">
                    <label for="categoryId" class="form-label">Loại thuốc:</label>
                    <br>
                    <select id="categoryId" name="categoryId" class="form-select custom-select" required>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.id}"
                                    <c:if test="${category.id == medicine.categoryId}">selected</c:if>>
                                    ${category.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <!-- Unit -->
                <div class="col-md-4 mb-3">
                    <label for="unitId" class="form-label">Đơn vị:</label>
                    <br>
                    <select id="unitId" name="unitId" class="form-select custom-select" required>
                        <c:forEach var="unit" items="${units}">
                            <option value="${unit.id}"
                                    <c:if test="${unit.id == medicine.unitId}">selected</c:if>>
                                    ${unit.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
        </div>

        <div class="row">
            <div class="col-md-12 mb-3">
                <label for="description" class="form-label">Mô tả:</label>
                <textarea id="description" name="description" class="form-control" rows="10" cols="50" placeholder="Nhập mô tả về thuốc">${medicine.description}</textarea>
            </div>
        </div>

        <div class="row">
            <!-- Image -->
            <div class="col-md-12 mb-3">
                <label for="image" class="form-label">Ảnh:</label>
                <input type="file" id="image" name="image" class="form-control">
                    <!-- Hiển thị ảnh hiện có nếu có -->
                    <c:if test="${not empty medicine.imageUrl}">
                        <div class="mt-2">
                            <img src="${pageContext.request.contextPath}/images/image?fileName=${medicine.imageUrl}"
                                 alt="Medicine Image"
                                 class="img-thumbnail"
                                 style="max-width: 200px;">
                        </div>
                    </c:if>
                <!-- Khung "Xem trước" -->
                <div class="mt-2" id="previewContainer" style="display: none;">
                    <label for="previewImage" class="form-label mt-2">Xem trước:</label>
                    <br>
                    <img id="previewImage" src="#" alt="Preview Image" class="img-thumbnail" style="max-width: 200px;">
                </div>
            </div>
        </div>

        <!-- Submit Button -->
        <div class="row">
            <div class="col-md-12 text-center">
                <button type="submit" class="btn btn-primary w-100">
                    ${medicine.id != null ? 'Cập nhật thông tin thuốc' : 'Thêm thuốc mới'}
                </button>
            </div>
        </div>

        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/vendor/medicines" class="btn btn-outline-primary">Quay về</a>
        </div>
    </form>
</div>

<!-- Bootstrap JS -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.querySelector("form");

        form.addEventListener("submit", function (e) {
            const name = document.querySelector("#name").value.trim();
            const manufacturerId = document.querySelector("#manufacturerId").value.trim();
            const categoryId = document.querySelector("#categoryId").value.trim();
            const unitId = document.querySelector("#unitId").value.trim();
            const stockQuantity = document.querySelector("#stockQuantity").value.trim();
            const expiryDate = document.querySelector("#expiryDate").value.trim();
            const dosage = document.querySelector("#dosage").value.trim();
            const description = document.querySelector("#description").value.trim();

            if (name === "" || manufacturerId === "" || categoryId === "" || unitId === "" || unitCost === "" || stockQuantity === "" || expiryDate === "" || dosage === "" || description === "") {
                e.preventDefault();
                alert("Please fill in all the fields!");
            }

            if (expiryDate < CURRENTDATE) {
                e.preventDefault();
                alert("Expiry Date must be greater than or equal to the current date!");
            }

        });

        const imageInput = document.querySelector("#image");
        const previewContainer = document.querySelector("#previewContainer");
        const previewImage = document.querySelector("#previewImage");

        imageInput.addEventListener("change", function (event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    previewImage.src = e.target.result; // Hiển thị ảnh mới
                    previewContainer.style.display = "block"; // Hiện khung xem trước
                };
                reader.readAsDataURL(file); // Đọc file ảnh
            } else {
                previewImage.src = "#";
                previewContainer.style.display = "none"; // Ẩn khung xem trước nếu không chọn file
            }
        });
    });
</script>
</body>
</html>
