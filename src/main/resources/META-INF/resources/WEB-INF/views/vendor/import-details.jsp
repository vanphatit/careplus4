<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Import Details</title>
</head>
<body>
<h1>Import</h1>

<!-- Hiển thị thông tin chung về Import -->
<c:choose>
    <c:when test="${importEntity != null}">
        <table border="1" style="width: 50%; margin-bottom: 20px;">
            <tr>
                <th>ID</th>
                <td>${importEntity.id}</td>
            </tr>
            <tr>
                <th>Provider ID</th>
                <td>${importEntity.provider.id}</td>
            </tr>
            <tr>
                <th>Provider Name</th>
                <td>${importEntity.provider.name}</td>
            </tr>
            <tr>
                <th>Date</th>
                <td><fmt:formatDate value="${importEntity.date}" pattern="yyyy-MM-dd" /></td>
            </tr>
            <tr>
                <th>Total Amount</th>
                <td><fmt:formatNumber value="${importEntity.totalAmount}" type="number" groupingUsed="true" /></td>
            </tr>
        </table>
    </c:when>
    <c:otherwise>
        <p>No import details available.</p>
        <a href="${pageContext.request.contextPath}/vendor/import">Back to List</a>
    </c:otherwise>
</c:choose>

<!-- Hiển thị danh sách chi tiết ImportDetail -->
<c:choose>
    <c:when test="${importDetails != null}">
        <h2>Import Detail List</h2>
        <table border="1" style="width: 100%;">
            <thead>
            <tr>
                <th>STT</th>
                <th>Medicine ID</th>
                <th>Medicine Name</th>
                <th>Quantity</th>
                <th>Unit Price</th>
                <th>Sub Total</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="detail" items="${importDetails}" varStatus="iter">
                <tr>
                    <td>${iter.index + 1}</td>
                    <td>${detail.medicine.id}</td>
                    <td>${detail.medicine.name}</td>
                    <td>${detail.quantity}</td>
                    <td>
                        <fmt:formatNumber value="${detail.unitPrice}" type="currency" currencySymbol="$" />
                    </td>
                    <td>
                        <fmt:formatNumber value="${detail.subTotal}" type="currency" currencySymbol="$" />
                    </td>
                    <td><a href="${pageContext.request.contextPath}/vendor/import-detail/delete-detail/${detail.id}">Delete</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <p>No import items found for this import.</p>
    </c:otherwise>
</c:choose>

<a href="${pageContext.request.contextPath}/vendor/import">Back to List</a>
</body>
</html>
