<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<body class="sb-nav-fixed">
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Cập nhật hóa đơn</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/vendor">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/vendor/bills">Hóa đơn</a></li>
                    <li class="breadcrumb-item active">Cập nhật</li>
                </ol>
                <div class="container mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <h3>Cập nhật trạng thái đơn hàng</h3>
                            <hr />
                            <form method="POST" action="/vendor/bill/update" class="row">
                                <!-- ID -->
                                <div class="mb-3 col-12" >
                                    <label class="form-label">Id:</label>
                                    <input type="text" class="form-control" name="id" value="${currentBill.id}" readonly/>
                                </div>

                                <!-- Status -->
                                <div class="mb-3 col-12">
                                    <label class="form-label">Trạng thái:</label>
                                    <select class="form-control" name="status">
                                        <option value="PENDING" ${currentBill.status == 'AWAIT' ? 'selected' : ''}>Đang chờ lấy hàng</option>
                                        <option value="SHIPPING" ${currentBill.status == 'SHIPPING' ? 'selected' : ''}>Đang vận chuyển</option>
                                        <option value="SHIPPED" ${currentBill.status == 'SHIPPED' ? 'selected' : ''}>Đã giao hàng</option>
                                        <option value="CANCELED" ${currentBill.status == 'CANCELED' ? 'selected' : ''}>Đã hủy</option>
                                        <option value="RETURNED" ${currentBill.status == 'RETURNED' ? 'selected' : ''}>Hoàn đơn</option>
                                    </select>
                                </div>

                                <!-- Submit Button -->
                                <div class="col-12">
                                    <button type="submit" class="btn btn-warning">Cập nhật</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>

</html>
