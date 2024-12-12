<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:url value="/" var="URL" />
<!DOCTYPE html>
<html lang="en">
<body>
    <div class="site"><!-- mobile site__header -->
        <div class="site__body">
            <div class="page-header">
                <div class="page-header__container container">
                    <div class="page-header__breadcrumb">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="<c:url value='/home' />">Trang chủ</a>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">Lịch sử mua sắm</li>
                            </ol>
                        </nav>
                    </div>
                    <div class="page-header__title">
                        <h1>Lịch sử mua sắm</h1>
                    </div>
                </div>
            </div>
            <div class="container-fluid py-1">
                <div class="container py-1">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                            <tr>
                                <th scope="col">Sản phẩm</th>
                                <th scope="col">Tên</th>
                                <th scope="col">Giá cả</th>
                                <th scope="col">Số lượng</th>
                                <th scope="col">Thành tiền</th>
                                <th scope="col">Trạng thái</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${empty bills}">
                                <tr>
                                    <td colspan="6">
                                        Không có đơn hàng nào được tạo
                                    </td>
                                </tr>
                            </c:if>
                            <c:forEach var="bill" items="${bills}">
                                <tr>
                                    <td colspan="2">Mã hóa đơn: ${bill.id}</td>
                                    <td colspan="1">
                                        <fmt:formatNumber type="number" value=" ${bill.totalAmount}" /> đ
                                    </td>
                                    <td colspan="2"></td>
                                    <td colspan="1">
                                        <c:choose>
                                            <c:when test="${bill.status == 'SHIPPED'}">
                                                <span class="badge bg-success">Đã giao hàng</span>
                                                <br />
                                                <a href="/user/review/${bill.id}" class="btn btn-sm btn-primary mt-2">Đánh giá</a>
                                            </c:when>
                                            <c:when test="${bill.status == 'SHIPPING'}">
                                                <span class="badge bg-primary">Đang giao hàng</span>
                                            </c:when>
                                            <c:when test="${bill.status == 'CANCELED'}">
                                                <span class="badge bg-danger">Đã bị hủy</span>
                                            </c:when>
                                            <c:when test="${bill.status == 'RETURNED'}">
                                                <span class="badge bg-danger">Hoàn đơn</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning">Chờ lấy hàng</span>
                                                <br/>
                                                <form method="POST" action="/user/updateStatus" class="row">
                                                    <!-- ID -->
                                                    <div class="mb-3 col-12" hidden>
                                                        <input type="text" class="form-control" name="id" value="${bill.id}"/>
                                                    </div>

                                                    <!-- Status -->
                                                    <div class="mb-3 col-12" hidden>
                                                        <input type="text" class="form-control" name="status" value="CANCELED"/>
                                                    </div>

                                                    <!-- Submit Button -->
                                                    <div class="col-12">
                                                        <button type="submit" class="tn btn-sm btn-danger mt-2">Hủy đơn</button>
                                                    </div>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <c:forEach var="billDetail" items="${bill.bilDetails}">
                                    <tr>
                                        <th scope="row">
                                            <div class="d-flex align-items-center">
                                                <img src="${pageContext.request.contextPath}/images/image?fileName=${billDetail.medicineCopy.image}"
                                                     class="img-fluid me-5 rounded-circle"
                                                     style="width: 80px; height: 80px;" alt="">
                                            </div>
                                        </th>
                                        <td>
                                            <p class="mb-0 mt-4">
                                                <a href="/user/medicine/${billDetail.medicine.id}" target="_blank">
                                                        ${billDetail.medicineCopy.name}
                                                </a>
                                            </p>
                                        </td>
                                        <td>
                                            <p class="mb-0 mt-4">
                                                <fmt:formatNumber type="number" value="${billDetail.unitCost}" /> đ
                                            </p>
                                        </td>
                                        <td>
                                            <div class="input-group quantity mt-4" style="width: 100px;">
                                                <input type="text"
                                                       class="form-control form-control-sm text-center bbill-0"
                                                       value="${billDetail.quantity}"
                                                       disabled
                                                >
                                            </div>
                                        </td>
                                        <td>
                                            <p class="mb-0 mt-4" data-cart-detail-id="${cartDetail.id}">
                                                <fmt:formatNumber type="number"
                                                                  value="${billDetail.unitCost * billDetail.quantity}" /> đ
                                            </p>
                                        </td>
                                        <td></td>
                                    </tr>
                                </c:forEach>
                            </c:forEach>
                            </tbody>
                        </table>
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="/user/order-history?page=${currentPage-1}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <c:forEach begin="1" end="${pageNo}" var="i">
                                    <c:choose>
                                        <c:when test="${currentPage == i}">
                                            <li class="page-item active">
                                                <a class="page-link" href="/user/order-history?page=${i}">${i}</a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item">
                                                <a class="page-link" href="/user/order-history?page=${i}">${i}</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <li class="page-item ${currentPage == pageNo ? 'disabled' : ''}">
                                    <a class="page-link" href="/user/order-history?page=${currentPage + 1}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                        <span class="sr-only">Next</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div><!-- site__body / end -->
    </div><!-- site / end -->
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
