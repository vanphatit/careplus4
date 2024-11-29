<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medicines List</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        .filter-section {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .filter-section .form-control, .filter-section .btn {
            margin-top: 10px;
        }
        .filter-section .btn {
            background-color: #007bff;
            color: #fff;
        }
        .filter-section .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container mt-4">
    <h1 class="text-center mb-4">Medicines List</h1>

    <!-- Thanh tìm kiếm -->
    <div class="mb-4">
        <form action="${pageContext.request.contextPath}/user/medicine/search" method="post" class="d-flex">
            <input type="text" name="keyword" class="form-control me-2" placeholder="Search medicines by name...">
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
    </div>

    <!-- Bộ lọc -->
    <div class="filter-section">
        <form action="${pageContext.request.contextPath}/user/medicine/filter" method="post">
            <div class="row">
                <div class="col-md-4">
                    <label for="manufacturerName">Manufacturer</label>
                    <br>
                    <select id="manufacturerName" name="manufacturerName" class="form-select">
                        <option value="">${manufacturerName == null ? null : manufacturerName}</option>
                        <c:forEach var="manufacturer" items="${manufacturers}">
                            <option value="${manufacturer.name}">${manufacturer.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-4">
                    <label for="categoryName">Category</label>
                    <br>
                    <select id="categoryName" name="categoryName" class="form-select">
                        <option value="">${categoryName == null ? null : categoryName}</option>
                        <br>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.name}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-4">
                    <label for="unitName">Unit</label>
                    <br>
                    <select id="unitName" name="unitName" class="form-select">
                        <option value="">${unitName == null ? null : unitName}</option>
                        <c:forEach var="unit" items="${units}">
                            <option value="${unit.name}">${unit.name}</option>
                        </c:forEach>
                    </select>
                </div>

            </div>

            <div class="row mt-3">
                <div class="col-md-4">
                    <label for="unitCostMin">Price Min</label>
                    <input type="number" id="unitCostMin" name="unitCostMin" class="form-control" placeholder="Enter minimum price">
                </div>
                <div class="col-md-4">
                    <label for="unitCostMax">Price Max</label>
                    <input type="number" id="unitCostMax" name="unitCostMax" class="form-control" placeholder="Enter maximum price">
                </div>
                <div class="col-md-4">
                    <label for="stockQuantityMin">Stock Min</label>
                    <input type="number" id="stockQuantityMin" name="stockQuantityMin" class="form-control" placeholder="Enter minimum stock">
                </div>
            </div>

            <div class="row mt-3">
                <div class="col-md-4">
                    <label for="expiryDateMin">Expiry Date Min</label>
                    <input type="date" id="expiryDateMin" name="expiryDateMin" class="form-control">
                </div>
                <div class="col-md-4">
                    <label for="expiryDateMax">Expiry Date Max</label>
                    <input type="date" id="expiryDateMax" name="expiryDateMax" class="form-control">
                </div>
                <div class="col-md-4">
                    <label for="ratingMin">Rating Min</label>
                    <input type="number" step="0.1" id="ratingMin" name="ratingMin" class="form-control" placeholder="Enter minimum rating">
                </div>
            </div>

            <div class="row mt-3">
                <div class="col-md-4">
                    <label for="ratingMax">Rating Max</label>
                    <input type="number" step="0.1" id="ratingMax" name="ratingMax" class="form-control" placeholder="Enter maximum rating">
                </div>
            </div>

            <div class="text-center mt-4">
                <button type="submit" class="btn btn-primary">Apply Filters</button>
            </div>
        </form>
    </div>

    <!-- Danh sách thuốc -->
    <div class="row row-cols-1 row-cols-md-3 g-4">
        <c:forEach var="medicine" items="${medicines}">
            <div class="col">
                <div class="card h-100">
                    <img src="${pageContext.request.contextPath}/medicine/image?fileName=${medicine.image}" class="card-img-top" alt="Medicine Image">
                    <div class="card-body">
                        <h5 class="card-title">${medicine.name}</h5>
                        <p class="card-text">Category: ${medicine.categoryName}</p>
                        <p class="card-text">Manufacturer: ${medicine.manufacturerName}</p>
                        <p class="card-text">Price: ${medicine.unitCost}</p>
                        <p class="card-text">Stock: ${medicine.stockQuantity}</p>
                        <a href="${pageContext.request.contextPath}/user/medicine/${medicine.id}" class="btn btn-primary">View Details</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Pagination -->
    <nav>
        <ul class="pagination justify-content-center mt-4">
            <c:if test="${currentPage > 1}">
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/user/medicine/filter?page=${currentPage - 1}&size=${pageSize}">Previous</a>
                </li>
            </c:if>
            <c:forEach begin="1" end="${totalPages}" var="page">
                <li class="page-item ${page == currentPage ? 'active' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/user/medicine/filter?page=${page}&size=${pageSize}">${page}</a>
                </li>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/user/medicine/filter?page=${currentPage + 1}&size=${pageSize}">Next</a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
