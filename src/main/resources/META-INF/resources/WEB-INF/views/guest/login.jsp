<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:url value="/" var="URL"></c:url>

<section class="sign-in">
    <div class="container">
        <div class="signin-content">
            <div class="signin-image">
                <figure><img src="${URL}assets/images/signin-image.jpg" alt="Hình ảnh đăng nhập"></figure>
                <a href="/au/signup" class="signup-image-link">Tạo tài khoản mới</a>
            </div>

            <div class="signin-form">
                <h2 class="form-title">Đăng nhập</h2>

                <form action="/au/login/login-submit" method="post" class="register-form" id="login-form">
                    <div class="form-group">
                        <label for="phone"><i class="zmdi zmdi-account material-icons-name"></i></label>
                        <input type="text" name="phoneNumber" id="phone" placeholder="Số điện thoại" required pattern="^\d{10}$" title="Số điện thoại phải gồm 10 chữ số." />
                    </div>
                    <div class="form-group">
                        <label for="pass"><i class="zmdi zmdi-lock"></i></label>
                        <input type="password" name="password" id="pass" placeholder="Mật khẩu" required />
                    </div>
                    <div class="form-group">
                        <input type="checkbox" name="remember-me" id="remember-me" class="agree-term" />
                        <label for="remember-me" class="label-agree-term">
                            <span><span></span></span>Ghi nhớ tôi
                        </label>
                    </div>
                    <div class="form-group form-button">
                        <input type="submit" name="signin" id="signin"
                               class="form-submit" value="Đăng nhập" />
                        <a href="/au/forgot-password" class="forgot-pwd">Quên mật khẩu?</a>
                    </div>
                </form>
                <div class="social-login">
                    <span class="social-label">Hoặc đăng nhập bằng</span>
                    <ul class="socials">
                        <li><a href="/oauth2/authorization/google" title="Đăng nhập với Google"><i class="display-flex-center zmdi zmdi-google"></i></a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    <c:if test="${not empty success}">
    Swal.fire({
        icon: 'success',
        title: 'Thành công!',
        text: '${success}',
        confirmButtonText: 'OK'
    });
    </c:if>
    <c:if test="${not empty error}">
    Swal.fire({
        icon: 'error',
        title: 'Lỗi!',
        text: '${error}',
        confirmButtonText: 'OK'
    });
    </c:if>
</script>