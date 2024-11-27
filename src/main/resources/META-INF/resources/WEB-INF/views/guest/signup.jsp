<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:url value="/" var="URL"></c:url>

<!-- Sign up form -->
<section class="signup">
    <div class="container">
        <div class="signup-content">
            <div class="signup-form">
                <h2 class="form-title">Đăng ký</h2>

                <!-- Hiển thị thông báo lỗi và thông báo thành công -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger">
                            ${errorMessage}
                    </div>
                </c:if>
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success">
                            ${successMessage}
                    </div>
                </c:if>

                <form action="/au/signup/signup-submit" method="POST" class="register-form" id="register-form">
                    <!-- Name -->
                    <div class="form-group">
                        <label for="name"><i class="zmdi zmdi-account material-icons-name"></i></label>
                        <input type="text" name="name" id="name" placeholder="Tên của bạn" required maxlength="255"/>
                    </div>

                    <!-- Phone Number -->
                    <div class="form-group">
                        <label for="phone"><i class="zmdi zmdi-phone"></i></label>
                        <input type="text" name="phoneNumber" id="phone" placeholder="Số điện thoại" required pattern="^\d{10}$" title="Số điện thoại phải gồm 10 chữ số." maxlength="10"/>
                    </div>

                    <!-- Password -->
                    <div class="form-group">
                        <label for="pass"><i class="zmdi zmdi-lock"></i></label>
                        <input type="password" name="password" id="pass" placeholder="Mật khẩu" required maxlength="32"/>
                    </div>

                    <!-- Confirm Password -->
                    <div class="form-group">
                        <label for="re_pass"><i class="zmdi zmdi-lock-outline"></i></label>
                        <input type="password" name="re_pass" id="re_pass" placeholder="Nhập lại mật khẩu" required maxlength="32"/>
                    </div>

                    <!-- Gender -->
                    <div class="form-group">
                        <select name="gender" id="gender" required>
                            <option value="" disabled selected>Chọn giới tính</option>
                            <option value="M">Nam</option>
                            <option value="F">Nữ</option>
                        </select>
                    </div>

                    <!-- Email -->
                    <div class="form-group">
                        <label for="email"><i class="zmdi zmdi-email"></i></label>
                        <input type="email" name="email" id="email" placeholder="Email của bạn" required maxlength="255"/>
                    </div>

                    <!-- Address (Optional) -->
                    <div class="form-group">
                        <label for="address"><i class="zmdi zmdi-home"></i></label>
                        <input type="text" name="address" id="address" placeholder="Địa chỉ (Không bắt buộc)" maxlength="255"/>
                    </div>

                    <input type="text" name="role" style="visibility: hidden"
                            value="2">

                    <!-- Submit button -->
                    <div class="form-group form-button">
                        <input type="submit" name="signup" id="signup" class="form-submit" value="Đăng ký"/>
                    </div>
                </form>
            </div>
            <div class="signup-image">
                <figure><img src="${URL}assets/images/signup-image.jpg" alt="sign up image"></figure>
                <a href="/au/login" class="signup-image-link">Tôi đã có tài khoản rồi!!!</a>
            </div>
        </div>
    </div>
</section>
<!-- End of sign up form -->