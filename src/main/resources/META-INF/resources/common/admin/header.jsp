<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
        <!-- Hiển thị vai trò của người dùng -->
        <li class="app-nav__role">
            <!-- Ô chứa chữ VENDOR -->
            <span>${user.role.name}</span>
        </li>
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
        <img class="app-sidebar__user-avatar" src="<c:url value='/assets/images/careplus4-high-resolution-logo.png' />"
             width="50px" alt="User Image">
        <div>
            <p class="app-sidebar__user-name"><b> <a href="/" style="text-decoration: none; color: #FFFFFF">CarePlus4</a> </b></p>
            <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
        </div>
    </div>
    <hr>
    <ul class="app-menu">

        <c:if test="${user.role.name=='VENDOR'}">
            <li>
                <a class="app-menu__item haha" href="<c:url value='/vendor/dashboard' />">
                    <i class='app-menu__icon bx bx-tachometer'></i>
                    <span class="app-menu__label">Dashboard</span>
                </a>
            </li>
            <li>
                <a class="app-menu__item" href="<c:url value='/vendor/bills' />">
                    <i class='app-menu__icon bx bx-receipt'></i>
                    <span class="app-menu__label">Quản lý bán hàng</span>
                </a>
            </li>
        </c:if>

        <!-- Các thẻ dành cho ADMIN -->
        <c:if test="${user.role.name=='ADMIN'}">
            <li>
                <a class="app-menu__item haha" href="<c:url value='/admin/dashboard' />">
                    <i class='app-menu__icon bx bx-tachometer'></i>
                    <span class="app-menu__label">Dashboard</span>
                </a>
            </li>
            <li>
                <a class="app-menu__item" href="<c:url value='/admin/bill' />">
                    <i class='app-menu__icon bx bx-receipt'></i>
                    <span class="app-menu__label">Quản lý bán hàng</span>
                </a>
            </li>
            <li>
                <a class="app-menu__item" href="<c:url value='/admin/user' />">
                    <i class='app-menu__icon bx bx-user'></i>
                    <span class="app-menu__label">Quản lý người dùng</span>
                </a>
            </li>
        </c:if>

        <!-- Các thẻ dành cho VENDOR -->
        <c:if test="${user.role.name=='ADMIN' || user.role.name == 'VENDOR'}">
            <li>
                <a class="app-menu__item" href="<c:url value='/vendor/medicine' />">
                    <i class='app-menu__icon bx bx-capsule'></i>
                    <span class="app-menu__label">Quản lý thuốc</span>
                </a>
            </li>
            <li>
                <a class="app-menu__item" href="<c:url value='/vendor/review' />">
                    <i class='app-menu__icon bx bx-message-rounded-dots'></i>
                    <span class="app-menu__label">Quản lý review</span>
                </a>
            </li>
            <li>
                <a class="app-menu__item" href="<c:url value='/vendor/import' />">
                    <i class='app-menu__icon bx bx-log-in-circle'></i>
                    <span class="app-menu__label">Quản lý nhập hàng</span>
                </a>
            </li>
            <li>
                <a class="app-menu__item" href="<c:url value='/vendor/event' />">
                    <i class='app-menu__icon bx bx-calendar-check'></i>
                    <span class="app-menu__label">Quản lý sự kiện</span>
                </a>
            </li>
            <li>
                <a class="app-menu__item" href="<c:url value='/vendor/manufacturer' />">
                    <i class='app-menu__icon bx bx-user-check'></i>
                    <span class="app-menu__label">Quản lý nhà sản xuất</span>
                </a>
            </li>
        </c:if>
        <c:if test="${user.role.name=='ADMIN'}">
            <li>
                <a class="app-menu__item" href="<c:url value='/admin/categories' />">
                    <i class='app-menu__icon bx bx-category'></i>
                    <span class="app-menu__label">Quản lý danh mục</span>
                </a>
            </li>
            <li>
                <a class="app-menu__item" href="<c:url value='/admin/unit' />">
                    <i class='app-menu__icon bx bx-purchase-tag-alt'></i>
                    <span class="app-menu__label">Quản lý đơn vị</span>
                </a>
            </li>
            <li>
                <a class="app-menu__item" href="<c:url value='/admin/provider' />">
                    <i class='app-menu__icon bx bx-heart'></i>
                    <span class="app-menu__label">Quản lý nhà cung cấp</span>
                </a>
            </li>
        </c:if>
    </ul>
</aside>



