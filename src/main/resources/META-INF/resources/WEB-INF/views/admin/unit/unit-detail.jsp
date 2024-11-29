<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Unit Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f9;
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .details-container {
            max-width: 500px;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .details-container p {
            font-size: 16px;
            margin: 10px 0;
        }
        .details-container p strong {
            color: #333;
        }
        .actions {
            text-align: center;
            margin-top: 20px;
        }
        .actions a {
            margin: 0 10px;
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }
        .actions a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<h1>Unit Details</h1>
<div class="details-container">
    <p><strong>Unit ID:</strong> ${unit.id}</p>
    <p><strong>Unit Name:</strong> ${unit.name}</p>
    <div class="actions">
        <a href="/admin/unit/edit/${unit.id}">Edit</a>
        <a href="/admin/unit/delete/${unit.id}" onclick="return confirm('Are you sure you want to delete this unit?')">Delete</a>
        <a href="/admin/units">Back to List</a>
    </div>
</div>
<c:if test="${not empty message}">
    <p class="message">${message}</p>
</c:if>
</body>
</html>
