<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>${unit.isEdit ? "Edit Unit" : "Add Unit"}</title>
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
        form {
            max-width: 400px;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        form div {
            margin-bottom: 15px;
        }
        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        a {
            text-decoration: none;
            color: #007bff;
        }
        a:hover {
            text-decoration: underline;
        }
        .message {
            text-align: center;
            margin-top: 20px;
            color: green;
        }
    </style>
</head>
<body>
<h1>${unit.isEdit ? "Edit Unit" : "Add Unit"}</h1>
<form action="/admin/unit/save" method="post">
    <input type="hidden" name="isEdit" value="${unit.isEdit}" />
    <div>
        <c:if test="${unit.isEdit}">
            <label for="id">Unit ID</label>
            <input type="text" id="id" name="id" value="${unit.id}" readonly />
        </c:if>
    </div>
    <div>
        <label for="name">Unit Name</label>
        <input type="text" id="name" name="name" value="${unit.name}" required />
        <c:if test="${not empty errors['name']}">
            <span>${errors['name']}</span>
        </c:if>
    </div>
    <div>
        <button type="submit">${unit.isEdit ? "Update" : "Save"}</button>
        <a href="/admin/units">Cancel</a>
    </div>
</form>
<c:if test="${not empty message}">
    <p class="message">${message}</p>
</c:if>
</body>
</html>
