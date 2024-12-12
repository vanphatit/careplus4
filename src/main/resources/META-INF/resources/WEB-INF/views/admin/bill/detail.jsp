<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

<body class="sb-nav-fixed">
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Hóa đơn</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/bills">Hóa đơn</a></li>
                    <li class="breadcrumb-item active">Chi tiết</li>
                </ol>
                <div class="container mt-5">
                    <div class="row">
                        <div class="col-12 mx-auto ">
                            <div class="d-flex justify-content-between align-items-center">
                                <h3>Hóa đơn chi tiết với mã: ${bill.id}</h3>
                                <form method="POST" action="/admin/bill/update" class="row">
                                    <!-- ID -->
                                    <div class="mb-3 col-12" hidden>
                                        <label class="form-label">Id:</label>
                                        <input type="text" class="form-control" name="id" value="${bill.id}"/>
                                    </div>

                                    <!-- Status -->
                                    <div class="mb-3 col-12" hidden>
                                        <label class="form-label">Trạng thái:</label>
                                        <input type="text" class="form-control" name="status" value="SHIPPING"/>
                                    </div>
                                    <!-- Submit Button -->
                                    <div class="col-12">
                                        <c:if test="${bill.status == 'AWAIT'}">
                                        <button type="submit" class="btn btn-secondary btn-send-to-shipping" id="btn-auto-submit">Chuyển sang ĐVVC</button>
                                        </c:if>

                                        <c:if test="${bill.status == 'SHIPPED'}">
                                            <div class="alert alert-info" role="alert">
                                                Hóa đơn này đã giao thành công.
                                            </div>
                                        </c:if>

                                        <!-- Khi trạng thái là SHIPPING -->
                                        <c:if test="${bill.status == 'SHIPPING'}">
                                        <div class="alert alert-warning" role="alert">
                                            Hóa đơn này đã được chuyển sang đơn vị vận chuyển.
                                        </div>
                                        </c:if>

                                        <c:if test="${bill.status == 'CANCELED'}">
                                            <div class="alert alert-danger" role="alert">
                                                Hóa đơn không thành công.
                                            </div>
                                        </c:if>

                                        <c:if test="${bill.status == 'RETURNED'}">
                                            <div class="alert alert-danger" role="alert">
                                                Hóa đơn không thành công.
                                            </div>
                                        </c:if>
                                    </div>
                                </form>
                            </div>
                            <hr />
                            <div class="card-header">
                                Thông tin hóa đơn
                            </div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item" id="bill-id">Mã: <strong>${bill.id}</strong></li>
                                <li class="list-group-item" id="receiver-name">Người nhận: <strong>${bill.name}</strong></li>
                                <li class="list-group-item" id="user-phone">Số điện thoại: <strong>${bill.user.phoneNumber}</strong></li>
                                <li class="list-group-item" id="address">Địa chỉ: <strong>${bill.address}</strong></li>
                                <li class="list-group-item" id="total-amount">Tổng tiền: <strong>${bill.totalAmount}</strong></li>
                                <li class="list-group-item">Ngày tạo: ${bill.date}</li>
                                <li class="list-group-item">Thanh toán: ${bill.method}</li>
                                <li class="list-group-item">Mã sự kiện(Nếu có): ${bill.event.id}</li>
                                <li class="list-group-item" id="status">Trạng thái đơn hàng:
                                    <c:choose>
                                        <c:when test="${bill.status == 'AWAIT'}">Đang chờ lấy hàng</c:when>
                                        <c:when test="${bill.status == 'SHIPPED'}">Đã giao hàng</c:when>
                                        <c:when test="${bill.status == 'SHIPPING'}">Đang vận chuyển</c:when>
                                        <c:when test="${bill.status == 'CANCELED'}">Đã hủy</c:when>
                                        <c:when test="${bill.status == 'RETURNED'}">Hoàn đơn</c:when>
                                        <c:otherwise>Trạng thái không xác định</c:otherwise>
                                    </c:choose>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <div class="container-fluid py-1">
        <div class="container py-1">
            <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
                <!-- Nút ẩn/hiện -->
                <button type="button" id="toggleDetailsBtn" class="btn btn-outline-danger">Ẩn chi tiết hóa đơn</button>
                <!-- -->

                <table class="table" id="billDetails">
                    <!-- Header của bảng -->
                    <thead>
                    <tr>
                        <th scope="col" class="text-primary fw-bold">Sản phẩm</th>
                        <th scope="col" class="text-primary fw-bold">Tên</th>
                        <th scope="col" class="text-primary fw-bold">Giá cả</th>
                        <th scope="col" class="text-primary fw-bold">Số lượng</th>
                        <th scope="col" class="text-primary fw-bold">Thành tiền</th>
                    </tr>
                    </thead>

                    <tbody>
                    <!-- Thông tin mã hóa đơn -->
                    <tr>
                        <td colspan="2">Mã hóa đơn: ${bill.id}</td>
                        <td colspan="1">
                            <fmt:formatNumber type="number" value="${bill.totalAmount}" /> đ
                        </td>
                    </tr>

                    <!-- Lặp qua danh sách chi tiết hóa đơn -->
                    <c:forEach var="billDetail" items="${bill.bilDetails}">
                        <tr>
                            <!-- Hình ảnh sản phẩm -->
                            <th scope="row">
                                <div class="d-flex align-items-center">
                                    <img
                                            src="${pageContext.request.contextPath}/images/image?fileName=${billDetail.medicineCopy.image}"
                                            class="img-fluid"
                                            style="width: 60px; height: 60px;"
                                            alt="${billDetail.medicineCopy.image}"
                                    >
                                </div>
                            </th>

                            <!-- Tên sản phẩm -->
                            <td>
                                <p class="mb-0 mt-4">
                                    <a href="/user/medicine/${billDetail.medicine.id}" target="_blank">
                                            ${billDetail.medicineCopy.name}
                                    </a>
                                </p>
                            </td>

                            <!-- Giá của sản phẩm -->
                            <td>
                                <p class="mb-0 mt-4">
                                    <fmt:formatNumber type="number" value="${billDetail.unitCost}" /> đ
                                </p>
                            </td>

                            <!-- Số lượng của sản phẩm -->
                            <td>
                                <div class="mt-4">
                                    <span class="text-center">
                                            ${billDetail.quantity}
                                    </span>
                                </div>
                            </td>

                            <!-- Thành tiền của sản phẩm -->
                            <td>
                                <p class="mb-0 mt-4" data-cart-detail-id="${cartDetail.id}">
                                    <fmt:formatNumber
                                            type="number"
                                            value="${billDetail.unitCost * billDetail.quantity}"/> đ
                                </p>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div> <!-- Kết thúc table-responsive -->
        </div> <!-- Kết thúc container -->
    </div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha384-KyZXEJ2Q7nPvu6bU3pKpP8E4e28do2tW3b0Zn8J6gxGnD01p3DghvGqkkmXlPMd0" crossorigin="anonymous"></script>
