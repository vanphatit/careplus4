<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error Page</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center vh-100">
<div class="container text-center">
    <div class="card shadow p-4">
        <div class="card-body">
            <h1 class="display-4 text-danger">Error Occurred</h1>
            <p class="fs-5">Status Code: <strong>${statusCode}</strong></p>
            <p class="fs-5">Message: <strong>${errorMessage}</strong></p>
            <p class="fs-5">Path: <strong>${path}</strong></p>
            <a href="/" class="btn btn-primary btn-lg mt-3"></i> Back to Home</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS (Optional for interactivity) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
