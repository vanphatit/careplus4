<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Danh sách Nhà Sản Xuất</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 20px;
            background-color: #f9f9f9;
        }
        h1 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        table thead {
            background-color: #007bff;
            color: white;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            text-transform: uppercase;
            font-size: 14px;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        td a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
        td a:hover {
            text-decoration: underline;
        }
        .pagination {
            margin-top: 20px;
            text-align: center;
        }
        .pagination a {
            padding: 8px 12px;
            margin: 0 5px;
            text-decoration: none;
            color: #007bff;
            border: 1px solid #ddd;
            border-radius: 4px;
            transition: 0.3s;
        }
        .pagination a:hover {
            background-color: #007bff;
            color: white;
        }
        .btn-add {
            display: inline-block;
            padding: 10px 15px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 10px;
            transition: 0.3s;
        }
        .btn-add:hover {
            background-color: #218838;
        }
        .center {
            text-align: center;
        }
    </style>
</head>
<body>
<h1>Danh sách Nhà Sản Xuất</h1>

<c:if test="${not empty message}">
    <p style="color: red;">${message}</p>
</c:if>

<table>
    <thead>
    <tr>
        <th class="center">ID</th>
        <th>Tên</th>
        <th class="center">Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="manufacturer" items="${manufacturers.content}">
        <tr>
            <td class="center">${manufacturer.id}</td>
            <td>${manufacturer.name}</td>
            <td class="center">
                <a href="<c:url value='/vendor/manufacturer/${manufacturer.id}'/>">Chi tiết</a> |
                <a href="<c:url value='/vendor/manufacturer/edit/${manufacturer.id}'/>">Sửa</a> |
                <a href="<c:url value='/vendor/manufacturer/delete/${manufacturer.id}'/>">Xóa</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<div class="pagination">
    <c:if test="${not empty pageNumbers}">
        <c:forEach var="page" items="${pageNumbers}">
            <a href="<c:url value='/vendor/manufacturers?page=${page}&size=${pageSize}'/>">${page}</a>
        </c:forEach>
    </c:if>
</div>

<a href="<c:url value='/vendor/manufacturer/add'/>" class="btn-add">Thêm mới Nhà Sản Xuất</a>
</body>
</html>
