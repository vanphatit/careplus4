<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url value="/" var="URL"></c:url>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .chart-container {
            width: 1080px;
            height: 1080px;
            margin: 20px auto;
        }

        .card {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            height: 150px; /* Đảm bảo chiều cao cố định */
        }

        .card-body {
            display: flex;
            flex-direction: column;
            justify-content: center; /* Căn giữa theo chiều dọc */
            align-items: center; /* Căn giữa theo chiều ngang */
            text-align: center;
        }

        .card h5 {
            margin-bottom: 10px; /* Khoảng cách giữa tiêu đề và số */
            font-weight: bold;
            font-size: 1rem;
        }

        .card h3 {
            margin: 0;
            font-size: 2rem;
            font-weight: bold;
        }

        .card i {
            font-size: 2rem; /* Tăng kích thước icon */
            margin-bottom: 10px; /* Khoảng cách dưới icon */
        }

        .custom-select {
            width: 25%;
            margin: 0 auto; /* Căn giữa */
            font-size: 16px;
            border-radius: 8px; /* Bo góc */
            padding: 8px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Hiệu ứng đổ bóng */
            background-color: #f9f9f9; /* Màu nền nhạt */
            transition: all 0.3s ease-in-out;
        }

        .custom-select:hover {
            border-color: #007bff; /* Đổi màu viền khi hover */
            background-color: #ffffff; /* Màu nền khi hover */
        }

        .table {
            font-size: 0.9rem;
        }

        .table img {
            border: 1px solid #e6e6e6;
            padding: 4px;
            border-radius: 4px;
        }

        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
        }

        .table th, .table td {
            vertical-align: middle; /* Canh giữa nội dung trong ô */
        }

        .table .btn {
            font-size: 0.8rem;
            padding: 5px 10px;
        }

    </style>
