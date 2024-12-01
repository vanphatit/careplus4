<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:url value="/" var="URL"></c:url>
<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>

<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>Admin Dashboard</title>--%>
<%--    <!-- CSS Link -->--%>
<%--    <link rel="stylesheet" href="/static/css/main.css">--%>
<%--    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">--%>
<%--</head>--%>


<!-- Navbar -->
<header class="app-header">
    <a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
    <ul class="app-nav">
        <li>
            <a class="app-nav__item" href="${pageContext.request.contextPath}/au/logout">
                <i class='bx bx-log-out bx-rotate-180'></i>
            </a>
        </li>
    </ul>
</header>

<%--<!-- Sidebar -->--%>
<aside class="app-sidebar">
    <div class="app-sidebar__user">
        <img class="app-sidebar__user-avatar" src="<c:url value='/assets/images/careplus4-high-resolution-logo.png' />" width="50px" alt="User Image">
        <div>
            <p class="app-sidebar__user-name"><b>CarePlus4</b></p>
            <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
        </div>
    </div>
    <hr>
    <ul class="app-menu">
        <li><a class="app-menu__item haha" href="<c:url value='/' />">
            <i class='app-menu__icon bx bx-cart-alt'></i>
            <span class="app-menu__label">Quản lý bán hàng </span></a>
        </li>
        <li><a class="app-menu__item active" href="<c:url value='/admin' />">
            <i class='app-menu__icon bx bx-tachometer'></i>
            <span class="app-menu__label">Dashboard</span></a>
        </li>
        <li><a class="app-menu__item" href="<c:url value='/admin/categories' />">
            <i class='app-menu__icon bx bx-id-card'></i>
            <span class="app-menu__label">Quản lý danh mục</span></a>
        </li>
        <li><a class="app-menu__item" href="<c:url value='/vendor/medicines' />">
            <i class='app-menu__icon bx bx-purchase-tag-alt'></i>
            <span class="app-menu__label">Quản lý thuốc</span></a>
        </li>
        <li><a class="app-menu__item" href="<c:url value='/' />">
            <i class='app-menu__icon bx bx-cart-alt'></i>
            <span class="app-menu__label">Quản lý giỏ hàng</span></a>
        </li>
        <li><a class="app-menu__item" href="<c:url value='/vendor/import' />">
            <i class='app-menu__icon bx bx-task'></i>
            <span class="app-menu__label">Quản lý nhập hàng</span></a>
        </li>
        <li><a class="app-menu__item" href="<c:url value='/admin/units' />">
            <i class='app-menu__icon bx bx-purchase-tag-alt'></i>
            <span class="app-menu__label">Quản lý đơn vị</span></a>
        </li>
        <li><a class="app-menu__item" href="<c:url value='/vendor/event' />">
            <i class='app-menu__icon bx bx-calendar-check'></i>
            <span class="app-menu__label">Quản lý sự kiện</span></a>
        </li>
        <li><a class="app-menu__item" href="<c:url value='/admin/provider' />">
            <i class='app-menu__icon bx bx-run'></i>
            <span class="app-menu__label">Quản lý nhà cung cấp</span></a>
        </li>
        <li><a class="app-menu__item" href="<c:url value='/vendor/reviews' />">
            <i class='app-menu__icon bx bx-user-voice'></i>
            <span class="app-menu__label">Quản lý review</span></a>
        </li>

        <!-- Add more menu items -->
    </ul>
</aside>


