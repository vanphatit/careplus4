<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<body>
<div class="container">

    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="row text-center">
            <div class="col-12 mb-3">
                <h1 style="color: #dc3545; font-size: 80px">THANK YOU!</h1> <br/>
            </div>
            <div>
                <img src="${pageContext.request.contextPath}/images/image?fileName=carts.png"/>
            </div>
            <div class="col-12 mb-3">
                <p style="font-size: 25px">
                    Quý khách đã mua sắm tại <strong style="color: #0077b6">CAREPLUS4</strong>.
                </p>
            </div>
            <div class="col-12 mb-3" style="color: #dc3545; font-weight: 500">
                <p>
                    Chúng tôi rất trân trọng sự ủng hộ của quý khách và cam kết mang lại những trải nghiệm mua sắm tốt nhất.
                </p>
            </div>
            <div class="col-12">
                <p>
                    Hẹn gặp lại quý khách trong lần mua sắm tiếp theo!
                </p>
                <a href="/user/order-history">
                    Xem chi tiết các đơn hàng đã mua!
                </a>
            </div>
        </div>
    </div>
    <!-- Bootstrap JS (optional for advanced interactivity) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</div>
</body>
</html>