</head>
<body>
<div class="container mt-4">
    <div class="row text-center mt-5 d-flex align-items-stretch">
        <!-- Tổng số người dùng -->
        <div class="col-md-3 mb-3">
            <div class="card text-dark bg-light border-primary shadow h-100">
                <div class="card-body">
                    <h5 class="card-title">
                        <i class="fas fa-users text-primary"></i> Tổng số người dùng
                    </h5>
                    <div class="d-flex justify-content-center align-items-center">
                        <div>
                        <p class="mb-1 text-secondary">Với quyền USER:</p>
                        <h4 class="text-warning">
                            <c:if test="${user.role != null && user.role.name != null && user.role.name == 'ADMIN'}">
                                <a href="/admin/users/filter?status=active&roles=USER" class="text-decoration-none text-dark">${totalUser}</a>
                            </c:if>
                            <c:if test="${user.role != null && user.role.name != null && user.role.name == 'VENDOR'}">
                                <strong>${totalUser}</strong>
                            </c:if>
                        </h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tổng hàng trong kho -->
        <div class="col-md-3 mb-3">
            <div class="card text-dark bg-light border-success shadow h-100">
                <div class="card-body">
                    <h5 class="card-title">
                        <i class="fas fa-cubes text-success"></i> Tổng hàng trong kho
                    </h5>
                    <div class="d-flex justify-content-center align-items-center">
                        <div>
                            <p class="mb-1 text-secondary">Với tổng số sản phẩm:</p>
                            <h4>
                                <a href="${URL}vendor/medicines" class="text-decoration-none text-dark">${totalStockQuantity}</a>
                            </h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Doanh thu hôm nay -->
        <div class="col-md-3 mb-3">
            <div class="card text-dark bg-light border-warning shadow h-100">
                <div class="card-body">
                    <h5 class="card-title">
                        <i class="fas fa-dollar-sign text-warning"></i> Doanh thu hôm nay
                    </h5>
                    <div class="d-flex justify-content-center align-items-center">
                        <div>
                            <p class="mb-1 text-secondary">Với tổng số tiền:</p>
                            <h4>
                                <c:if test="${user.role != null && user.role.name != null && user.role.name == 'ADMIN'}">
                                    <a href="${URL}admin/bill/today" class="text-decoration-none text-dark">
                                        <span id="revenueToday">${revenueToday}</span> VND
                                    </a>
                                </c:if>
                                <c:if test="${user.role != null && user.role.name != null && user.role.name == 'VENDOR'}">
                                    <a href="${URL}vendor/bill/today" class="text-decoration-none text-dark">
                                        <span id="revenueToday">${revenueToday}</span> VND
                                    </a>
                                </c:if>
                            </h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Trạng thái đơn hàng -->
        <div class="col-md-3 mb-3">
            <div class="card text-dark bg-light border-primary shadow h-100">
                <div class="card-body">
                    <h5 class="card-title">
                        <i class="fas fa-truck text-primary"></i> Trạng thái đơn hàng
                    </h5>
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <p class="mb-1 text-secondary">Đang chờ xử lý:</p>
                            <h4 class="text-danger">
                                <c:if test="${user.role != null && user.role.name != null && user.role.name == 'ADMIN'}">
                                    <a href="${URL}admin/bill/awaiting" class="text-decoration-none text-dark">
                                        <span id="totalStatusAwaiting">${totalStatusAwaiting}</span>
                                    </a>
                                </c:if>
                                <c:if test="${user.role != null && user.role.name != null && user.role.name == 'VENDOR'}">
                                    <a href="${URL}vendor/bill/awaiting" class="text-decoration-none text-dark">
                                        <span id="totalStatusAwaiting">${totalStatusAwaiting}</span>
                                    </a>
                                </c:if>
                            </h4>
                        </div>
                        <div>
                            <p class="mb-1 text-secondary">Đang giao hàng:</p>
                            <h4 class="text-warning">
                                <c:if test="${user.role != null && user.role.name != null && user.role.name == 'ADMIN'}">
                                    <a href="${URL}admin/bill/shipping" class="text-decoration-none text-dark">
                                        <span id="totalStatusShipping">${totalStatusShipping}</span>
                                    </a>
                                </c:if>
                                <c:if test="${user.role != null && user.role.name != null && user.role.name == 'VENDOR'}">
                                    <a href="${URL}vendor/bill/shipping" class="text-decoration-none text-dark">
                                        <span id="totalStatusShipping">${totalStatusShipping}</span>
                                    </a>
                                </c:if>
                            </h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- Combobox để chọn loại biểu đồ -->
    <div class="text-center my-4">
        <label for="chartType" class="form-label">Chọn loại biểu đồ:</label>
        <select id="chartType" class="custom-select" style="width: 25%">
            <option value="week">Doanh thu theo tuần</option>
            <option value="month">Doanh thu theo tháng</option>
            <option value="season">Doanh thu theo mùa</option>
        </select>
    </div>

    <!-- Biểu đồ -->
    <div class="chart-container">
        <canvas id="revenueChart"></canvas>
    </div>

    <div class="container mt-4">
        <h2 class="text-center text-primary mb-4">Top 3 sản phẩm bán chạy trong 7 ngày gần đây</h2>
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead class="table-primary text-center">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Hình ảnh</th>
                    <th scope="col">Tên sản phẩm</th>
                    <th scope="col">Giá</th>
                    <th scope="col">Đánh giá</th>
                    <th scope="col">Số lượng bán</th>
                    <th scope="col">Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="medicine" items="${top3BestSellerForLast7Days}" varStatus="status">
                    <tr>
                        <td class="text-center">${status.index + 1}</td>
                        <td class="text-center">
                            <img src="${pageContext.request.contextPath}/images/image?fileName=${medicine.image}"
                                 alt="${medicine.name}"
                                 style="max-height: 50px; max-width: 50px; object-fit: contain;">
                        </td>
                        <td>
                            <span>
                                <a href="${URL}vendor/medicine/${medicine.id}" class="text-decoration-none">${medicine.name}</a>
                            </span>
                        </td>
                        <td class="text-end">
                            <span class="price">${medicine.unitCost}</span> VND
                        </td>
                        <td class="text-center">${medicine.rating}</td>
                        <td class="text-center">${medicine.get("totalSales")}</td>
                        <td class="text-center">
                            <form action="${URL}vendor/medicine/${medicine.id}" method="get">
                                <button type="submit" class="btn btn-sm btn-primary">Xem chi tiết</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Bảng tiến độ giao hàng -->
    <div class="row mt-5">
        <div class="col-md-12">
            <div class="d-flex justify-content-left align-items-center mb-3">
                <h2 id="shipping-status-title" class="text-center">Tiến độ giao hàng của đơn vị vận chuyển:</h2>
                <form method="get" action="javascript:void(0);">
                    <select name="status"
                            id="status"
                            class="custom-select form-select"
                            style="width: 200px; margin-right: 10px; margin-left: 20px"
                            onchange="filterByStatus(this.value)"
                    >
                        <option value="" ${status eq '' ? 'selected' : ''}>Tất cả trạng thái</option>
                        <option value="AWAIT" ${status eq 'AWAIT' ? 'selected' : ''}>Đang chờ xử lý</option>
                        <option value="SHIPPING" ${status eq 'SHIPPING' ? 'selected' : ''}>Đang giao hàng</option>
                        <option value="SHIPPED" ${status eq 'SHIPPED' ? 'selected' : ''}>Đã hoàn thành</option>
                        <option value="CANCELED" ${status eq 'CANCELED' ? 'selected' : ''}>Đã hủy</option>
                    </select>

                    <input type="hidden" name="page" value="${currentPage}"/> <!-- Đảm bảo giữ lại trang hiện tại -->
                    <input type="hidden" name="size" value="${pageSize}"/> <!-- Giữ lại kích thước trang -->
                </form>
                <h5 class="text-muted text-center" style="font-style: italic; margin-left: 10px; margin-right: 10px">Có tổng cộng
                    <span id="totalShippingStatus" class="text-primary fw-bold">${totalShippingStatus}</span> đơn hàng
                </h5>
            </div>

            <table class="table table-bordered table-striped" id="transactionTable">
                <thead class="table-primary text-center">
                <tr>
                    <th>Mã Hóa Đơn</th>
                    <th>Số Điện Thoại</th>
                    <th>Tên Người Nhận</th>
                    <th>Tổng Tiền</th>
                    <th>Ngày Đặt</th>
                    <th>Ngày Giao</th>
                    <th>Trạng Thái</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="transaction" items="${transactionHistory}">
                    <tr>
                        <td>
                            <c:if test="${user.role != null && user.role.name != null && user.role.name == 'ADMIN'}">
                                <a href="${URL}admin/bill/${transaction.idBill}" class="text-decoration-none">
                                        ${transaction.idBill}
                                </a>
                            </c:if>
                            <c:if test="${user.role != null && user.role.name != null && user.role.name == 'VENDOR'}">
                                <a href="${URL}vendor/bill/${transaction.idBill}" class="text-decoration-none">
                                        ${transaction.idBill}
                                </a>
                            </c:if>
                        </td>
                        <td>${transaction.userPhone}</td>
                        <td>${transaction.receiverName}</td>
                        <td>
                            <span class="total-amount">${transaction.totalAmount}</span> VND
                        </td>
                        <td data-date="${transaction.date}">${transaction.date}</td>
                        <td data-date="${transaction.deliveryDate}">${transaction.deliveryDate}</td>
                        <td>
                            <c:choose>
                                <c:when test="${transaction.status eq 'AWAIT'}">
                                    <span class="badge bg-warning text-dark">Đang chờ xử lý</span>
                                </c:when>
                                <c:when test="${transaction.status eq 'SHIPPING'}">
                                    <span class="badge bg-primary">Đang giao hàng</span>
                                </c:when>
                                <c:when test="${transaction.status eq 'SHIPPED'}">
                                    <span class="badge bg-success">Đã hoàn thành</span>
                                </c:when>
                                <c:when test="${transaction.status eq 'CANCELED'}">
                                    <span class="badge bg-danger">Đã hủy</span>
                                </c:when>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <c:if test="${not empty pageNumbers}">
                <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <c:forEach var="page" items="${pageNumbers}">
                            <li class="page-item ${page eq currentPage ? 'active' : ''}">
                                <a class="page-link" href="javascript:void(0);" onclick="navigateToPage(${page})">
                                        ${page}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </nav>
            </c:if>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Link đến Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Tìm các phần tử hiển thị revenue
        const revenueTodayElem = document.querySelector('#revenueToday');
        const revenueForWeekElem = document.querySelector('#revenueForWeek');
        const priceElems = document.querySelectorAll('.price');
        const totalAmountElems = document.querySelectorAll('.total-amount');

        // Làm tròn doanh thu hôm nay
        if (revenueTodayElem) {
            const revenueTodayValue = parseFloat(revenueTodayElem.textContent);
            revenueTodayElem.textContent = Math.floor(revenueTodayValue);
        }

        // Làm tròn doanh thu tuần
        if (revenueForWeekElem) {
            const revenueForWeekValue = parseFloat(revenueForWeekElem.textContent);
            revenueForWeekElem.textContent = Math.floor(revenueForWeekValue);
        }

        // Làm tròn giá sản phẩm
        priceElems.forEach(priceElem => {
            const priceValue = parseFloat(priceElem.textContent.replace(/[^0-9.]/g, '')); // Xóa ký tự không phải số
            if (!isNaN(priceValue)) {
                priceElem.textContent = Math.floor(priceValue); // Làm tròn số
            }
        });

        // Làm tròn tổng tiền
        totalAmountElems.forEach(totalElem => {
            const totalValue = parseFloat(totalElem.textContent.replace(/[^0-9.]/g, '')); // Xóa ký tự không phải số
            if (!isNaN(totalValue)) {
                totalElem.textContent = Math.floor(totalValue); // Làm tròn số
            }
        });
    });
