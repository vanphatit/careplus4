<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>

<body class="sb-nav-fixed">
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Manage Categories</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Categories</li>
                </ol>
                <div class="mt-5">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <div class="d-flex justify-content-between">
                                <h3>Table categories</h3>
                                <a href="/admin/category/create" class="btn btn-outline-info">Create a category</a>
                            </div>

                            <hr />
                            <table class=" table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Status</th>
                                    <th>Type ID</th>
                                    <th>Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="category" items="${categories}">
                                    <tr>
                                        <th>${category.id}</th>
                                        <td>${category.name}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${category.status}">
                                                    Active
                                                </c:when>
                                                <c:otherwise>
                                                    Off
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${category.parentCategory.id}</td>
                                        <td>
                                            <a href="/admin/category/${category.id}"
                                               class="btn btn-success">View</a>
                                            <a href="/admin/category/update/${category.id}"
                                               class="btn btn-warning  mx-2">Update</a>
                                            <a href="/admin/category/delete/${category.id}"
                                               class="btn btn-danger">Delete</a>
                                        </td>
                                    </tr>

                                </c:forEach>

                                </tbody>
                            </table>
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="/admin/categories?page=${currentPage-1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <c:forEach begin="1" end="${pageNo}" var="i">
                                        <c:choose>
                                            <c:when test="${currentPage == i}">
                                                <li class="page-item active">
                                                    <a class="page-link" href="/admin/categories?page=${i}">${i}</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item">
                                                    <a class="page-link" href="/admin/categories?page=${i}">${i}</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <li class="page-item ${currentPage == pageNo ? 'disabled' : ''}">
                                        <a class="page-link" href="/admin/categories?page=${currentPage + 1}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                            <span class="sr-only">Next</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
</body>

</html>