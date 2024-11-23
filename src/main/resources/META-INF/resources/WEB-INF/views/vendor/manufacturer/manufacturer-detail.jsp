<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Chi tiết Nhà Sản Xuất</title>
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
            width: 50%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        a {
            display: inline-block;
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 10px;
        }
        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<h1>Chi tiết Nhà Sản Xuất</h1>

<c:if test="${not empty message}">
    <p style="color: green;">${message}</p>
</c:if>

<table>
    <tr>
        <th>ID:</th>
        <td>${manufacturer.id}</td>
    </tr>
    <tr>
        <th>Tên:</th>
        <td>${manufacturer.name}</td>
    </tr>
</table>

<a href="/vendor/manufacturers">Quay lại danh sách</a>
</body>
</html>
