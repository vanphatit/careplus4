<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:url value="/" var="URL"></c:url>

<!DOCTYPE html>
<html lang="en" dir="ltr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta name="format-detection" content="telephone=no">
    <title>Care Plus 4</title>
    <link rel="icon" type="image/png" href="${URL}assets/images/batch-5---design-1-high-resolution-logo-transparent.png"><!-- fonts -->
    <link rel="stylesheet" href="${URL}assets/https://fonts.googleapis.com/css?family=Roboto:400,400i,500,500i,700,700i"><!-- css -->
    <link rel="stylesheet" href="${URL}assets/vendor/bootstrap-4.2.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="${URL}assets/vendor/owl-carousel-2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="${URL}assets/css/style.css"><!-- js -->
    <script src="${URL}assets/vendor/jquery-3.3.1/jquery.min.js"></script>
    <script src="${URL}assets/vendor/bootstrap-4.2.1/js/bootstrap.bundle.min.js"></script>
    <script src="${URL}assets/vendor/owl-carousel-2.3.4/owl.carousel.min.js"></script>
    <script src="${URL}assets/vendor/nouislider-12.1.0/nouislider.min.js"></script>
    <script src="${URL}assets/js/number.js"></script>
    <script src="${URL}assets/js/main.js"></script>
    <script src="${URL}assets/vendor/svg4everybody-2.1.9/svg4everybody.min.js"></script>
    <script>svg4everybody();</script><!-- font - fontawesome -->
    <link rel="stylesheet" href="${URL}assets/vendor/fontawesome-5.6.1/css/all.min.css"><!-- font - stroyka -->
    <link rel="stylesheet" href="${URL}assets/fonts/stroyka/stroyka.css">
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-97489509-6"></script>
    <script>window.dataLayer = window.dataLayer || []; function gtag() { dataLayer.push(arguments); } gtag('js', new Date()); gtag('config', 'UA-97489509-6');</script>
</head>

<body>
<div class="site">
    <!-- BEGIN CONTENT -->
    <sitemesh:write property='body' />
    <!-- END CONTENT -->
</div>
</body>

</html>