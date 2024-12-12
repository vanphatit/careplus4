<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:url value="/" var="URL"></c:url>

<style>
    /* Bố cục hàng cho phần OTP */
    .otp-row {
        display: flex;
        align-items: center; /* Căn giữa theo chiều dọc */
        gap: 10px; /* Khoảng cách giữa các thành phần */
        margin-bottom: 15px;
    }

    /* Icon */
    .input-label {
        display: flex;
        align-items: center; /* Đảm bảo icon căn giữa với input */
    }

    .input-label .icon {
        font-size: 18px; /* Điều chỉnh kích thước icon */
        color: #555;
        margin-right: 8px; /* Khoảng cách giữa icon và input */
        line-height: 1; /* Đảm bảo chiều cao đồng bộ */
    }

    /* Input */
    .otp-row input {
        flex: 1;
        padding: 10px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 5px;
        outline: none;
        transition: border-color 0.2s ease;
    }

    .otp-row input:focus {
        border-color: #007bff;
        box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
    }

    /* Nút Gửi OTP */
    .otp-row .btn {
        padding: 10px 15px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.2s ease;
        white-space: nowrap;
    }

    .otp-row .btn:hover {
        background-color: #0056b3;
    }
</style>

<!-- Sign up form -->
<section class="signup">
    <div class="container">
        <div class="signup-content">
            <div class="signup-form">
                <h2 class="form-title">Đăng ký</h2>

                <form action="/au/signup/signup-submit" method="post" class="register-form" id="register-form">

                    <!-- Phone Number -->
                    <div class="form-group">
                        <label for="phone"><i class="zmdi zmdi-phone"></i></label>
                        <input type="text" name="phone" id="phone" placeholder="Số điện thoại" required pattern="^\d{10}$" title="Số điện thoại phải gồm 10 chữ số." maxlength="10"/>
                    </div>

                    <!-- Name -->
                    <div class="form-group">
                        <label for="fullName"><i class="zmdi zmdi-account material-icons-name"></i></label>
                        <c:choose>
                            <c:when test="${not empty name}">
                                <input type="text" name="fullName" id="fullName" placeholder="Tên của bạn" required maxlength="255" value="${name}"/>
                            </c:when>
                            <c:otherwise>
                                <input type="text" name="fullName" id="fullName" placeholder="Tên của bạn" required maxlength="255"/>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Password -->
                    <div class="form-group">
                        <label for="pass"><i class="zmdi zmdi-lock"></i></label>
                        <input type="password" name="password" id="pass" placeholder="Mật khẩu" required maxlength="32"/>
                    </div>

                    <!-- Confirm Password -->
                    <div class="form-group">
                        <label for="rePassword"><i class="zmdi zmdi-lock-outline"></i></label>
                        <input type="password" name="rePassword" id="rePassword" placeholder="Nhập lại mật khẩu" required maxlength="32"/>
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
                        <c:choose>
                            <c:when test="${not empty email}">
                                <input type="email" name="email" id="email" placeholder="Email của bạn" required maxlength="255" value="${email}" readonly/>
                            </c:when>
                            <c:otherwise>
                                <input type="email" name="email" id="email" placeholder="Email của bạn" required maxlength="255"/>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <c:if test="${empty email}">
                        <!-- OTP -->
                        <div class="form-group otp-row">
                            <input type="text" name="otp" id="otp" placeholder="Nhập mã OTP" required maxlength="6" />
                            <button type="button" name="otp" class="btn" id="sendOtpButton">Gửi OTP</button>
                        </div>
                    </c:if>

                    <!-- Address (Optional) -->
                    <div class="form-group">
                        <label for="address"><i class="zmdi zmdi-home"></i></label>
                        <input type="text" name="address" id="address" placeholder="Địa chỉ (Không bắt buộc)" maxlength="255"/>
                    </div>

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

    // Xử lý sự kiện Gửi OTP
    document.getElementById("sendOtpButton").addEventListener("click", function () {
        const email = document.getElementById("email").value;
        if (!email) {
            Swal.fire({
                icon: 'error',
                title: 'Lỗi!',
                text: 'Vui lòng nhập email để gửi OTP.',
                confirmButtonText: 'OK'
            });
            return;
        }

        fetch(`${pageContext.request.contextPath}/api/otp/send`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ email }) // Gửi email của người dùng
        })
            .then(response => {
                if (response.ok) {
                    return response.text();
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Lỗi!',
                        text: 'Không thể gửi OTP. Vui lòng thử lại.',
                        confirmButtonText: 'OK'
                    });
                    return;
                }
            })
            .then(data => {
                Swal.fire({
                    icon: 'success',
                    title: 'Thành công!',
                    text: data,
                    confirmButtonText: 'OK'
                });
                // Kích hoạt trường nhập OTP và vô hiệu hóa nút Đăng ký
                document.getElementById("otp").disabled = false;
                document.getElementById("signup").disabled = true;
            })
            .catch(error => {
                console.error("Lỗi khi gửi OTP:", error);
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi!',
                    text: 'Có lỗi xảy ra khi gửi OTP. Vui lòng thử lại.',
                    confirmButtonText: 'OK'
                });
            });
    });

    // Xử lý sự kiện Xác minh OTP
    document.getElementById("otp").addEventListener("blur", function () {
        const email = document.getElementById("email").value;
        const otp = document.getElementById("otp").value;

        if (!otp) {
            Swal.fire({
                icon: 'error',
                title: 'Lỗi!',
                text: 'Vui lòng nhập mã OTP.',
                confirmButtonText: 'OK'
            });
            return;
        }

        fetch(`${pageContext.request.contextPath}/api/otp/verify`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ email, otp }) // Gửi email và mã OTP để xác minh
        })
            .then(response => {
                if (response.ok) {
                    return response.text();
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Lỗi!',
                        text: 'Xác minh OTP thất bại.',
                        confirmButtonText: 'OK'
                    });
                }
            })
            .then(data => {
                if (data === "success") {
                    Swal.fire({
                        icon: 'success',
                        title: 'Thành công!',
                        text: 'OTP hợp lệ! Bạn có thể tiếp tục.',
                        confirmButtonText: 'OK'
                    });
                    // Ẩn trường email
                    document.getElementById("email").style.display = "none";
                    document.getElementById("otp").style.display = "none";
                    document.getElementById("sendOtpButton").style.display = "none";

                    // Kích hoạt nút Đăng ký
                    document.getElementById("signup").disabled = false;
                    // Vô hiệu hóa trường OTP và nút gửi OTP
                    document.getElementById("otp").disabled = true;
                    document.getElementById("sendOtpButton").disabled = true;
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Lỗi!',
                        text: 'OTP không hợp lệ! Vui lòng kiểm tra lại.',
                        confirmButtonText: 'OK'
                    });
                }
            })
            .catch(error => {
                console.error("Lỗi khi xác minh OTP:", error);
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi!',
                    text: 'Có lỗi xảy ra khi xác minh OTP. Vui lòng thử lại.',
                    confirmButtonText: 'OK'
                });
            });
    });

    // Xử lý sự kiện kiểm tra password và repassword
    document.getElementById("rePassword ").addEventListener("blur", function () {
        const password = document.getElementById("pass").value;
        const repassword = document.getElementById("rePassword").value;

        if (!password || !repassword) {
            Swal.fire({
                icon: 'error',
                title: 'Lỗi!',
                text: 'Vui lòng nhập mật khẩu và nhập lại mật khẩu.',
                confirmButtonText: 'OK'
            });
            document.getElementById("signup").disabled = true;
            return;
        }

        if (password !== repassword) {
            Swal.fire({
                icon: 'error',
                title: 'Lỗi!',
                text: 'Mật khẩu không khớp. Vui lòng kiểm tra lại.',
                confirmButtonText: 'OK'
            });
            document.getElementById("signup").disabled = true;
        } else {
            document.getElementById("signup").disabled = false;
        }
    });

    // Ẩn nút Đăng ký ban đầu
    document.addEventListener("DOMContentLoaded", function () {
        const email = document.getElementById("email").value;
        if (!email) {
            document.getElementById("signup").disabled = true;
            return;
        }
        else {
            document.getElementById("signup").disabled = false;
            return;
        }
    });
</script>