<script>
    $(document).ready(function() {
        $('.btn-send-to-shipping').on('click', function(e) {
            e.preventDefault();
            // Lấy thông tin hóa đơn
            const billId = $('#bill-id strong').text().trim();
            const receiverName = $('#receiver-name strong').text().trim();
            const address = $('#address strong').text().trim();
            const totalAmount = $('#total-amount strong').text().trim();
            const userPhone = $('#user-phone strong').text().trim();

            let province = address.split(',').pop().trim();

            $.ajax({
                url: `http://localhost:8080/v1/api/packages/add_shipping`, // Gọi đến URL API
                method: 'POST',
                contentType: 'application/x-www-form-urlencoded',
                data: {
                    idBill: billId,
                    receiverName: receiverName,
                    userPhone: userPhone,
                    address: address,
                    province: province,
                    totalAmount: totalAmount
                },
                success: function(response) {
                    Swal.fire({
                        title: 'Thông báo!',
                        text: 'Đơn hàng đã được giao cho đơn vị vận chuyển.',
                        icon: 'success',
                        confirmButtonText: 'OK'
                    }).then(function(result) {
                        if (result.isConfirmed) {
                            // Gửi lại form để cập nhật trạng thái mà không reload lại trang
                            $('form').submit();
                        }
                    });
                    // Lấy trạng thái mới của hóa đơn từ API
                    $.ajax({
                        url: `http://localhost:8080/v1/api/packages/checkStatus?idBill=${id}`, // Gọi API để lấy trạng thái mới nhất
                        method: 'GET',
                        success: function(statusResponse) {
                            // Cập nhật trạng thái đơn hàng
                            $('#status').text('Trạng thái đơn hàng: ' + statusResponse.data);

                            // Cập nhật trạng thái trực tiếp trên giao diện
                            $('#status').text('Trạng thái đơn hàng: ' + statusResponse.data);

                        },
                        error: function(xhr, status, error) {
                            console.error('Lỗi khi lấy trạng thái mới:', error);
                        }
                    });
                },
                error: function(xhr, status, error) {
                    console.error('Lỗi khi gửi đơn vị vận chuyển:', error);
                }
            });
        });
    });
</script>

<script>
    $(document).ready(function() {
        $('#toggleDetailsBtn').on('click', function() {
            var details = $('#billDetails');
            if (details.is(':visible')) {
                details.hide();
                $(this).text('Hiện chi tiết hóa đơn');
            } else {
                details.show();
                $(this).text('Ẩn chi tiết hóa đơn');
            }
        });
    });
</script>

</body>

</html>