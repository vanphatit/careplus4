<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>

<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Tạo mới người dùng</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/users">Quản lý người dùng</a></li>
                    <li class="breadcrumb-item active">Tạo mới người dùng</li>
                </ol>

                <!-- Hiển thị thông báo -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${errorMessage}
                    </div>
                </c:if>
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${successMessage}
                    </div>
                </c:if>

                <div class="mt-5">
                    <div class="row">
                        <div class="col-md-8 mx-auto">
                            <div class="card">
                                <div class="card-body">
                                    <form action="/admin/user/new" method="post">
                                        <div class="row">
                                            <!-- Cột bên trái -->
                                            <div class="col-md-6">
                                                <!-- Số điện thoại -->
                                                <div class="mb-3">
                                                    <label for="phoneNumber" class="form-label">Số điện thoại</label>
                                                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber"
                                                           placeholder="Nhập số điện thoại" required pattern="^\d{10}$" title="Số điện thoại phải có 10 chữ số">
                                                </div>
                                                <!-- Tên -->
                                                <div class="mb-3">
                                                    <label for="name" class="form-label">Tên người dùng</label>
                                                    <input type="text" class="form-control" id="name" name="name"
                                                           placeholder="Nhập tên người dùng" required>
                                                </div>
                                                <!-- Email -->
                                                <div class="mb-3">
                                                    <label for="email" class="form-label">Email</label>
                                                    <input type="email" class="form-control" id="email" name="email"
                                                           placeholder="Nhập email" required
                                                           pattern="[a-zA-Z0-9._%+-]+@gmail\.com$"
                                                           title="Vui lòng nhập địa chỉ email thuộc miền @gmail.com">
                                                </div>
                                                <!-- Địa chỉ -->
                                                <div class="mb-3">
                                                    <label for="address" class="form-label">Địa chỉ</label>
                                                    <input type="text" class="form-control" id="address" name="address"
                                                           placeholder="Nhập địa chỉ" required>
                                                </div>
                                            </div>

                                            <!-- Cột bên phải -->
                                            <div class="col-md-6">
                                                <!-- Giới tính -->
                                                <div class="mb-3">
                                                    <label class="form-label">Giới tính</label>
                                                    <div>
                                                        <div class="form-check form-check-inline">
                                                            <input class="form-check-input" type="radio" name="gender"
                                                                   id="male" value="M" required>
                                                            <label class="form-check-label" for="male">Nam</label>
                                                        </div>
                                                        <div class="form-check form-check-inline">
                                                            <input class="form-check-input" type="radio" name="gender"
                                                                   id="female" value="F">
                                                            <label class="form-check-label" for="female">Nữ</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- Quyền -->
                                                <div class="mb-3">
                                                    <label for="role" class="form-label">Quyền</label>
                                                    <select class="form-control" id="role" name="role" required>
                                                        <option value="">Chọn quyền</option>
                                                        <option value="ADMIN">Admin</option>
                                                        <option value="VENDOR">Vendor</option>
                                                        <option value="USER">User</option>
                                                    </select>
                                                </div>
                                                <!-- Mật khẩu -->
                                                <div class="mb-3">
                                                    <label for="password" class="form-label">Mật khẩu</label>
                                                    <input type="password" class="form-control" id="password"
                                                           name="password" placeholder="Nhập mật khẩu" required>
                                                </div>
                                                <!-- Nhập lại mật khẩu -->
                                                <div class="mb-3">
                                                    <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                                                    <input type="password" class="form-control" id="confirmPassword"
                                                           name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <!-- Cột bên trái (nút "Tạo người dùng") -->
                                            <div class="col-md-6 text-start">
                                                <button type="submit" class="btn btn-primary">Tạo người dùng</button>
                                            </div>

                                            <!-- Cột bên phải (nút "Hủy") -->
                                            <div class="col-md-6 text-end">
                                                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Hủy</a>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
