<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>403 - Access Denied</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container d-flex flex-column justify-content-center align-items-center vh-100 text-center">
    <!-- Icon or Image -->
    <div class="mb-4">
        <i class="bi bi-shield-lock-fill text-danger display-1"></i> <!-- Icon -->
    </div>

    <!-- Error Message -->
    <h1 class="display-1 text-danger">403</h1>
    <h2 class="mb-3">Access Denied</h2>
    <p class="lead mb-4">You do not have permission to access this page.</p>

<%--    <!-- Image -->--%>
<%--    <div class="mb-4">--%>
<%--        <img src="${pageContext.request.contextPath}/images/image?fileName=lock.png"--%>
<%--             alt="Access Denied"--%>
<%--             class="img-fluid rounded"--%>
<%--             style="width: 200px; height: 150px;background: none;">--%>
<%--    </div>--%>

    <!-- Action Button -->
    <a href="/" class="btn btn-primary btn-lg">
        <i class="bi bi-house-door"></i> Back to Home
    </a>
</div>

<!-- Bootstrap JS (Optional for interactivity) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
