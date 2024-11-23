<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>${manufacturer.isEdit ? 'Chỉnh sửa Nhà Sản Xuất' : 'Thêm mới Nhà Sản Xuất'}</title>
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
        form {
            max-width: 400px;
            margin: auto;
        }
        table {
            width: 100%;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            text-align: right;
            vertical-align: top;
        }
        input[type="text"], input[type="hidden"] {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        a {
            display: inline-block;
            padding: 10px 15px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-left: 5px;
        }
        a:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
<h1>${manufacturer.isEdit ? 'Chỉnh sửa Nhà Sản Xuất' : 'Thêm mới Nhà Sản Xuất'}</h1>

<c:if test="${not empty message}">
    <p style="color: red;">${message}</p>
</c:if>

<form action="/vendor/manufacturer/save" method="post">
    <table>
        <tr>
            <c:if test="${manufacturer.isEdit}">
                <th>ID:</th>
                <td>${manufacturer.id}</td>
            </c:if>
        </tr>
        <tr>
            <th>Tên:</th>
            <td>
                <input type="text" name="name" value="${manufacturer.name}" required />
            </td>
        </tr>
    </table>
    <input type="hidden" name="isEdit" value="${manufacturer.isEdit}" />
    <button type="submit">${manufacturer.isEdit ? 'Cập nhật' : 'Thêm mới'}</button>
    <a href="/vendor/manufacturers">Hủy</a>
</form>
</body>
</html>
