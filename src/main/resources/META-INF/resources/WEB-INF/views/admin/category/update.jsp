<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<body class="sb-nav-fixed">
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Cập nhật danh mục</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/categories">Danh mục</a></li>
                    <li class="breadcrumb-item active">Cập nhật</li>
                </ol>
                <div class="container mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <h3>Cập nhật danh mục</h3>
                            <hr />
                            <form method="POST" action="/admin/category/update" class="row">
                                <!-- ID (hidden) -->
                                <div class="mb-3" style="display: none;" aria-disabled="true">
                                    <label class="form-label">Id:</label>
                                    <input type="text" class="form-control" name="id" value="${currentCategory.id}" />
                                </div>

                                <!-- Name -->
                                <div class="mb-3 col-12">
                                    <label class="form-label">Tên danh mục:</label>
                                    <input type="text" class="form-control" name="name" value="${currentCategory.name}" />
                                </div>

                                <!-- Status -->
                                <div class="mb-3 col-12">
                                    <label class="form-label">Trạng thái hoạt động:</label>
                                    <select class="form-control" name="status">
                                        <option value="true" ${currentCategory.status == 'true' ? 'selected' : ''}>Hoạt động</option>
                                        <option value="false" ${currentCategory.status == 'false' ? 'selected' : ''}>Ngưng</option>
                                    </select>
                                </div>

                                <!-- Parent Category -->
                                <div class="mb-3 col-12">
                                    <label class="form-label">Loại:</label>
                                    <select class="form-control" name="parentCategoryId">
                                        <option value="">Loại</option>
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.id}" ${currentCategory.parentCategory.id == category.id ? 'selected' : ''}>
                                                    ${category.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Submit Button -->
                                <div class="col-12">
                                    <button type="submit" class="btn btn-warning">Cập nhật</button>
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
