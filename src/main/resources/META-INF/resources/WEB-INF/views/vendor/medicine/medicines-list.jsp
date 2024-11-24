<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medicines List</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f7f8fa;
            font-family: 'Arial', sans-serif;
        }

        h1 {
            color: #495057;
            margin-bottom: 20px;
        }

        .section-container {
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            padding: 50px;
            margin-bottom: 50px;
        }

        .btn {
            border-radius: 0; /* Nút vuông */
        }

        .table-container {
            background-color: #ffffff;
            border-radius: 4px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .table th {
            background-color: #f1f3f5;
            color: #495057;
            font-weight: bold;
        }

        .pagination .page-item.active .page-link {
            background-color: #28a745;
            border-color: #28a745;
        }

        .form-control, .form-select {
            border-radius: 0; /* Ô nhập liệu vuông */
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-warning {
            background-color: #ffc107;
            border-color: #ffc107;
            color: #000;
        }

        .btn-warning:hover {
            background-color: #e0a800;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <h1 class="text-center">Medicines List</h1>

    <!-- Search Section -->
    <div class="section-container">
        <form method="post" action="${pageContext.request.contextPath}/vendor/medicine/search" class="d-flex">
            <input type="text" name="keyword" class="form-control me-2 shadow-sm" placeholder="Search by name or category" value="${keyword}">
            <button type="submit" class="btn btn-primary px-4 shadow-sm">Search</button>
        </form>
    </div>

    <!-- Filter Section -->
    <div class="section-container">
        <form method="post" action="${pageContext.request.contextPath}/vendor/medicine/filter" class="row g-4">
            <!-- Manufacturer -->
            <div class="col-md-4">
                <label for="manufacturerName" class="form-label">Manufacturer</label>
                <br>
                <select name="manufacturerName" id="manufacturerName" class="form-select shadow-sm">
                    <option value="">${manufacturerName == null ? null : manufacturerName}</option>
                    <c:forEach var="manufacturer" items="${manufacturers}">
                        <option value="${manufacturer.name}" ${manufacturer.name == manufacturerName ? 'selected' : ''}>${manufacturer.name}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Category -->
            <div class="col-md-4">
                <label for="categoryName" class="form-label">Category</label>
                <br>
                <select name="categoryName" id="categoryName" class="form-select shadow-sm">
                    <option value=""> ${categoryName == null ? null : categoryName}</option>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.name}" ${category.name == categoryName ? 'selected' : ''}>${category.name}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Unit -->
            <div class="col-md-4">
                <label for="unitName" class="form-label">Unit</label>
                <br>
                <select name="unitName" id="unitName" class="form-select shadow-sm">
                    <option value="">${unitName == null ? null : unitName}</option>
                    <c:forEach var="unit" items="${units}">
                        <option value="${unit.name}" ${unit.name == unitName ? 'selected' : ''}>${unit.name}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Unit Cost Min/Max -->
            <div class="col-md-3">
                <label for="unitCostMin" class="form-label">Unit Cost Min</label>
                <input type="number" name="unitCostMin" id="unitCostMin" class="form-control shadow-sm" placeholder="Min" value="${unitCostMin}">
            </div>
            <div class="col-md-3">
                <label for="unitCostMax" class="form-label">Unit Cost Max</label>
                <input type="number" name="unitCostMax" id="unitCostMax" class="form-control shadow-sm" placeholder="Max" value="${unitCostMax}">
            </div>

            <!-- Rating Min/Max -->
            <div class="col-md-3">
                <label for="ratingMin" class="form-label">Rating Min</label>
                <input type="number" name="ratingMin" id="ratingMin" class="form-control shadow-sm" placeholder="Min" step="0.1" value="${ratingMin}">
            </div>
            <div class="col-md-3">
                <label for="ratingMax" class="form-label">Rating Max</label>
                <input type="number" name="ratingMax" id="ratingMax" class="form-control shadow-sm" placeholder="Max" step="0.1" value="${ratingMax}">
            </div>

            <!-- Expiry Date Min/Max -->
            <div class="col-md-3">
                <label for="expiryDateMin" class="form-label">Expiry Date Min</label>
                <input type="date" name="expiryDateMin" id="expiryDateMin" class="form-control shadow-sm" value="${expiryDateMin}">
            </div>
            <div class="col-md-3">
                <label for="expiryDateMax" class="form-label">Expiry Date Max</label>
                <input type="date" name="expiryDateMax" id="expiryDateMax" class="form-control shadow-sm" value="${expiryDateMax}">
            </div>

            <!-- Stock Quantity Min/Max -->
            <div class="col-md-3">
                <label for="stockQuantityMin" class="form-label">Stock Min</label>
                <input type="number" name="stockQuantityMin" id="stockQuantityMin" class="form-control shadow-sm" placeholder="Min" value="${stockQuantityMin}">
            </div>
            <div class="col-md-3">
                <label for="stockQuantityMax" class="form-label">Stock Max</label>
                <input type="number" name="stockQuantityMax" id="stockQuantityMax" class="form-control shadow-sm" placeholder="Max" value="${stockQuantityMax}">
            </div>

            <!-- Import Date Min/Max -->
            <div class="col-md-3">
                <label for="importDateMin" class="form-label">Import Date Min</label>
                <input type="date" name="importDateMin" id="importDateMin" class="form-control shadow-sm" value="${importDateMin}">
            </div>
            <div class="col-md-3">
                <label for="importDateMax" class="form-label">Import Date Max</label>
                <input type="date" name="importDateMax" id="importDateMax" class="form-control shadow-sm" value="${importDateMax}">
            </div>

            <!-- Apply Filters -->
            <div class="col-md-12 text-end">
                <br>
                <button type="submit" class="btn btn-success px-4 shadow-sm">Apply Filters</button>
                <br>
            </div>
        </form>
    </div>


    <!-- Add Medicine Button -->
    <div class="section-container">
        <br>
        <a href="${pageContext.request.contextPath}/vendor/medicine/add" class="btn btn-primary shadow-sm">Add Medicine</a>
        <br>
    </div>

    <!-- Medicine Table -->
    <div class="table-container">
        <table class="table table-bordered table-striped">
            <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Category</th>
                <th>Manufacturer</th>
                <th>Unit Cost</th>
                <th>Stock Quantity</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="medicine" items="${medicines.content}">
                <tr>
                    <td>${medicine.id}</td>
                    <td>${medicine.name}</td>
                    <td>${medicine.category.name}</td>
                    <td>${medicine.manufacturer.name}</td>
                    <td>${medicine.unitCost}</td>
                    <td>${medicine.stockQuantity}</td>
                    <td>
                        <div class="d-flex gap-2 justify-content-center">
                            <a href="${pageContext.request.contextPath}/vendor/medicine/${medicine.id}" class="btn btn-info btn-sm text-white">View</a>
                            <a href="${pageContext.request.contextPath}/vendor/medicine/edit/${medicine.id}" class="btn btn-warning btn-sm">Edit</a>
                            <a href="${pageContext.request.contextPath}/vendor/medicine/delete/${medicine.id}" class="btn btn-danger btn-sm">Delete</a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Pagination -->
    <nav aria-label="Page navigation" class="mt-4">
        <ul class="pagination justify-content-center">
            <c:forEach var="page" begin="1" end="${pageNumbers.size()}">
                <li class="page-item ${page == currentPage ? 'active' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/vendor/medicines?page=${page}&size=${pageSize}&search=${searchKeyword}">
                            ${page}
                    </a>
                </li>
            </c:forEach>
        </ul>
    </nav>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
