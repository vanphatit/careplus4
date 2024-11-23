<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>${imp.id == null ? 'Add New Import' : 'Edit Import'}</title>
</head>
<body>
<h1>${imp.id == null ? 'Add New Import' : 'Edit Import'}</h1>

<form method="post" action="${pageContext.request.contextPath}/vendor/import/save">
    <!-- Import ID -->
    <label for="id">Import ID:</label>
    <input
            type="text"
            id="id"
            name="id"
            value="${imp.id}"
    ${imp.id != null ? 'readonly' : ''}
            required
    />
    <br/>

    <!-- Provider -->
    <label for="providerId">Provider:</label>
    <select id="providerId" name="providerId" required>
        <c:forEach var="provider" items="${providers}">
            <option value="${provider.id}"
                ${imp.providerId != null && provider.id == imp.providerId ? 'selected' : ''}>
                    ${provider.id} - ${provider.name}
            </option>
        </c:forEach>
    </select>


    <!-- Import Date -->
    <label for="date">Import Date:</label>
    <input
            type="date"
            id="date"
            name="date"
            value="${imp.date}"
            required
    />
    <br/>

    <!-- Total Amount -->
    <label for="totalAmount">Total Amount:</label>
    <input
            type="number"
            id="totalAmount"
            name="totalAmount"
            value="${imp.totalAmount}"
            step="0.01"
            required
    />
    <br/>

    <!-- Action Buttons -->
    <button type="submit">Save</button>
    <a href="${pageContext.request.contextPath}/vendor/import">Cancel</a>
</form>

</body>
</html>
