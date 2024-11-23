<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${medicine.id != null ? 'Edit Medicine' : 'Add Medicine'}</title>
    <style>
        /* styles.css */

        /* Tổng quan */
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        /* Tiêu đề */
        h1 {
            text-align: center;
            margin-top: 20px;
            color: #333;
        }

        /* Bảng */
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        table th, table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }

        table th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }

        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        /* Nút hành động */
        a {
            text-decoration: none;
            color: #007bff;
            margin: 0 5px;
        }

        a:hover {
            text-decoration: underline;
        }

        /* Phân trang */
        .pagination {
            text-align: center;
            margin: 20px auto;
        }

        .pagination a {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 4px;
            border: 1px solid #ddd;
            background-color: white;
            color: #007bff;
            border-radius: 4px;
        }

        .pagination a:hover {
            background-color: #007bff;
            color: white;
        }

        .pagination .current {
            background-color: #007bff;
            color: white;
            pointer-events: none;
            border: 1px solid #007bff;
        }

        /* Form */
        form {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        form div {
            margin-bottom: 15px;
        }

        form label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        form input[type="text"],
        form input[type="number"],
        form input[type="date"],
        form textarea,
        form select,
        form input[type="file"] {
            width: 100%;
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        form textarea {
            resize: vertical;
        }

        form button {
            display: block;
            width: 100%;
            padding: 10px;
            font-size: 16px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        form button:hover {
            background-color: #0056b3;
        }

        /* Hình ảnh */
        img {
            display: block;
            max-width: 200px;
            margin: 0 auto;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }

        /* Back to list */
        .back-link {
            text-align: center;
            margin: 20px auto;
        }

        .back-link a {
            text-decoration: none;
            color: white;
            background-color: #007bff;
            padding: 10px 20px;
            border-radius: 4px;
        }

        .back-link a:hover {
            background-color: #0056b3;
        }

    </style>
</head>
<body>
<h1>${medicine.id != null ? 'Edit Medicine' : 'Add Medicine'}</h1>
<form method="post" action="${pageContext.request.contextPath}/vendor/medicine/save" enctype="multipart/form-data">
    <!-- ID -->
    <input type="hidden" name="id" value="${medicine.id}">

    <!-- Name -->
    <div>
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" value="${medicine.name}" required>
    </div>

    <!-- Description -->
    <div>
        <label for="description">Description:</label>
        <textarea id="description" name="description">${medicine.description}</textarea>
    </div>

    <!-- Unit Cost -->
    <div>
        <label for="unitCost">Unit Cost:</label>
        <input type="number" id="unitCost" name="unitCost" value="${medicine.unitCost}" required>
    </div>

    <!-- Expiry Date -->
    <div>
        <label for="expiryDate">Expiry Date:</label>
        <input type="date" id="expiryDate" name="expiryDate" value="${medicine.expiryDate}">
    </div>

    <!-- Import Date -->
    <div>
        <label for="importDate">Import Date:</label>
        <input type="date" id="importDate" name="importDate" value="${medicine.importDate}">
    </div>

    <!-- Stock Quantity -->
    <div>
        <label for="stockQuantity">Stock Quantity:</label>
        <input type="number" id="stockQuantity" name="stockQuantity" value="${medicine.stockQuantity}" required>
    </div>

    <!-- Dosage -->
    <div>
        <label for="dosage">Dosage:</label>
        <input type="text" id="dosage" name="dosage" value="${medicine.dosage}">
    </div>

    <!-- Rating -->
    <div>
        <label for="rating">Rating:</label>
        <input type="number" id="rating" name="rating" step="0.1" value="${medicine.rating}">
    </div>

    <!-- Manufacturer -->
    <div>
        <label for="manufacturerId">Manufacturer:</label>
        <select id="manufacturerId" name="manufacturerId">
            <c:forEach var="manufacturer" items="${manufacturers}">
                <option value="${manufacturer.id}" ${manufacturer.id == medicine.manufacturerId ? 'selected' : ''}>${manufacturer.name}</option>
            </c:forEach>
        </select>
    </div>

    <!-- Category -->
    <div>
        <label for="categoryId">Category:</label>
        <select id="categoryId" name="categoryId">
            <c:forEach var="category" items="${categories}">
                <option value="${category.id}" ${category.id == medicine.categoryId ? 'selected' : ''}>${category.name}</option>
            </c:forEach>
        </select>
    </div>

    <!-- Unit -->
    <div>
        <label for="unitId">Unit:</label>
        <select id="unitId" name="unitId">
            <c:forEach var="unit" items="${units}">
                <option value="${unit.id}" ${unit.id == medicine.unitId ? 'selected' : ''}>${unit.name}</option>
            </c:forEach>
        </select>
    </div>

    <!-- Image -->
    <div>
        <label for="image">Image:</label>
        <input type="file" id="image" name="image">
    </div>

    <div>
        <button type="submit">${medicine.id != null ? 'Update Medicine' : 'Add Medicine'}</button>
    </div>
</form>
</body>
</html>
