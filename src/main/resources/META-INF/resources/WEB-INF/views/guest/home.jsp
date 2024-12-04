<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - Care Plus</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f8f9fa;
        }

        .highlight-wrapper {
            background-color: #ffffff;
            border: 2px solid #0d6efd;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            padding: 20px;
        }

        .banner {
            background-color: #f8f9fa;
            border-left: 5px solid #0d6efd;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
        }

        .category-card,
        .product-card {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: 10px;
            transition: all 0.3s ease-in-out;
            text-align: center;
            padding: 15px;
            margin-bottom: 15px;
        }

        .category-card:hover,
        .product-card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .category-card h5,
        .product-card h5 {
            font-weight: bold;
            margin-bottom: 10px;
        }

        .product-card img {
            max-width: 100%;
            border-radius: 10px;
        }

        .btn-view-more {
            background-color: #0d6efd;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            text-transform: uppercase;
            font-size: 14px;
            transition: background-color 0.3s ease-in-out;
        }

        .btn-view-more:hover {
            background-color: #004cba;
        }

        .row {
            margin-top: 20px;
        }

        /* Card cho nhà sản xuất */
        .brand-card {
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 10px;
            width: 100%;
            max-width: 300px; /* Đảm bảo độ rộng tối đa */
            min-height: 200px; /* Chiều cao tối thiểu để đồng bộ */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        /* Đảm bảo tên thương hiệu dài không gây tràn */
        .brand-name {
            font-size: 16px;
            font-weight: bold;
            max-height: 3rem; /* Giới hạn chiều cao tối đa của tên */
            overflow: hidden;
            line-height: 1.5;
            white-space: nowrap;
            text-overflow: ellipsis; /* Cắt bớt tên nếu quá dài */
        }

        /* Hiệu ứng hover */
        .brand-card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
        }

        /* Khoảng cách giữa các hàng */
        .row.justify-content-center {
            gap: 20px;
        }

        /* Dòng mô tả */
        .brand-card p {
            font-size: 0.9rem;
            margin: 0;
        }

        /* Đảm bảo khoảng cách giữa các mục */
        .row.g-3 {
            gap: 20px;
        }
    </style>
</head>
<body>

