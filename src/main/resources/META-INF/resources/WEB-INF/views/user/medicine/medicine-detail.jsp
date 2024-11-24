<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medicine Details</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f9f9f9;
        }
        .medicine-details {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .medicine-details h1 {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .medicine-details img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
        }
        .back-link {
            margin-top: 20px;
        }
        .back-link a {
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <!-- Tiêu đề -->
    <div class="text-center mb-4">
        <h1 class="text-primary">Medicine Details</h1>
    </div>

    <!-- Chi tiết thuốc -->
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="medicine-details p-4">
                <div class="row">
                    <div class="col-md-4">
                        <!-- Hình ảnh thuốc -->
                        <img src="${pageContext.request.contextPath}/medicine/image?fileName=${medicine.image}" alt="${medicine.name}">
                    </div>
                    <div class="col-md-8">
                        <!-- Thông tin thuốc -->
                        <table class="table table-borderless">
                            <tbody>
                            <tr>
                                <th>Name:</th>
                                <td>${medicine.name}</td>
                            </tr>
                            <tr>
                                <th>Description:</th>
                                <td>${medicine.description}</td>
                            </tr>
                            <tr>
                                <th>Category:</th>
                                <td>${medicine.categoryName}</td>
                            </tr>
                            <tr>
                                <th>Manufacturer:</th>
                                <td>${medicine.manufacturerName}</td>
                            </tr>
                            <tr>
                                <th>Unit Name:</th>
                                <td>${medicine.unitName}</td>
                            </tr>
                            <tr>
                                <th>Unit Cost:</th>
                                <td>${medicine.unitCost}</td>
                            </tr>
                            <tr>
                                <th>Stock Quantity:</th>
                                <td>${medicine.stockQuantity}</td>
                            </tr>
                            <tr>
                                <th>Rating:</th>
                                <td>${medicine.rating}</td>
                            </tr>
                            <tr>
                                <th>Expiry Date:</th>
                                <td>${medicine.expiryDate}</td>
                            </tr>
                            <tr>
                                <th>Dosage:</th>
                                <td>${medicine.dosage}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Nút quay lại -->
            <div class="text-center back-link mt-4">
                <a href="${pageContext.request.contextPath}/user/medicines" class="btn btn-outline-primary">Back to List</a>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
