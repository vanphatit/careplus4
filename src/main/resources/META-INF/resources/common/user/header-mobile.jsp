<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>

<!-- mobilemenu -->
<div class="mobilemenu">
    <div class="mobilemenu__backdrop"></div>
    <div class="mobilemenu__body">
        <div class="mobilemenu__header">
            <div class="mobilemenu__title">Danh mục</div>
            <button type="button" class="mobilemenu__close">
                <svg
                        width="20px" height="20px">
                    <use xlink:href="${URL}assets/images/sprite.svg#cross-20"></use>
                </svg>
            </button>
        </div>
        <div class="mobilemenu__content">
            <ul class="mobile-links mobile-links--level--0" data-collapse
                data-collapse-opened-class="mobile-links__item--open">
                <c:forEach var="category" items="${rootCategories}">
                    <li class="mobile-links__item" data-collapse-item>
                        <div class="mobile-links__item-title">
                            <a href="/categories/${category.id}" class="mobile-links__item-link">${category.name}</a>
                            <button class="mobile-links__item-toggle" type="button" data-collapse-trigger>
                                <svg class="mobile-links__item-arrow" width="12px" height="7px">
                                    <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-12x7"></use>
                                </svg>
                            </button>
                        </div>
                        <c:if test="${!empty category.subCategories}">
                            <div class="mobile-links__item-sub-links" data-collapse-content>
                                <c:forEach var="subCategory" items="${category.subCategories}">
                                    <ul class="mobile-links mobile-links--level--1">
                                        <li class="mobile-links__item" data-collapse-item>
                                            <div class="mobile-links__item-title">
                                                <a href="/categories/${subCategory.id}"
                                                   class="mobile-links__item-link">${subCategory.name}</a>
                                            </div>
                                        </li>
                                    </ul>
                                </c:forEach>
                            </div>
                        </c:if>
                    </li>
                </c:forEach>

<%--                <li class="mobile-links__item">--%>
<%--                    <div class="mobile-links__item-title">--%>
<%--                        <a href="${URL}assets/about-us.html" class="mobile-links__item-link">Về chúng tôi</a>--%>
<%--                    </div>--%>
<%--                </li>--%>
<%--                <li class="mobile-links__item">--%>
<%--                    <div class="mobile-links__item-title">--%>
<%--                        <a href="${URL}assets/track-order.html" class="mobile-links__item-link">Theo dõi đơn hàng</a>--%>
<%--                    </div>--%>
<%--                </li>--%>
                <li class="mobile-links__item" data-collapse-item>
                    <div class="mobile-links__item-title">
                        <a href="#" class="mobile-links__item-link">
                            <c:choose>
                                <c:when test="${not empty user}">
                                    ${user.name} <!-- Hiển thị tên người dùng -->
                                </c:when>
                                <c:otherwise>
                                    Tài khoản
                                </c:otherwise>
                            </c:choose>
                        </a>
                        <button class="mobile-links__item-toggle" type="button" data-collapse-trigger>
                            <svg class="mobile-links__item-arrow" width="12px" height="7px">
                                <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-12x7"></use>
                            </svg>
                        </button>
                    </div>
                    <div class="mobile-links__item-sub-links" data-collapse-content>
                        <c:if test="${not empty user}">
                            <ul class="mobile-links mobile-links--level--1">
                                <li class="mobile-links__item" data-collapse-item>
                                    <div class="mobile-links__item-title">
                                        <a href="${pageContext.request.contextPath}/user/userInfo"
                                           class="mobile-links__item-link">Tài khoản của tôi</a>
                                    </div>
                                </li>
                            </ul>
                            <ul class="mobile-links mobile-links--level--1">
                                <li class="mobile-links__item" data-collapse-item>
                                    <div class="mobile-links__item-title">
                                        <a href="${pageContext.request.contextPath}/user/order-history"
                                           class="mobile-links__item-link">Đơn hàng</a>
                                    </div>
                                </li>
                            </ul>
                            <ul class="mobile-links mobile-links--level--1">
                                <li class="mobile-links__item" data-collapse-item>
                                    <div class="mobile-links__item-title">
                                        <a href="${pageContext.request.contextPath}/user/reviews"
                                           class="mobile-links__item-link">Đánh giá</a>
                                    </div>
                                </li>
                            </ul>
                        </c:if>

                        <c:choose>
                            <c:when test="${not empty user}">
                                <ul class="mobile-links mobile-links--level--1">
                                    <li class="mobile-links__item" data-collapse-item>
                                        <div class="mobile-links__item-title">
                                            <a href="/au/logout"
                                               class="mobile-links__item-link">Đăng xuất</a>
                                        </div>
                                    </li>
                                </ul>
                            </c:when>
                            <c:otherwise>
                                <ul class="mobile-links mobile-links--level--1">
                                    <li class="mobile-links__item" data-collapse-item>
                                        <div class="mobile-links__item-title">
                                            <a href="/au/login"
                                               class="mobile-links__item-link">Đăng nhập</a>
                                        </div>
                                    </li>
                                </ul>
                                <ul class="mobile-links mobile-links--level--1">
                                    <li class="mobile-links__item" data-collapse-item>
                                        <div class="mobile-links__item-title">
                                            <a href="/au/signup"
                                               class="mobile-links__item-link">Đăng ký</a>
                                        </div>
                                    </li>
                                </ul>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
