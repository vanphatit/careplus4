<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Units List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            color: #333;
        }
        .container {
            max-width: 900px;
            margin: 40px auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #007bff;
            margin-bottom: 20px;
        }
        .form-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .form-container form {
            display: flex;
            align-items: center;
        }
        .form-container input {
            padding: 10px;
            width: 250px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-right: 10px;
        }
        .form-container button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .form-container button:hover {
            background-color: #0056b3;
        }
        .form-container a {
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .form-container a:hover {
            background-color: #218838;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        table th {
            background-color: #007bff;
            color: white;
            text-transform: uppercase;
        }
        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        table tr:hover {
            background-color: #f1f1f1;
        }
        table td a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
            margin-right: 10px;
        }
        table td a:hover {
            text-decoration: underline;
        }
        .pagination {
            text-align: center;
            margin-top: 20px;
        }
        .pagination a {
            margin: 0 5px;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-decoration: none;
            color: #007bff;
            transition: background-color 0.3s;
        }
        .pagination a.active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
        .pagination a:hover {
            background-color: #0056b3;
            color: white;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Units List</h1>
    <!-- Search and Add Buttons -->
    <div class="form-container">
        <form action="/admin/unit/search" method="get">
            <input type="text" id="search" name="name" placeholder="Search by name" />
            <button type="submit">Search</button>
        </form>
        <a href="/admin/unit/add">Add New Unit</a>
    </div>
    <!-- Units Table -->
    <table>
        <thead>
        <tr>
            <th>Unit ID</th>
            <th>Unit Name</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${units.content}" var="unit">
            <tr>
                <td>${unit.id}</td>
                <td>${unit.name}</td>
                <td>
                    <a href="/admin/unit/${unit.id}">View</a>
                    <a href="/admin/unit/edit/${unit.id}">Edit</a>
                    <a href="/admin/unit/delete/${unit.id}" onclick="return confirm('Are you sure you want to delete this unit?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <!-- Pagination -->
    <div class="pagination">
        <c:if test="${not empty pageNumbers}">
            <c:forEach items="${pageNumbers}" var="pageNumber">
                <a href="/admin/units?page=${pageNumber}&size=${pageSize}" class="${pageNumber == currentPage ? 'active' : ''}">
                        ${pageNumber}
                </a>
            </c:forEach>
        </c:if>
    </div>
</div>
</body>
</html>
