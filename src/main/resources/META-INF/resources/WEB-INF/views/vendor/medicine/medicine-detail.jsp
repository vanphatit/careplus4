<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medicine Detail</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f9f9f9;
        }
        .medicine-detail {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .medicine-image {
            max-width: 200px;
            border-radius: 10px;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <!-- Tiêu đề -->
    <div class="text-center mb-4">
        <h1 class="text-primary">Medicine Detail</h1>
    </div>

    <!-- Chi tiết thuốc -->
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="medicine-detail">
                <table class="table table-borderless">
                    <tbody>
                    <tr>
                        <th scope="row">ID</th>
                        <td>${medicine.id}</td>
                    </tr>
                    <tr>
                        <th scope="row">Name</th>
                        <td>${medicine.name}</td>
                    </tr>
                    <tr>
                        <th scope="row">Description</th>
                        <td>${medicine.description}</td>
                    </tr>
                    <tr>
                        <th scope="row">Unit Cost</th>
                        <td>${medicine.unitCost}</td>
                    </tr>
                    <tr>
                        <th scope="row">Expiry Date</th>
                        <td>${medicine.expiryDate}</td>
                    </tr>
                    <tr>
                        <th scope="row">Import Date</th>
                        <td>${medicine.importDate}</td>
                    </tr>
                    <tr>
                        <th scope="row">Stock Quantity</th>
                        <td>${medicine.stockQuantity}</td>
                    </tr>
                    <tr>
                        <th scope="row">Dosage</th>
                        <td>${medicine.dosage}</td>
                    </tr>
                    <tr>
                        <th scope="row">Rating</th>
                        <td>${medicine.rating}</td>
                    </tr>
                    <tr>
                        <th scope="row">Manufacturer</th>
                        <td>${medicine.manufacturer.name}</td>
                    </tr>
                    <tr>
                        <th scope="row">Category</th>
                        <td>${medicine.category.name}</td>
                    </tr>
                    <tr>
                        <th scope="row">Unit</th>
                        <td>${medicine.unit.name}</td>
                    </tr>
                    <tr>
                        <th scope="row">Image</th>
                        <td>
                            <img src="${pageContext.request.contextPath}/medicine/image?fileName=${medicine.image}"
                                 alt="Medicine Image"
                                 class="medicine-image img-thumbnail">
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div class="text-center mt-4">
                    <a href="${pageContext.request.contextPath}/vendor/medicines" class="btn btn-outline-primary">Back to List</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