<!-- mobilemenu / end -->

<header class="site__header d-lg-none">
    <div class="mobile-header mobile-header--sticky mobile-header--stuck">
        <div class="mobile-header__panel">
            <div class="container">
                <div class="mobile-header__body">
                    <button class="mobile-header__menu-button">
                        <svg width="18px" height="14px">
                            <use xlink:href="${URL}assets/images/sprite.svg#menu-18x14"></use>
                        </svg>
                    </button>
                    <a class="mobile-header__logo" href="${URL}assets/index.html">
                        <img src="${URL}assets/images/careplus4-high-resolution-logo-transparent.png"
                             width="120px" height="20px"></a>
                    <div class="mobile-header__search">
                        <form class="mobile-header__search-form" method="post" action="/user/medicine/search">
                            <input class="mobile-header__search-input" name="keyword" style="color: #000000"
                                placeholder="Tìm kiếm ..." aria-label="Site search" type="text"
                                autocomplete="off">
                            <button
                                    class="mobile-header__search-button mobile-header__search-button--submit"
                                    type="submit">
                                <svg width="20px" height="20px">
                                    <use xlink:href="${URL}assets/images/sprite.svg#search-20"></use>
                                </svg>
                            </button>
                            <button
                                    class="mobile-header__search-button mobile-header__search-button--close"
                                    type="button">
                                <svg width="20px" height="20px">
                                    <use xlink:href="${URL}assets/images/sprite.svg#cross-20"></use>
                                </svg>
                            </button>
                            <div class="mobile-header__search-body"></div>
                        </form>
                    </div>
                    <div class="mobile-header__indicators">
                        <div class="indicator indicator--mobile-search indicator--mobile d-sm-none">
                            <button
                                    class="indicator__button"><span class="indicator__area"><svg width="20px"
                                                                                                 height="20px">
                                                <use xlink:href="${URL}assets/images/sprite.svg#search-20"></use>
                                            </svg></span></button>
                        </div>
<%--                        <div class="indicator indicator--mobile d-sm-flex d-none"><a href="${URL}assets/wishlist.html"--%>
<%--                                                                                     class="indicator__button"><span--%>
<%--                                class="indicator__area"><svg width="20px"--%>
<%--                                                             height="20px">--%>
<%--                                                <use xlink:href="${URL}assets/images/sprite.svg#heart-20"></use>--%>
<%--                                            </svg> <span class="indicator__value">0</span></span></a></div>--%>
                        <div class="indicator indicator--mobile"><a href="${URL}assets/cart.html"
                                                                    class="indicator__button"><span
                                class="indicator__area"><svg width="20px"
                                                             height="20px">
                                                <use xlink:href="${URL}assets/images/sprite.svg#cart-20"></use>
                                            </svg> <span class="indicator__value">${user.cart.productCount}</span></span></a></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>