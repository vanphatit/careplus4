<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medicine Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        h1 {
            text-align: center;
            margin: 20px 0;
        }
        table {
            width: 60%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        td img {
            display: block;
            max-width: 150px;
            height: auto;
        }
        .back-link {
            display: block;
            text-align: center;
            margin: 20px auto;
        }
        .back-link a {
            text-decoration: none;
            color: #007bff;
            border: 1px solid #007bff;
            padding: 8px 12px;
            border-radius: 5px;
        }
        .back-link a:hover {
            background-color: #007bff;
            color: #fff;
        }
    </style>
</head>
<body>
<h1>Medicine Details</h1>

<!-- Hiển thị thông tin thuốc -->
<table>
    <tr>
        <th>Name</th>
        <td>${medicine.name}</td>
    </tr>
    <tr>
        <th>Description</th>
        <td>${medicine.description}</td>
    </tr>
    <tr>
        <th>Category</th>
        <td>${medicine.categoryName}</td>
    </tr>
    <tr>
        <th>Manufacturer</th>
        <td>${medicine.manufacturerName}</td>
    </tr>
    <tr>
        <th>Unit Name</th>
        <td>${medicine.unitName}</td>
    </tr>
    <tr>
        <th>Unit Cost</th>
        <td>${medicine.unitCost}</td>
    </tr>
    <tr>
        <th>Stock Quantity</th>
        <td>${medicine.stockQuantity}</td>
    </tr>
    <tr>
        <th>Rating</th>
        <td>${medicine.rating}</td>
    </tr>
    <tr>
        <th>Expiry Date</th>
        <td>${medicine.expiryDate}</td>
    </tr>
    <tr>
        <th>Dosage</th>
        <td>${medicine.dosage}</td>
    </tr>
    <tr>
        <th>Image</th>
        <td>
            <img src="${medicine.image}" alt="${medicine.name}">
        </td>
    </tr>
</table>

<!-- Nút quay lại -->
<div class="back-link">
    <a href="${pageContext.request.contextPath}/user/medicine/filter">Back to List</a>
</div>
</body>
</html>
