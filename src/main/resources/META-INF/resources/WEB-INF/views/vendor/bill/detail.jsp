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
                <h1 class="mt-4">Hóa đơn</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/vendor">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/vendor/bills">Hóa đơn</a></li>
                    <li class="breadcrumb-item active">Chi tiết</li>
                </ol>
                <div class="container mt-5">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <div class="d-flex justify-content-between align-items-center">
                                <h3>Hóa đơn chi tiết với mã: ${bill.id}</h3>
                                <form method="POST" action="/vendor/bill/update" class="row">
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
                                    <!-- Submit Button -->
                                    <div class="col-12">
                                        <c:if test="${bill.status != 'SHIPPING'}">
                                            <button type="submit" class="btn btn-secondary btn-send-to-shipping" id="btn-auto-submit">Chuyển sang ĐVVC</button>
                                        </c:if>

                                        <!-- Khi trạng thái là SHIPPING -->
                                        <c:if test="${bill.status == 'SHIPPING'}">
                                            <div class="alert alert-info" role="alert">
                                                Hóa đơn này đã được chuyển sang đơn vị vận chuyển.
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
                                <li class="list-group-item" id="status">Trạng thái đơn hàng: ${bill.status}</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </main>
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

            // Hiển thị thông tin trong console
            console.log('Mã hóa đơn (billId):', billId);
            console.log('Người nhận (receiverName):', receiverName);
            console.log('Số điện thoại (userPhone):', userPhone);
            console.log('Địa chỉ (address):', address);
            console.log('Tỉnh/Thành phố (province):', province);
            console.log('Tổng tiền (totalAmount):', totalAmount);

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

                            console.log(statusResponse.data);
                        },
                        error: function(xhr, status, error) {
                            console.log(statusResponse.data)
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
</body>

</html>