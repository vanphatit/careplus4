<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Medicine Detail</title>
</head>
<body>
<h1>Medicine Detail</h1>
<table>
    <tr>
        <th>ID</th>
        <td>${medicine.id}</td>
    </tr>
    <tr>
        <th>Name</th>
        <td>${medicine.name}</td>
    </tr>
    <tr>
        <th>Description</th>
        <td>${medicine.description}</td>
    </tr>
    <tr>
        <th>Unit Cost</th>
        <td>${medicine.unitCost}</td>
    </tr>
    <tr>
        <th>Expiry Date</th>
        <td>${medicine.expiryDate}</td>
    </tr>
    <tr>
        <th>Import Date</th>
        <td>${medicine.importDate}</td>
    </tr>
    <tr>
        <th>Stock Quantity</th>
        <td>${medicine.stockQuantity}</td>
    </tr>
    <tr>
        <th>Dosage</th>
        <td>${medicine.dosage}</td>
    </tr>
    <tr>
        <th>Rating</th>
        <td>${medicine.rating}</td>
    </tr>
    <tr>
        <th>Manufacturer</th>
        <td>${medicine.manufacturer.name}</td>
    </tr>
    <tr>
        <th>Category</th>
        <td>${medicine.category.name}</td>
    </tr>
    <tr>
        <th>Unit</th>
        <td>${medicine.unit.name}</td>
    </tr>
    <tr>
        <th>Image</th>
        <td>
            <img src="${pageContext.request.contextPath}/uploads/${medicine.image}" alt="${medicine.name}" width="200">
        </td>
    </tr>
</table>
<a href="${pageContext.request.contextPath}/vendor/medicines">Back to List</a>
</body>
</html>
