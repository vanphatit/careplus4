
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>

<div class="container mt-5" style="margin-bottom: 20px">
    <div class="row">
        <div class="col-md-3">
            <div class="card text-center">
                <div class="card-body">
                    <img src="https://robohash.org/2dab52ee00bb7aa7bbba0355182b4141?set=set4&bgset=&size=400x400" alt="User Avatar" class="img-fluid rounded-circle mb-3" style="width: 120px;">
                    <h5 class="card-title">${user.name}</h5>
                    <p class="card-text text-muted">${user.phoneNumber}</p>
                    <p class="card-text text-muted">${user.email}</p>
                </div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">
                        <a href="${pageContext.request.contextPath}/user/userInfo" class="text-decoration-none"
                           style="color: #0077b6 !important">
                            <i class="fas fa-user"></i> Hồ sơ</a></li>
                    <li class="list-group-item">
                        <a href="#" class="text-decoration-none"
                           style="color: #0077b6 !important">
                        <i class="fas fa-calendar-alt"></i> Hoạt động gần đây</a></li>
                    <li class="list-group-item">
                        <a href="${pageContext.request.contextPath}/user/updateProfile" class="text-decoration-none"
                           style="color: #0077b6 !important">
                            <i class="fas fa-edit"></i> Chỉnh sửa hồ sơ</a></li>
                    <li class="list-group-item">
                        <a href="${pageContext.request.contextPath}/user/changePassword" class="text-decoration-none"
                           style="color: #0077b6 !important">
                            <i class="fas fa-edit"></i> Đổi mật khẩu</a></li>
                </ul>
            </div>
        </div>
        <div class="col-md-9">
            <div class="card mt-4">
                <div class="card-header bg-primary text-white" style="background-color: #0077b6 !important">
                    <h5 class="mb-0">Thông tin cá nhân</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Tên:</strong> ${user.name}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Email:</strong> ${user.email}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Số điện thoại:</strong> ${user.phoneNumber}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Giới tính:</strong> ${user.gender == 'M' ? 'Nam' : 'Nữ'}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Địa chỉ:</strong> ${user.address}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Điểm thưởng:</strong> ${user.pointEarned}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Ngày tạo:</strong> ${user.createdAt}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Ngày cập nhật:</strong> ${user.updatedAt}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>