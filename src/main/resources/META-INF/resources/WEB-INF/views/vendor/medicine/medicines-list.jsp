<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Medicine List</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
        .pagination {
            margin: 20px 0;
            text-align: center;
        }
        .pagination a {
            padding: 8px 12px;
            margin: 0 4px;
            border: 1px solid #ddd;
            text-decoration: none;
            color: #007bff;
        }
        .pagination a:hover {
            background-color: #007bff;
            color: white;
        }
        .pagination .current {
            background-color: #007bff;
            color: white;
            pointer-events: none;
        }
    </style>
</head>
<body>
<h1>Medicines List</h1>
<a href="${pageContext.request.contextPath}/vendor/medicine/add">Add Medicine</a>
<table>
    <thead>
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
                <a href="${pageContext.request.contextPath}/vendor/medicine/${medicine.id}">View</a>
                <a href="${pageContext.request.contextPath}/vendor/medicine/edit/${medicine.id}">Edit</a>
                <a href="${pageContext.request.contextPath}/vendor/medicine/delete/${medicine.id}">Delete</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<div class="pagination">
    <c:forEach begin="1" end="${pageNumbers.size()}" var="page">
        <a href="${pageContext.request.contextPath}/vendor/medicines?page=${page}&size=${pageSize}"
           class="${page == currentPage ? 'current' : ''}">${page}</a>
    </c:forEach>
</div>
</body>
</html>
