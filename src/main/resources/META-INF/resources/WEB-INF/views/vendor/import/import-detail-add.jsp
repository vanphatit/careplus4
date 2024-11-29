<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Import Detail</title>
</head>
<body>
<h1>Add Import Detail for Import ID: ${importId}</h1>

<form action="${pageContext.request.contextPath}/vendor/import-detail/save-detail/${importId}" method="post">
    <label for="medicineId">Medicine ID:</label>
    <input type="text" id="medicineId" name="medicineId" value="${detail.medicineId}" required />
    <br />

    <label for="quantity">Quantity:</label>
    <input type="number" id="quantity" name="quantity" value="${detail.quantity}" required />
    <br />

    <label for="unitPrice">Unit Price:</label>
    <input type="number" id="unitPrice" name="unitPrice" value="${detail.unitPrice}" step="0.01" required />
    <br />

    <button type="submit">Save</button>
</form>

<a href="${pageContext.request.contextPath}/vendor/import">Back to Import List</a>
</body>
</html>
