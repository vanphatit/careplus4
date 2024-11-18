<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<body class="sb-nav-fixed">
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Category</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/categories">Categories</a></li>
                    <li class="breadcrumb-item active">View details</li>
                </ol>
                <div class="container mt-5">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <div class="d-flex justify-content-between">
                                <h3>Category detail with id = ${category.id}</h3>
                            </div>

                            <hr />
                                <div class="card-header">
                                    Product information
                                </div>
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item">ID: ${category.id}</li>
                                    <li class="list-group-item">Name: ${category.name}</li>
                                    <li class="list-group-item">Status: ${category.status == 'true' ? 'Active' : 'Inactive'}</li>
                                    <li class="list-group-item">Type: ${category.parentCategory.name != null ? category.parentCategory.name : 'None'}</li>
                                </ul>
                            </div>
                        </div>
                    <a href="/admin/categories" class="btn btn-info mt-3">Back</a>
                    </div>
                </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
</body>

</html>