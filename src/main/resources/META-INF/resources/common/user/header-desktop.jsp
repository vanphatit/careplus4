<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL"></c:url>

<header class="site__header d-lg-block d-none">
    <div class="site-header"><!-- .topbar -->
        <div class="site-header__topbar topbar">
            <div class="topbar__container container">
                <div class="topbar__row">
                    <div class="topbar__item topbar__item--link"><a class="topbar-link"
                                                                    href="${URL}assets/about-us.html">Về chúng tôi</a>
                    </div>
                    <div class="topbar__item topbar__item--link">
                        <a class="topbar-link" href="${URL}assets/track-order.html">Theo dõi đơn hàng</a></div>
                    <div class="topbar__spring"></div>
                    <div class="topbar__item">
                        <div class="topbar-dropdown">
                            <button class="topbar-dropdown__btn" type="button">Tài khoản
                                <svg width="7px" height="5px">
                                    <use href="${URL}assets/images/sprite.svg#arrow-rounded-down-7x5"></use>
                                </svg>
                            </button>
                            <div class="topbar-dropdown__body"><!-- .menu -->
                                <ul class="menu menu--layout--topbar">
                                    <li><a href="${URL}assets/account.html">Thông tin cá nhân</a></li>
                                    <li><a href="${URL}assets/#">Đơn hàng</a></li>
                                    <li><a href="#">Đánh giá</a></li>
                                </ul><!-- .menu / end -->
                            </div>
                        </div>
                    </div>
                    <div class="topbar__item topbar__item--link"><a class="topbar-link"
                                                                    href="/au/login">Đăng nhập</a></div>
                    <div class="topbar__item topbar__item--link"><a class="topbar-link"
                                                                    href="/au/logout">Đăng xuất</a></div>
                </div>
            </div>
        </div><!-- .topbar / end -->
        <div class="site-header__nav-panel">
            <div class="nav-panel">
                <div class="nav-panel__container container">
                    <div class="nav-panel__row">
                        <div class="nav-panel__logo">
                            <a href="#">
                                <img src="${URL}assets/images/careplus4-high-resolution-logo-transparent.png"
                                     width="auto" height="30px"></a>
                        </div><!-- .nav-links -->
                        <div class="nav-panel__nav-links nav-links">
                            <ul class="nav-links__list">
                                <c:forEach var="category" items="${rootCategories}">
                                    <li class="nav-links__item nav-links__item--with-submenu">
                                        <a href="/categories/${category.id}">
                                            <span>${category.name}
                                            <svg class="nav-links__arrow" width="9px" height="6px">
                                                <use href="images/sprite.svg#arrow-rounded-down-9x6"></use>
                                            </svg></span>
                                        </a>
                                        <c:if test="${!empty category.subCategories}">
                                            <div class="nav-links__menu">
                                                <ul class="menu menu--layout--classic">
                                                    <c:forEach var="subCategory" items="${category.subCategories}">
                                                        <li>
                                                            <a href="/categories/${subCategory.id}">
                                                                    ${subCategory.name}
                                                            </a>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                        </c:if>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div><!-- .nav-links / end -->
                        <div class="nav-panel__indicators">
                            <div class="indicator indicator--trigger--click">
                                <button type="button"
                                        class="indicator__button"><span class="indicator__area"><svg
                                        class="indicator__icon" width="20px" height="20px">
                                                    <use href="${URL}assets/images/sprite.svg#search-20"></use>
                                                </svg> <svg class="indicator__icon indicator__icon--open" width="20px"
                                                            height="20px">
                                                    <use href="${URL}assets/images/sprite.svg#cross-20"></use>
                                                </svg></span></button>
                                <div class="indicator__dropdown">
                                    <div class="drop-search">
                                        <form action="#" class="drop-search__form"><input
                                                class="drop-search__input" name="search"
                                                placeholder="Tìm kiếm sản phẩm"
                                                aria-label="Site search" type="text" autocomplete="off">
                                            <button
                                                    class="drop-search__button drop-search__button--submit"
                                                    type="submit">
                                                <svg width="20px" height="20px">
                                                    <use href="${URL}assets/images/sprite.svg#search-20"></use>
                                                </svg>
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="indicator"><a href="${URL}wishlist.html" class="indicator__button"><span
                                    class="indicator__area"><svg width="20px" height="20px">
                                                    <use href="${URL}assets/images/sprite.svg#heart-20"></use>
                                                </svg> <span class="indicator__value">0</span></span></a></div>
                            <div class="indicator"><a href="${pageContext.request.contextPath}/cart"
                                                      class="indicator__button"><span
                                    class="indicator__area"><svg width="20px"
                                                                 height="20px">
                                                    <use href="${URL}assets/images/sprite.svg#cart-20"></use>
                                                </svg> <span class="indicator__value">3</span></span></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- desktop site__header / end --><!-- site__body -->