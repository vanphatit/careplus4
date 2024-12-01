<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>
<div class="container mt-5" style="padding-bottom: 20px !important">
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <div class="card">
                <div class="card-header bg-primary text-white" style="background-color: #0077b6 !important">
                    <h5 class="mb-0">Đổi mật khẩu</h5>
                </div>

                <div class="card-body">
                    <form id="updatePasswordForm" action="${pageContext.request.contextPath}/user/changePassword" method="post">
                        <!-- Mật khẩu mới -->
                        <div class="mb-3">
                            <label for="password" class="form-label">Mật khẩu mới</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <!-- Nhập lại mật khẩu -->
                        <div class="mb-3">
                            <label for="repassword" class="form-label">Nhập lại mật khẩu</label>
                            <input type="password" class="form-control" id="repassword" name="repassword" required>
                        </div>
                        <!-- Nhập OTP -->
                        <div class="mb-3">
                            <label for="otp" class="form-label">Nhập mã OTP</label>
                            <input type="text" class="form-control" id="otp" name="otp" required disabled>
                            <button type="button" class="btn btn-outline-primary mt-2" id="sendOtpButton">Gửi OTP</button>
                        </div>
                        <!-- Nút lưu thay đổi -->
                        <div class="text-end">
                            <button type="submit" class="btn btn-primary" id="updatePasswordButton" disabled>Đổi mật khẩu</button>
                            <a href="${pageContext.request.contextPath}/user/userInfo" class="btn btn-secondary">Hủy</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Lấy email từ đối tượng user.email (giả định user được thêm vào trong scope JSP)
    const email = "${user.email}";

    // Xử lý sự kiện Gửi OTP
    document.getElementById("sendOtpButton").addEventListener("click", function () {
        if (!email) {
            alert("Không tìm thấy email của bạn. Vui lòng kiểm tra lại.");
            return;
        }
        fetch("${pageContext.request.contextPath}/api/otp/send", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ email }) // Gửi email của người dùng
        })
            .then(response => {
                if (response.ok) {
                    return response.text();
                } else {
                    throw new Error("Không thể gửi OTP. Vui lòng thử lại.");
                }
            })
            .then(data => {
                alert(data); // Hiển thị thông báo từ backend
                // Enable OTP field
                document.getElementById("otp").disabled = false;
            })
            .catch(error => {
                console.error("Lỗi khi gửi OTP:", error);
                alert("Có lỗi xảy ra khi gửi OTP. Vui lòng thử lại.");
            });
    });

    // Xử lý sự kiện Xác minh OTP
    document.getElementById("otp").addEventListener("blur", function () {
        const otp = document.getElementById("otp").value;
        if (!otp) {
            alert("Vui lòng nhập mã OTP.");
            return;
        }
        fetch("${pageContext.request.contextPath}/api/otp/verify", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ email, otp }) // Gửi email và mã OTP để xác minh
        })
            .then(response => {
                if (response.ok) {
                    return response.text();
                } else {
                    throw new Error("Xác minh OTP thất bại.");
                }
            })
            .then(data => {
                if (data === "success") {
                    alert("OTP hợp lệ! Bạn có thể đổi mật khẩu.");
                    document.getElementById("updatePasswordButton").disabled = false;
                } else {
                    alert("OTP không hợp lệ! Vui lòng kiểm tra lại.");
                }
            })
            .catch(error => {
                console.error("Lỗi khi xác minh OTP:", error);
                alert("Có lỗi xảy ra khi xác minh OTP. Vui lòng thử lại.");
            });
    });

    // Xử lý sự kiện kiểm tra password và repassword
    document.getElementById("repassword").addEventListener("blur", function () {
        const password = document.getElementById("password").value;
        const repassword = document.getElementById("repassword").value;

        if (!password || !repassword) {
            alert("Vui lòng nhập mật khẩu và nhập lại mật khẩu.");
            document.getElementById("updatePasswordButton").disabled = true;
            return;
        }

        if (password !== repassword) {
            alert("Mật khẩu và nhập lại mật khẩu không khớp. Vui lòng kiểm tra lại.");
            document.getElementById("updatePasswordButton").disabled = true;
        }
    });
</script>
