<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<body class="sb-nav-fixed">
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Quản lý hóa đơn</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin/">Dashboard</a></li>
                    <li class="breadcrumb-item active">Hóa đơn</li>
                </ol>
                <div class="mt-3">
                    <div class="row">
                        <div class="col-12 mx-auto">

                            <div class="container mt-4">
                                <!-- Form tìm kiếm theo mã hóa đơn -->
                                <div class="row mb-3">
                                    <div class="col-md-6 mx-auto">
                                        <form action="/admin/bill/search" method="get" class="d-flex align-items-center">
                                            <input
                                                    type="text"
                                                    name="id"
                                                    placeholder="Tìm theo mã hóa đơn"
                                                    value="${id}"
                                                    class="form-control me-2"
                                            />
                                            <button
                                                    type="submit"
                                                    class="btn btn-outline-dark"
                                                    style="height: calc(2.5rem + 3px); margin-left: 5px"
                                            >
                                                Tìm kiếm
                                            </button>
                                        </form>
                                    </div>
                                </div>

                                <!-- Form lọc trạng thái đơn hàng -->
                                <div class="row">
                                    <div class="col-md-8 mx-auto">
                                        <form action="/admin/bills" method="get" id="searchForm" class="p-4 border rounded">
                                            <div id="orderStatusFilter">
                                                <div class="d-flex justify-content-between align-items-center mb-4">
                                                    <h5 class="mb-3 fw-bold fs-4">Trạng thái đơn hàng</h5>
                                                    <button type="submit" class="btn btn-dark">Lọc đơn</button>
                                                </div>

                                                <div class="d-flex flex-wrap gap-1 justify-content-sm-between">
                                                    <div class="form-check">
                                                        <input
                                                                class="form-check-input"
                                                                type="radio"
                                                                name="status"
                                                                id="status-await"
                                                                value="AWAIT"
                                                        />
                                                        <label class="form-check-label" for="status-await">Chờ xử lý </label>
                                                    </div>
                                                    <div class="form-check">
                                                        <input
                                                                class="form-check-input"
                                                                type="radio"
                                                                name="status"
                                                                id="status-shipping"
                                                                value="SHIPPING"
                                                        />
                                                        <label class="form-check-label" for="status-shipping">Đang giao hàng </label>
                                                    </div>
                                                    <div class="form-check">
                                                        <input
                                                                class="form-check-input"
                                                                type="radio"
                                                                name="status"
                                                                id="status-shipped"
                                                                value="SHIPPED"
                                                        />
                                                        <label class="form-check-label" for="status-shipped">Đã giao hàng </label>
                                                    </div>
                                                    <div class="form-check">
                                                        <input
                                                                class="form-check-input"
                                                                type="radio"
                                                                name="status"
                                                                id="status-canceled"
                                                                value="CANCELED"
                                                        />
                                                        <label class="form-check-label" for="status-canceled">Đã hủy </label>
                                                    </div>
                                                    <div class="form-check">
                                                        <input
                                                                class="form-check-input"
                                                                type="radio"
                                                                name="status"
                                                                id="status-returned"
                                                                value="RETURNED"
                                                        />
                                                        <label class="form-check-label" for="status-returned">Hoàn đơn</label>
                                                    </div>
                                                </div>

                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-between mt-4">
                                <h3>Danh sách hóa đơn</h3>
                            </div>

                            <hr />
                            <table class=" table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>Mã hóa đơn</th>
                                    <th>Người nhận</th>
                                    <th>Địa chỉ</th>
                                    <th>Thời gian tạo</th>
                                    <th>Thời gian cập nhật</th>
                                    <th>Thanh toán</th>
                                    <th>Trạng thái</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="bill" items="${bills}">
                                    <tr>
                                        <th>${bill.id}</th>
                                        <td>${bill.name}</td>
                                        <td>${bill.address}</td>
                                        <td>${bill.date}</td>
                                        <td>${bill.updateDate}</td>
                                        <td>${bill.method}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${bill.status == 'SHIPPED'}">
                                                    <span class="badge bg-success">Đã giao</span>
                                                </c:when>
                                                <c:when test="${bill.status == 'SHIPPING'}">
                                                    <span class="badge bg-info">Đang giao</span>
                                                </c:when>
                                                <c:when test="${bill.status == 'CANCELED'}">
                                                    <span class="badge bg-danger">Đã hủy</span>
                                                </c:when>
                                                <c:when test="${bill.status == 'RETURNED'}">
                                                    <span class="badge bg-danger">Hoàn đơn</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-warning">Chờ</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="/admin/bill/${bill.id}" class="btn btn-success">
                                                <i class="fas fa-search"><strong>Chi tiết</strong></i>
                                            </a>
                                        </td>
                                    </tr>

                                </c:forEach>

                                </tbody>
                            </table>
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">
                                    <!-- Nút Previous -->
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link"
                                           href="/admin/bills?page=${currentPage - 1}<c:if test='${param.status != null}'>&status=${param.status}</c:if>"
                                           aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>

                                    <!-- Liệt kê các trang -->
                                    <c:forEach begin="1" end="${pageNo}" var="i">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link"
                                               href="/admin/bills?page=${i}<c:if test='${param.status != null}'>&status=${param.status}</c:if>">
                                                    ${i}
                                            </a>
                                        </li>
                                    </c:forEach>

                                    <!-- Nút Next -->
                                    <li class="page-item ${currentPage == pageNo ? 'disabled' : ''}">
                                        <a class="page-link"
                                           href="/admin/bills?page=${currentPage + 1}<c:if test='${param.status != null}'>&status=${param.status}</c:if>"
                                           aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
                <form method="POST" action="/admin/bill/updateStatus" class="row" hidden>
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
                        <button type="submit" class="btn btn-secondary btn-send-to-shipping" id="btn-auto-submit">Submit</button>
                    </div>
                </form>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha384-KyZXEJ2Q7nPvu6bU3pKpP8E4e28do2tW3b0Zn8J6gxGnD01p3DghvGqkkmXlPMd0" crossorigin="anonymous"></script>
