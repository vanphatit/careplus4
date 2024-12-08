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
    <div class="row text-center mt-5">
        <!-- Tổng số người dùng -->
        <div class="col-md-3">
            <div class="card text-dark bg-light border-primary shadow">
                <div class="card-body">
                    <h5 class="card-title">
                        <i class="fas fa-users text-primary"></i> Tổng số người dùng
                    </h5>
                    <h3>
                        <c:if test="${user.role != null && user.role.name != null && user.role.name == 'ADMIN'}">
                            <a href="${URL}admin/users" class="text-decoration-none text-dark">${totalUser}</a>
                        </c:if>
                        <c:if test="${user.role != null && user.role.name != null && user.role.name == 'VENDOR'}">
                            <strong>${totalUser}</strong>
                        </c:if>
                    </h3>
                </div>
            </div>
        </div>
        <!-- Tổng hàng trong kho -->
        <div class="col-md-3">
            <div class="card text-dark bg-light border-success shadow">
                <div class="card-body">
                    <h5 class="card-title">
                        <i class="fas fa-cubes text-success"></i> Tổng hàng trong kho
                    </h5>
                    <h3>
                        <a href="${URL}vendor/medicines" class="text-decoration-none text-dark">${totalStockQuantity}</a>
                    </h3>
                </div>
            </div>
        </div>
        <!-- Doanh thu hôm nay -->
        <div class="col-md-3">
            <div class="card text-dark bg-light border-warning shadow">
                <div class="card-body">
                    <h5 class="card-title">
                        <i class="fas fa-dollar-sign text-warning"></i> Doanh thu hôm nay
                    </h5>
                    <h3>
                        <a href="${URL}admin/bills" class="text-decoration-none text-dark">
                            <span id="revenueToday">${revenueToday}</span> VND
                        </a>
                    </h3>
                </div>
            </div>
        </div>
        <!-- Doanh thu tuần -->
        <div class="col-md-3">
            <div class="card text-dark bg-light border-danger shadow">
                <div class="card-body">
                    <h5 class="card-title">
                        <i class="fas fa-chart-line text-danger"></i> Doanh thu tuần
                    </h5>
                    <h3>
                        <a href="${URL}admin/bills" class="text-decoration-none text-dark">
                            <span id="revenueForWeek">${revenueForWeek}</span> VND
                        </a>
                    </h3>
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

    <!-- Thong bao loi khong ket noi api -->
    <c:if test="${error != null}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <strong>${error}</strong>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"> Đóng</button>
        </div>
    </c:if>

    <!-- Bảng giao dịch -->
    <div class="row mt-5">
        <div class="col-md-12">
            <h3 class="text-center">Tiến độ giao hàng</h3>
            <table class="table table-bordered table-striped">
                <thead class="table-primary text-center">
                <tr>
                    <th>Mã Hóa Đơn</th>
                    <th>Số Điện Thoại</th>
                    <th>Tên Người Nhận</th>
                    <th>Tổng Tiền</th>
                    <th>Ngày Tạo</th>
                    <th>Ngày Giao</th>
                    <th>Trạng Thái</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="transaction" items="${transactionHistory}">
                    <tr>
                        <td>
                            <a href="${URL}vendor/bill/${transaction.idBill}" class="text-decoration-none">
                                ${transaction.idBill}
                            </a>
                        </td>
                        <td>${transaction.userPhone}</td>
                        <td>${transaction.receiverName}</td>
                        <td>
                            <span class="total-amount">${transaction.totalAmount}</span> VND
                        </td>
                        <td>${transaction.date}</td>
                        <td>${transaction.deliveryDate}</td>
                        <td>${transaction.status}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
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
            labels: records.map(record => new Date(record.date).toLocaleDateString("Default", { day: '2-digit', month: '2-digit' })), // Format ngày tháng (dd/mm)
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

</body>
</html>
