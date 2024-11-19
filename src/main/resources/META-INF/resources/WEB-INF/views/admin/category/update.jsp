<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<body class="sb-nav-fixed">
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Update Category</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/categories">Categories</a></li>
                    <li class="breadcrumb-item active">Update</li>
                </ol>
                <div class="container mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <h3>Update Category</h3>
                            <hr />
                            <form method="POST" action="/admin/category/update" class="row">
                                <!-- ID (hidden) -->
                                <div class="mb-3" style="display: none;" aria-disabled="true">
                                    <label class="form-label">Id:</label>
                                    <input type="text" class="form-control" name="id" value="${currentCategory.id}" />
                                </div>

                                <!-- Name -->
                                <div class="mb-3 col-12">
                                    <label class="form-label">Name:</label>
                                    <input type="text" class="form-control" name="name" value="${currentCategory.name}" />
                                </div>

                                <!-- Status -->
                                <div class="mb-3 col-12">
                                    <label class="form-label">Status:</label>
                                    <select class="form-control" name="status">
                                        <option value="true" ${currentCategory.status == 'true' ? 'selected' : ''}>Active</option>
                                        <option value="false" ${currentCategory.status == 'false' ? 'selected' : ''}>Inactive</option>
                                    </select>
                                </div>

                                <!-- Parent Category -->
                                <div class="mb-3 col-12">
                                    <label class="form-label">Parent Category:</label>
                                    <select class="form-control" name="parentCategoryId">
                                        <option value="">No Parent</option>
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.id}" ${currentCategory.parentCategory.id == category.id ? 'selected' : ''}>
                                                    ${category.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Submit Button -->
                                <div class="col-12">
                                    <button type="submit" class="btn btn-warning">Update Category</button>
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