<script>
    $(document).ready(function () {
        function updateBillStatus() {
            $.ajax({
                url: 'http://localhost:8080/v1/api/packages/getIdBillAndStatus',
                method: 'GET',
                dataType: 'json',
                success: function (response) {
                    if (response.status) {
                        response.data.forEach(function (bill) {
                            const row = $('tr').filter(function () {
                                return $(this).find('th').text().trim() === bill.idBill;
                            });

                            if (row.length > 0) {
                                // Lấy trạng thái hiện tại của hóa đơn từ giao diện
                                const currentStatusText = row.find('td:nth-child(6) span').text().trim();

                                // Xác định trạng thái mới từ API
                                let newStatusText = '';
                                let statusBadge = '';
                                if (bill.status === 'SHIPPED') {
                                    statusBadge = '<span class="badge bg-success">Đã giao</span>';
                                    newStatusText = 'Đã giao';
                                } else if (bill.status === 'SHIPPING') {
                                    statusBadge = '<span class="badge bg-info">Đang giao</span>';
                                    newStatusText = 'Đang giao';
                                } else if (bill.status === 'CANCELED') {
                                    statusBadge = '<span class="badge bg-danger">Đã hủy</span>';
                                    newStatusText = 'Đã hủy';
                                } else if (bill.status === 'RETURNED') {
                                    statusBadge = '<span class="badge bg-danger">Hoàn đơn</span>';
                                    newStatusText = 'Hoàn đơn';
                                } else {
                                    statusBadge = '<span class="badge bg-warning">Chờ</span>';
                                    newStatusText = 'Chờ';
                                }

                                // Nếu trạng thái trên giao diện khác với trạng thái từ API thì cập nhật
                                if (currentStatusText !== newStatusText) {
                                    row.find('td:nth-child(6)').html(statusBadge); // Cập nhật cột trạng thái

                                    // **Tự động nộp form nếu trạng thái thay đổi**
                                    autoSubmitForm(bill.idBill, bill.status);
                                }
                            }
                        });
                    } else {
                        console.warn('Không thể lấy dữ liệu từ API:', response.message);
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Không thể tải trạng thái hóa đơn:', error);
                }
            });
        }

        // Hàm tự động điền thông tin và nộp form
        function autoSubmitForm(id, status) {
            const form = $('form'); // Tìm form mặc định
            const inputId = form.find('input[name="id"]');
            const inputStatus = form.find('input[name="status"]');

            // Gán giá trị cho các input trong form
            inputId.val(id);
            inputStatus.val(status);

            form.submit();
        }
        updateBillStatus();
    });
</script>

</body>

</html>