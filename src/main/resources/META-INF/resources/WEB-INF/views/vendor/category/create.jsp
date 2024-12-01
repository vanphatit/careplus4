<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<body class="sb-nav-fixed">
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Tạo mới danh mục</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/vendor">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/vendor/categories">Danh mục</a></li>
                    <li class="breadcrumb-item active">Tạo mới</li>
                </ol>
                <div class="mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <h3>Tạo mới</h3>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" style="background-color: red; color: white; font-weight: bold;" role="alert">
                                        ${error}!
                                </div>
                            </c:if>
                            <hr />
                            <form method="POST" action="/vendor/category/create" class="row">
                                <div class="mb-3 col-12">
                                    <label class="form-label" for="id">ID:</label>
                                    <input type="text" class="form-control" id="id" name="id" />
                                </div>

                                <div class="mb-3 col-12">
                                    <label class="form-label" for="name">Tên danh mục:</label>
                                    <input type="text" class="form-control" id="name" name="name" />
                                    <c:if test="${not empty errors}">
                                        <div class="invalid-feedback">${errors['name']}</div>
                                    </c:if>
                                </div>

                                <div class="mb-3 col-12">
                                    <label class="form-label" for="parentCategory">Loại:</label>
                                    <select id="parentCategory" name="parentCategoryId" class="form-control">
                                        <option value="">Loại</option>
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="mb-3 col-12">
                                    <label class="form-label" for="status">Trạng thái hoạt động: </label>
                                    <select id="status" name="status" class="form-control">
                                        <option value="true">Hoạt động</option>
                                        <option value="false">Ngưng</option>
                                    </select>
                                </div>

                                <div class="col-12 mb-5">
                                    <a href="/vendor/categories" class="btn btn-success">Quay lại</a>
                                    <button type="submit" class="btn btn-primary">Tạo</button>
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
