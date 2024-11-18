<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create New Category</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="sb-nav-fixed">
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Create new Category</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/categories">Categories</a></li>
                    <li class="breadcrumb-item active">Create</li>
                </ol>
                <div class="mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <h3>Create a category</h3>
                            <hr />
                            <form method="POST" action="/admin/category/create" class="row">
                                <div class="mb-3 col-12">
                                    <label class="form-label" for="id">ID:</label>
                                    <input type="text" class="form-control" id="id" name="id" />
                                </div>

                                <div class="mb-3 col-12">
                                    <label class="form-label" for="name">Name:</label>
                                    <input type="text" class="form-control" id="name" name="name" />
                                    <c:if test="${not empty errors}">
                                        <div class="invalid-feedback">${errors['name']}</div>
                                    </c:if>
                                </div>

                                <div class="mb-3 col-12">
                                    <label class="form-label" for="parentCategory">Parent Category:</label>
                                    <select id="parentCategory" name="parentCategoryId" class="form-control">
                                        <option value="">Select a Parent Category</option>
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="mb-3 col-12">
                                    <label class="form-label" for="status">Status: </label>
                                    <select id="status" name="status" class="form-control">
                                        <option value="true">Active</option>
                                        <option value="false">Inactive</option>
                                    </select>
                                </div>

                                <div class="col-12 mb-5">
                                    <button type="submit" class="btn btn-primary">Create</button>
                                    <a href="/admin/categories" class="btn btn-success">Back</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
