<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>

<div class="container mt-5">
    <h1 class="text-center text-primary mb-4">Units List</h1>

    <!-- Search and Add Buttons -->
    <div class="row mb-4">
        <div class="col-md-8">
            <form action="/admin/unit/search" method="get" class="d-flex">
                <input type="text" id="search" name="name" placeholder="Search by name" class="form-control me-2">
                <button type="submit" class="btn btn-primary">Search</button>
            </form>
        </div>
        <div class="col-md-4 text-end">
            <a href="/admin/unit/add" class="btn btn-success">Add New Unit</a>
        </div>
    </div>

    <!-- Units Table -->
    <div class="table-responsive">
        <table class="table table-bordered table-striped align-middle">
            <thead class="table-primary">
            <tr>
                <th scope="col" class="text-center">Unit ID</th>
                <th scope="col">Unit Name</th>
                <th scope="col" class="text-center">Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${units.content}" var="unit">
                <tr>
                    <td class="text-center">${unit.id}</td>
                    <td>${unit.name}</td>
                    <td class="text-center">
                        <a href="/admin/unit/${unit.id}" class="btn btn-sm btn-info text-white">View</a>
                        <a href="/admin/unit/edit/${unit.id}" class="btn btn-sm btn-warning text-white">Edit</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Pagination -->
    <nav>
        <ul class="pagination justify-content-center">
            <c:if test="${not empty pageNumbers}">
                <c:forEach items="${pageNumbers}" var="pageNumber">
                    <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                        <a href="/admin/units?page=${pageNumber}&size=${pageSize}" class="page-link">${pageNumber}</a>
                    </li>
                </c:forEach>
            </c:if>
        </ul>
    </nav>
</div>
