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
    </style>
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center text-primary">${medicine.id != null ? 'Edit Medicine' : 'Add Medicine'}</h1>

    <!-- Hiển thị thông báo lỗi nếu có -->
    <c:if test="${not empty message}">
        <div class="alert alert-danger text-center">${message}</div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/vendor/medicine/save" enctype="multipart/form-data" class="mt-4">
        <!-- Hidden Field: ID -->
        <input type="hidden" name="id" value="${medicine.id}">
        <input type="hidden" name="isEdit" value="${medicine.id != null ? true : false}">

        <div class="row">
            <!-- Name -->
            <div class="col-md-6 mb-3">
                <label for="name" class="form-label">Name:</label>
                <input type="text" id="name" name="name" class="form-control" value="${medicine.name}" required>
            </div>

            <!-- Unit Cost -->
            <div class="col-md-6 mb-3">
                <label for="unitCost" class="form-label">Unit Cost:</label>
                <input type="number" id="unitCost" name="unitCost" class="form-control" value="${medicine.unitCost}" step="0.01" required>
            </div>
        </div>

        <div class="row">
            <!-- Description -->
            <div class="col-md-12 mb-3">
                <label for="description" class="form-label">Description:</label>
                <textarea id="description" name="description" class="form-control">${medicine.description}</textarea>
            </div>
        </div>

        <div class="row">
            <!-- Expiry Date -->
            <div class="col-md-6 mb-3">
                <label for="expiryDate" class="form-label">Expiry Date:</label>
                <input type="date" id="expiryDate" name="expiryDate" class="form-control" value="${medicine.expiryDate}">
            </div>

            <!-- Dosage -->
            <div class="col-md-6 mb-3">
                <label for="dosage" class="form-label">Dosage:</label>
                <input type="text" id="dosage" name="dosage" class="form-control" value="${medicine.dosage}">
            </div>
        </div>

        <div class="row">
            <!-- Stock Quantity -->
            <div class="col-md-6 mb-3">
                <label for="stockQuantity" class="form-label">Stock Quantity:</label>
                <input type="number" id="stockQuantity" name="stockQuantity" class="form-control" value="${medicine.stockQuantity}" required>
            </div>

            <!-- Manufacturer -->
            <div class="col-md-6 mb-3">
                <label for="manufacturerId" class="form-label">Manufacturer:</label>
                <select id="manufacturerId" name="manufacturerId" class="form-select" required>
                    <c:forEach var="manufacturer" items="${manufacturers}">
                        <option value="${manufacturer.id}"
                                <c:if test="${manufacturer.id == medicine.manufacturerId}">selected</c:if>>
                                ${manufacturer.name}
                        </option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="row">
            <!-- Category -->
            <div class="col-md-6 mb-3">
                <label for="categoryId" class="form-label">Category:</label>
                <select id="categoryId" name="categoryId" class="form-select" required>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.id}"
                                <c:if test="${category.id == medicine.categoryId}">selected</c:if>>
                                ${category.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- Unit -->
            <div class="col-md-6 mb-3">
                <label for="unitId" class="form-label">Unit:</label>
                <select id="unitId" name="unitId" class="form-select" required>
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
            <!-- Image -->
            <div class="col-md-12 mb-3">
                <label for="image" class="form-label">Image:</label>
                <input type="file" id="image" name="image" class="form-control">
                <c:if test="${not empty medicine.imageUrl}">
                    <div class="mt-2">
                        <img src="${pageContext.request.contextPath}/medicine/image?fileName=${medicine.imageUrl}" alt="Medicine Image" class="img-thumbnail" style="max-width: 200px;">
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Submit Button -->
        <div class="row">
            <div class="col-md-12 text-center">
                <button type="submit" class="btn btn-primary w-100">
                    ${medicine.id != null ? 'Update Medicine' : 'Add Medicine'}
                </button>
            </div>
        </div>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
