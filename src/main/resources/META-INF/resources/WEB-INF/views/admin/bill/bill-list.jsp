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
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Hóa đơn</li>
                </ol>
                <div class="mt-3">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <form action="/admin/bill/search" method="get" class="form-inline">
                                <input type="text" name="id" placeholder="Tìm theo mã hóa đơn" value="${id}" class="form-control"/>
                                <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                            </form>

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
                                    <th>Ngày tạo</th>
                                    <th>Thanh toán</th>
                                    <th>Trạng thái</th>
                                    <th>Xử lý</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="bill" items="${bills}">
                                    <tr>
                                        <th>${bill.id}</th>
                                        <td>${bill.name}</td>
                                        <td>${bill.address}</td>
                                        <td>${bill.date}</td>
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
                                            <a href="/admin/bill/${bill.id}"
                                               class="btn btn-success">Chi tiết </a>
                                            <a href="/admin/bill/update/${bill.id}"
                                               class="btn btn-warning mx-2">Cập nhật</a>
                                            <a href="/admin/bill/delete/${bill.id}"
                                               class="btn btn-danger">Xóa</a>
                                        </td>
                                    </tr>

                                </c:forEach>

                                </tbody>
                            </table>
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="/admin/bills?page=${currentPage-1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <c:forEach begin="1" end="${pageNo}" var="i">
                                        <c:choose>
                                            <c:when test="${currentPage == i}">
                                                <li class="page-item active">
                                                    <a class="page-link" href="/admin/bills?page=${i}">${i}</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item">
                                                    <a class="page-link" href="/admin/bills?page=${i}">${i}</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <li class="page-item ${currentPage == pageNo ? 'disabled' : ''}">
                                        <a class="page-link" href="/admin/bills?page=${currentPage + 1}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                            <span class="sr-only">Next</span>
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