<body>
<h1>Confirm Delete</h1>

<c:if test="${not empty error}">
    <p style="color: red;">${error}</p>
</c:if>

<p>Are you sure you want to delete this import?</p>

<table border="1">
    <tr>
        <th>ID</th>
        <td>${imp.id}</td>
    </tr>
    <tr>
        <th>Provider</th>
        <td>${imp.provider.name}</td>
    </tr>
    <tr>
        <th>Date</th>
        <td>${imp.date}</td>
    </tr>
    <tr>
        <th>Total Amount</th>
        <td>${imp.totalAmount}</td>
    </tr>
</table>

<form method="post" action="${pageContext.request.contextPath}/vendor/import/delete/${imp.id}">
    <c:if test="${!hasImportDetail}">
        <button type="submit">Delete</button>
    </c:if>
    <a href="${pageContext.request.contextPath}/vendor/import">Cancel</a>
</form>

</body>