</script>

<script>
    let revenueChart;
    // Dữ liệu từ backend
    const dForWeek = ${revenueRecordForWeek};
    const dForMonth = ${revenueRecordForMonth};
    const dForSeason = ${revenueRecordForSeason};

    // Helper function để parse dữ liệu biểu đồ
    function parseRevenueData(records) {
        return {
            labels: records.map(record => {
                const parsedDate = new Date(record.date);
                parsedDate.setDate(parsedDate.getDate() + 1); // Để hiển thị ngày đúng
                return parsedDate.toLocaleDateString("Default", { day: '2-digit', month: '2-digit' });
            }),
            revenues: records.map(record => record.revenue || 0),
            profits: records.map(record => record.profit || 0)
        };
    }

    // Parse dữ liệu
    const weekData = parseRevenueData(dForWeek);
    const monthData = parseRevenueData(dForMonth);
    const seasonData = parseRevenueData(dForSeason);

    // Hàm khởi tạo biểu đồ (line chart)
    function createChart(chartData) {
        const ctx = document.getElementById('revenueChart').getContext('2d');
        return new Chart(ctx, {
            type: 'line', // Thay đổi từ 'bar' thành 'line'
            data: {
                labels: chartData.labels,
                datasets: [
                    {
                        label: 'Doanh thu',
                        data: chartData.revenues,
                        borderColor: 'rgba(54, 162, 235, 1)', // Màu đường
                        backgroundColor: 'rgba(54, 162, 235, 0.2)', // Màu nền mờ
                        borderWidth: 2,
                        tension: 0.3, // Đường cong
                        fill: true // Điền màu dưới đường
                    },
                    {
                        label: 'Lợi nhuận',
                        data: chartData.profits,
                        borderColor: 'rgba(75, 192, 192, 1)', // Màu đường
                        backgroundColor: 'rgba(75, 192, 192, 0.2)', // Màu nền mờ
                        borderWidth: 2,
                        tension: 0.3, // Đường cong
                        fill: true // Điền màu dưới đường
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    x: { title: { display: true, text: 'Ngày' } },
                    y: { title: { display: true, text: 'Doanh thu / Lợi nhuận' }, beginAtZero: true }
                }
            }
        });
    }

    // Khởi tạo biểu đồ mặc định (tuần)
    revenueChart = createChart(weekData);
    // Logic thay đổi dữ liệu biểu đồ khi chọn combobox
    document.getElementById('chartType').addEventListener('change', function () {
        const chartType = this.value;
        let selectedData;

        if (chartType === 'week') {
            selectedData = weekData;
        } else if (chartType === 'month') {
            selectedData = monthData;
        } else if (chartType === 'season') {
            selectedData = seasonData;
        }

        // Cập nhật biểu đồ
        revenueChart.destroy(); // Hủy biểu đồ cũ
        revenueChart = createChart(selectedData); // Tạo biểu đồ mới
    });

    // Khi click vào biểu đồ, hiển thị thông tin chi tiết
    document.getElementById('revenueChart').onclick = function (evt) {
        const activePoint = revenueChart.getElementsAtEventForMode(evt, 'nearest', { intersect: true }, false);
        if (activePoint.length > 0) {
            const chartData = activePoint[0]._chart.data;
            const idx = activePoint[0].index;
            const label = chartData.labels[idx];
            const revenue = chartData.datasets[0].data[idx];
            const profit = chartData.datasets[1].data[idx];
            alert(`Ngày: ${label}\nDoanh thu: ${revenue} VND\nLợi nhuận: ${profit} VND`);
        }
    };
</script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    <c:if test="${not empty message}">
    Swal.fire({
        icon: 'success',
        title: 'Thành công!',
        text: '${message}',
        confirmButtonText: 'OK'
    });
    </c:if>
    <c:if test="${not empty error}">
    Swal.fire({
        icon: 'error',
        title: 'Thất bại!',
        text: '${error}',
        confirmButtonText: 'OK'
    });
    </c:if>
</script>

<script>
    function navigateToPage(page) {
        // Thay đổi URL mà không tải lại trang
        const baseUrl = window.location.origin + window.location.pathname;
        const params = new URLSearchParams(window.location.search);
        // Giữ lại giá trị của tham số `status` nếu có
        const status = params.get("status") || "";

        params.set("page", page); // Thay đổi tham số `page`
        const newUrl = baseUrl + "?" + params.toString();

        // Thay đổi URL trên trình duyệt mà không tải lại trang
        history.pushState(null, "", newUrl);

        // Cuộn xuống tiêu đề "Tiến độ giao hàng của đơn vị vận chuyển"
        const target = document.getElementById("shipping-status-title");
        target.scrollIntoView({ behavior: "smooth", block: "start" });

        // Tải lại trang để cập nhật dữ liệu phân trang (nếu cần)
        window.location.reload();
    }

    function parseCustomDate(rawDate) {
        const parts = rawDate.split(' '); // Tách chuỗi ngày
        const months = {
            Jan: 0, Feb: 1, Mar: 2, Apr: 3, May: 4, Jun: 5,
            Jul: 6, Aug: 7, Sep: 8, Oct: 9, Nov: 10, Dec: 11
        };

        if (parts.length === 6) { // Ví dụ: Wed Dec 11 21:09:21 ICT 2024
            const day = parseInt(parts[2], 10);
            const month = months[parts[1]];
            const year = parseInt(parts[5], 10);

            return new Date(year, month, day); // Tạo Date hợp lệ
        }
        return null; // Trả về null nếu không hợp lệ
    }

    function applyDateFormatting() {
        const dateCells = document.querySelectorAll('td[data-date]');

        dateCells.forEach(cell => {
            const rawDate = cell.getAttribute('data-date'); // Lấy giá trị ngày thô
            if (rawDate) {
                let date = new Date(rawDate);

                // Nếu ngày không hợp lệ, thử parse bằng custom parser
                if (isNaN(date)) {
                    date = parseCustomDate(rawDate);
                }

                // Định dạng và hiển thị ngày
                if (date && !isNaN(date)) {
                    const year = date.getFullYear();
                    const month = String(date.getMonth() + 1).padStart(2, '0'); // Tháng bắt đầu từ 0
                    const day = String(date.getDate()).padStart(2, '0');
                    const formattedDate = day + '/' + month + '/' + year;

                    cell.textContent = formattedDate; // Cập nhật nội dung ô với ngày đã định dạng
                } else {
                    console.warn(`Invalid date: `, rawDate);
                }
            }
        });
    }

    function filterByStatus(status) {
        // Lấy base URL (bao gồm /admin hoặc /vendor)
        const baseUrl = window.location.origin + window.location.pathname;
        const params = new URLSearchParams(window.location.search);

        // Cập nhật tham số
        params.set('status', status);
        params.set('page', 1); // Reset về trang đầu tiên

        if (status === '') {
            params.delete('status');
        }

        // Tạo URL mới
        const newUrl = baseUrl + '?' + params.toString();

        // Thay đổi URL trên trình duyệt
        history.pushState(null, "", newUrl);

        // Gửi yêu cầu AJAX
        fetch(newUrl, {
            method: 'GET',
            headers: {
                'X-Requested-With': 'XMLHttpRequest' // Để server biết đây là AJAX request
            }
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! status:` + response.status);
                }
                return response.text(); // Trả về HTML
            })
            .then(html => {
                // Phân tích HTML và cập nhật phần bảng
                const parser = new DOMParser();
                const doc = parser.parseFromString(html, 'text/html');
                const newTable = doc.querySelector('#transactionTable');
                const totalShippingStatus = doc.querySelector('#totalShippingStatus').textContent;

                document.querySelector('#transactionTable').innerHTML = newTable.innerHTML;
                document.querySelector('#totalShippingStatus').textContent = totalShippingStatus;

                // Cập nhật lại ngày tháng
                applyDateFormatting();

                // Cuộn tới phần bảng
                document.getElementById('shipping-status-title').scrollIntoView({ behavior: 'smooth', block: 'start' });
            })
            .catch(error => console.error('Error fetching data:', error));
    }

    document.addEventListener('DOMContentLoaded', function () {
        applyDateFormatting();
    });

</script>

</body>
</html>