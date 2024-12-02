<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>
<div class="container mt-5" style="padding-bottom: 20px !important">
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <div class="card">
                <div class="card-header bg-primary text-white" style="background-color: #0077b6 !important">
                    <h5 class="mb-0">Chỉnh sửa hồ sơ</h5>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/user/updateProfile" method="post">
                        <div class="mb-3">
                            <label for="name" class="form-label">Họ và tên</label>
                            <input type="text" class="form-control" id="name" name="name" value="${user.name}" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="${user.email}" disabled>
                        </div>
                        <div class="mb-3">
                            <label for="phoneNumber" class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" disabled>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Giới tính</label>
                            <div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="gender" id="genderMale" value="M" ${user.gender == 'M' ? 'checked' : ''}>
                                    <label class="form-check-label" for="genderMale">Nam</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="gender" id="genderFemale" value="F" ${user.gender == 'F' ? 'checked' : ''}>
                                    <label class="form-check-label" for="genderFemale">Nữ</label>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Địa chỉ</label>
                            <input type="text" class="form-control" id="address" name="address" value="${user.address}">
                        </div>
                        <div class="text-end">
                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                            <a href="${pageContext.request.contextPath}/user/userInfo" class="btn btn-secondary">Hủy</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>