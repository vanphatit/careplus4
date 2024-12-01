<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:url value="/" var="URL"></c:url>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Đăng nhập/Đăng ký</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="${URL}assets/fonts/material-icon/css/material-design-iconic-font.min.css">

    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">

    <!-- Main css -->
    <link rel="stylesheet" href="${URL}assets/css/style-login.css">
</head>
<body>

<div class="main">
    <!-- BEGIN CONTENT -->
    <sitemesh:write property='body' />
    <!-- END CONTENT -->
</div>

<!-- JS -->
<script src="${URL}assets/vendor/jquery-3.3.1/jquery.min.js"></script>
</body>
</html>