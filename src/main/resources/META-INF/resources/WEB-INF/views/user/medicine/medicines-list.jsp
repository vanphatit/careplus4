<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medicines List</title>
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
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        a {
            text-decoration: none;
            color: #007bff;
        }
        a:hover {
            text-decoration: underline;
        }
        .pagination {
            text-align: center;
            margin: 20px 0;
        }
        .pagination a {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 5px;
            border: 1px solid #ddd;
            background-color: #fff;
            color: #007bff;
            border-radius: 5px;
        }
        .pagination a:hover {
            background-color: #007bff;
            color: #fff;
        }
        .pagination .current-page {
            background-color: #007bff;
            color: #fff;
            border: 1px solid #007bff;
            pointer-events: none;
        }
    </style>
</head>
<body>
<h1>Medicines List</h1>

<!-- Hiển thị thông báo lỗi nếu có -->
<c:if test="${not empty message}">
    <p style="color: red; text-align: center;">${message}</p>
</c:if>

<!-- Bảng danh sách thuốc -->
<table>
    <thead>
    <tr>
        <th>Name</th>
        <th>Category</th>
        <th>Manufacturer</th>
        <th>Unit Cost</th>
        <th>Stock Quantity</th>
        <th>Rating</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="medicine" items="${medicines}">
        <tr>
            <td>${medicine.name}</td>
            <td>${medicine.categoryName}</td>
            <td>${medicine.manufacturerName}</td>
            <td>${medicine.unitCost}</td>
            <td>${medicine.stockQuantity}</td>
            <td>${medicine.rating}</td>
            <td>
                <a href="${pageContext.request.contextPath}/user/medicine/detail?id=${medicine.id}">View Details</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<!-- Phân trang -->
<div class="pagination">
    <c:if test="${currentPage > 1}">
        <a href="${pageContext.request.contextPath}/user/medicine/filter?page=${currentPage - 1}&size=${pageSize}">Previous</a>
    </c:if>
    <c:forEach begin="1" end="${totalPages}" var="page">
        <a href="${pageContext.request.contextPath}/user/medicine/filter?page=${page}&size=${pageSize}"
           class="${page == currentPage ? 'current-page' : ''}">${page}</a>
    </c:forEach>
    <c:if test="${currentPage < totalPages}">
        <a href="${pageContext.request.contextPath}/user/medicine/filter?page=${currentPage + 1}&size=${pageSize}">Next</a>
    </c:if>
</div>
</body>
</html>
