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
                <h1 class="mt-4">Danh mục</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/vendor">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/vendor/categories">Danh mục</a></li>
                    <li class="breadcrumb-item active">Chi tiết</li>
                </ol>
                <div class="container mt-5">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <div class="d-flex justify-content-between">
                                <h3>Chi tiết với mã: ${category.id}</h3>
                            </div>

                            <hr />
                                <div class="card-header">
                                    Thông tin danh mục
                                </div>
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item">ID: ${category.id}</li>
                                    <li class="list-group-item">Tên danh mục: ${category.name}</li>
                                    <li class="list-group-item">Trạng tháng hoạt động: ${category.status == 'true' ? 'Hoạt động' : 'Ngưng'}</li>
                                    <li class="list-group-item">Loại: ${category.parentCategory.name != null ? category.parentCategory.name : 'None'}</li>
                                </ul>
                            </div>
                        </div>
                    <a href="/vendor/categories" class="btn btn-info mt-3">Quay lại</a>
                    </div>
                </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
</body>

</html>