<div class="container mt-4">
    <div class="container mt-5">
        <!-- Wrapper để làm nổi bật -->
        <div class="highlight-wrapper p-4 shadow-lg rounded">
            <div id="event-carousel" class="carousel slide mb-4 position-relative" data-bs-ride="carousel">
                <!-- Indicators -->
                <div class="carousel-indicators">
                    <c:forEach var="event" items="${events}" varStatus="status">
                        <button type="button" data-bs-target="#event-carousel" data-bs-slide-to="${status.index}"
                                class="${status.index == 0 ? 'active' : ''}" aria-current="${status.index == 0 ? 'true' : 'false'}"
                                aria-label="Slide ${status.index + 1}">
                        </button>
                    </c:forEach>
                </div>

                <!-- Inner carousel content -->
                <div class="carousel-inner">
                    <c:forEach var="event" items="${events}" varStatus="status">
                        <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                            <div class="banner-slide p-5 text-center">
                                <h2 class="text-primary">${event.name}</h2>
                                <p><strong>Ngày bắt đầu:</strong> ${event.dateStart}</p>
                                <p><strong>Ngày kết thúc:</strong> ${event.dateEnd}</p>
                                <p><strong>Giảm giá:</strong> ${event.discount}%</p>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- Controls placed outside -->
                    <button class="carousel-control-prev position-absolute outside-control" type="button" data-bs-target="#event-carousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next position-absolute outside-control" type="button" data-bs-target="#event-carousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </div>
        </div>

        <br>

        <!-- Top 10 Nhà sản xuất nổi bật -->
        <div class="container mt-4">
            <div class="container mb-4">
                <div class="highlight-wrapper p-4 shadow-lg rounded">
                <h2 class="text-center text-primary">Top 9 Nhà sản xuất nổi bật</h2>
                <div class="row justify-content-center">
                    <c:forEach var="brand" items="${topBrands}">
                        <div class="col-md-4 d-flex justify-content-center">
                            <div class="brand-card p-3 text-center shadow-sm" style="width: 100%">
                                <h5 class="brand-name text-truncate" title="${brand["brandName"]}">
                                        ${brand["brandName"]}
                                </h5>
                                <p><strong>Số lượng sản phẩm:</strong> ${brand["totalProducts"]}</p>
                                <p><strong>Số lượng bán:</strong> ${brand["totalSales"]}</p>
                                <form action="${URL}user/medicine/search" method="post">
                                    <input type="hidden" name="keyword" value="${brand["brandName"]}">
                                    <button type="submit" class="btn btn-primary mt-3">Xem sản phẩm</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                </div>
            </div>
        </div>

        <br>

        <div class="container mt-4">
            <div class="container mb-4">
                <div class="highlight-wrapper p-4 shadow-lg rounded">
                    <h2 class="text-center text-primary">Top 3 sản phẩm bán chạy trong 7 ngày gần đây</h2>
                    <div class="row">
                        <c:forEach var="medicine" items="${topProducts}">
                            <div class="col-md-4 col-sm-6">
                                <div class="product-card shadow-sm rounded p-3">
                                    <img src="${pageContext.request.contextPath}/image?fileName=${medicine.image}" class="img-fluid rounded" alt="${medicine.name}">
                                    <h5 class="mt-3">${medicine.name}</h5>
                                    <p><strong>Giá:</strong> ${medicine.unitCost} VND</p>
                                    <p><strong>Đánh giá:</strong> ${medicine.rating}</p>
                                    <p><strong>Số lượng bán:</strong> ${medicine.get("totalSales")}</p>
                                    <form action="${URL}user/medicine/${medicine.id}" method="get">
                                        <button type="submit" class="btn btn-primary mt-3">Xem chi tiết</button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <br>
            <!-- Top 10 sản phẩm bán chạy -->
            <div class="container mt-4">
                <div class="container mb-4">
                    <div class="highlight-wrapper p-4 shadow-lg rounded">
                        <h2 class="text-center text-primary">Top 9 sản phẩm bán chạy</h2>
                        <div class="row">
                            <c:forEach var="medicine" items="${topSelling}">
                                <div class="col-md-4 col-sm-6">
                                    <div class="product-card shadow-sm rounded p-3">
                                        <img src="${pageContext.request.contextPath}/image?fileName=${medicine.image}" class="img-fluid rounded" alt="${medicine.name}">
                                        <h5 class="mt-3">${medicine.name}</h5>
                                        <p><strong>Giá:</strong> ${medicine.unitCost} VND</p>
                                        <p><strong>Đánh giá:</strong> ${medicine.rating}</p>
                                        <form action="${URL}user/medicine/${medicine.id}" method="get">
                                            <button type="submit" class="btn btn-primary mt-3">Xem chi tiết</button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        <br>

        <div class="container mt-4">
            <div class="container mb-4">
                <div class="highlight-wrapper p-4 shadow-lg rounded">
                    <h2 class="text-center text-primary">Top 9 Danh mục sản phẩm nổi bật</h2>
                    <div class="row justify-content-center">
                        <c:forEach var="brand" items="${topCategories}">
                            <div class="col-md-4 d-flex justify-content-center">
                                <div class="brand-card p-3 text-center shadow-sm" style="width: 100%">
                                    <h5 class="brand-name text-truncate" title="${brand["categoryName"]}">
                                            ${brand["categoryName"]}
                                    </h5>
                                    <p><strong>Số lượng sản phẩm:</strong> ${brand["totalProducts"]}</p>
                                    <p><strong>Số lượng bán:</strong> ${brand["totalSales"]}</p>
                                    <form action="${URL}user/medicine/search" method="post">
                                        <input type="hidden" name="keyword" value="${brand["categoryName"]}">
                                        <button type="submit" class="btn btn-primary mt-3">Xem sản phẩm</button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
