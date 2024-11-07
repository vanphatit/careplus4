<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:url value="/" var="URL"></c:url>

<header class="site__header d-lg-block d-none">
    <div class="site-header"><!-- .topbar -->
        <div class="site-header__topbar topbar">
            <div class="topbar__container container">
                <div class="topbar__row">
                    <div class="topbar__item topbar__item--link"><a class="topbar-link"
                                                                    href="${URL}assets/about-us.html">Về chúng tôi</a></div>
                    <div class="topbar__item topbar__item--link"><a class="topbar-link"
                                                                    href="${URL}assets/contact-us.html">Liên hệ</a></div>
                    <div class="topbar__item topbar__item--link"><a class="topbar-link"
                                                                    href="${URL}assets/track-order.html">Theo dõi đơn hàng</a></div>

                    <div class="topbar__spring"></div>
                    <div class="topbar__item">
                        <div class="topbar-dropdown"><button class="topbar-dropdown__btn" type="button">Tài khoản
                            <svg width="7px" height="5px">
                                <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-7x5"></use>
                            </svg></button>
                            <div class="topbar-dropdown__body"><!-- .menu -->
                                <ul class="menu menu--layout--topbar">
                                    <li><a href="${URL}assets/account.html">Thông tin cá nhân</a></li>
                                    <li><a href="${URL}assets/#">Đơn hàng</a></li>
                                </ul><!-- .menu / end -->
                            </div>
                        </div>
                    </div>
                    <div class="topbar__item topbar__item--link"><a class="topbar-link"
                                                                    href="${URL}assets/blog-classic.html">Đăng nhập</a></div>
                    <div class="topbar__item topbar__item--link"><a class="topbar-link"
                                                                    href="${URL}assets/blog-classic.html">Đăng xuất</a></div>
                    <%--                        <div class="topbar__item">--%>
                    <%--                            <div class="topbar-dropdown"><button class="topbar-dropdown__btn"--%>
                    <%--                                                                 type="button">Currency: <span class="topbar__item-value">USD</span> <svg--%>
                    <%--                                    width="7px" height="5px">--%>
                    <%--                                <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-7x5"></use>--%>
                    <%--                            </svg></button>--%>
                    <%--                                <div class="topbar-dropdown__body"><!-- .menu -->--%>
                    <%--                                    <ul class="menu menu--layout--topbar">--%>
                    <%--                                        <li><a href="${URL}assets/#">€ Euro</a></li>--%>
                    <%--                                        <li><a href="${URL}assets/#">£ Pound Sterling</a></li>--%>
                    <%--                                        <li><a href="${URL}assets/#">$ US Dollar</a></li>--%>
                    <%--                                        <li><a href="${URL}assets/#">₽ Russian Ruble</a></li>--%>
                    <%--                                    </ul><!-- .menu / end -->--%>
                    <%--                                </div>--%>
                    <%--                            </div>--%>
                    <%--                        </div>--%>
                    <%--                        <div class="topbar__item">--%>
                    <%--                            <div class="topbar-dropdown"><button class="topbar-dropdown__btn"--%>
                    <%--                                                                 type="button">Language: <span class="topbar__item-value">EN</span> <svg--%>
                    <%--                                    width="7px" height="5px">--%>
                    <%--                                <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-7x5"></use>--%>
                    <%--                            </svg></button>--%>
                    <%--                                <div class="topbar-dropdown__body"><!-- .menu -->--%>
                    <%--                                    <ul class="menu menu--layout--topbar menu--with-icons">--%>
                    <%--                                        <li><a href="${URL}assets/#">--%>
                    <%--                                            <div class="menu__icon"><img--%>
                    <%--                                                    srcset="images/languages/language-1.png, images/languages/language-1@2x.png 2x"--%>
                    <%--                                                    src="images/languages/language-1.png" alt=""></div>English--%>
                    <%--                                        </a></li>--%>
                    <%--                                        <li><a href="${URL}assets/#">--%>
                    <%--                                            <div class="menu__icon"><img--%>
                    <%--                                                    srcset="images/languages/language-2.png, images/languages/language-2@2x.png 2x"--%>
                    <%--                                                    src="images/languages/language-2.png" alt=""></div>French--%>
                    <%--                                        </a></li>--%>
                    <%--                                        <li><a href="${URL}assets/#">--%>
                    <%--                                            <div class="menu__icon"><img--%>
                    <%--                                                    srcset="images/languages/language-3.png, images/languages/language-3@2x.png 2x"--%>
                    <%--                                                    src="images/languages/language-3.png" alt=""></div>German--%>
                    <%--                                        </a></li>--%>
                    <%--                                        <li><a href="${URL}assets/#">--%>
                    <%--                                            <div class="menu__icon"><img--%>
                    <%--                                                    srcset="images/languages/language-4.png, images/languages/language-4@2x.png 2x"--%>
                    <%--                                                    src="images/languages/language-4.png" alt=""></div>Russian--%>
                    <%--                                        </a></li>--%>
                    <%--                                        <li><a href="${URL}assets/#">--%>
                    <%--                                            <div class="menu__icon"><img--%>
                    <%--                                                    srcset="images/languages/language-5.png, images/languages/language-5@2x.png 2x"--%>
                    <%--                                                    src="images/languages/language-5.png" alt=""></div>Italian--%>
                    <%--                                        </a></li>--%>
                    <%--                                    </ul><!-- .menu / end -->--%>
                    <%--                                </div>--%>
                    <%--                            </div>--%>
                    <%--                        </div>--%>
                </div>
            </div>
        </div><!-- .topbar / end -->
        <div class="site-header__middle container">
            <div class="site-header__logo"><a href="#">
                <img src="${URL}assets/images/careplus4-high-resolution-logo-transparent.png"
                     width="auto" height="36px"></a></div>
            <div class="site-header__search">
                <div class="search">
                    <form class="search__form" action="#"><input class="search__input" name="search" placeholder="Tìm kiếm ..."
                                                                 aria-label="Site search" type="text" autocomplete="off">
                        <button class="search__button" type="submit">
                            <svg width="20px" height="20px">
                                <use xlink:href="${URL}assets/images/sprite.svg#search-20"></use>
                            </svg></button>
                        <div class="search__border"></div>
                    </form>
                </div>
            </div>
            <div class="site-header__phone">
                <div class="site-header__phone-title">Hotline</div>
                <div class="site-header__phone-number">(800) 060-0730</div>
            </div>
        </div>
        <div class="site-header__nav-panel">
            <div class="nav-panel">
                <div class="nav-panel__container container">
                    <div class="nav-panel__row">
                        <div class="nav-panel__departments"><!-- .departments -->
                            <div class="departments departments--opened departments--fixed"
                                 data-departments-fixed-by=".block-slideshow">
                                <div class="departments__body">
                                    <div class="departments__links-wrapper">
                                        <ul class="departments__links">
                                            <li class="departments__item"><a href="${URL}assets/#">Power Tools <svg
                                                    class="departments__link-arrow" width="6px"
                                                    height="9px">
                                                <use
                                                        xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-right-6x9">
                                                </use>
                                            </svg></a>
                                                <div class="departments__megamenu departments__megamenu--xl">
                                                    <!-- .megamenu -->
                                                    <div class="megamenu megamenu--departments"
                                                         style="background-image: url('${URL}assets/images/megamenu/megamenu-1.jpg');">
                                                        <div class="row">
                                                            <div class="col-3">
                                                                <ul
                                                                        class="megamenu__links megamenu__links--level--0">
                                                                    <li
                                                                            class="megamenu__item megamenu__item--with-submenu">
                                                                        <a href="${URL}assets/#">Power Tools</a>
                                                                        <ul
                                                                                class="megamenu__links megamenu__links--level--1">
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Engravers</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Drills</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Wrenches</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Plumbing</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Wall Chaser</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Pneumatic Tools</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Milling Cutters</a>
                                                                            </li>
                                                                        </ul>
                                                                    </li>
                                                                    <li class="megamenu__item"><a
                                                                            href="${URL}assets/#">Workbenches</a></li>
                                                                    <li class="megamenu__item"><a
                                                                            href="${URL}assets/#">Presses</a></li>
                                                                    <li class="megamenu__item"><a href="${URL}assets/#">Spray
                                                                        Guns</a></li>
                                                                    <li class="megamenu__item"><a
                                                                            href="${URL}assets/#">Riveters</a></li>
                                                                </ul>
                                                            </div>
                                                            <div class="col-3">
                                                                <ul
                                                                        class="megamenu__links megamenu__links--level--0">
                                                                    <li
                                                                            class="megamenu__item megamenu__item--with-submenu">
                                                                        <a href="${URL}assets/#">Hand Tools</a>
                                                                        <ul
                                                                                class="megamenu__links megamenu__links--level--1">
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Screwdrivers</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Handsaws</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Knives</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Axes</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Multitools</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Paint Tools</a>
                                                                            </li>
                                                                        </ul>
                                                                    </li>
                                                                    <li
                                                                            class="megamenu__item megamenu__item--with-submenu">
                                                                        <a href="${URL}assets/#">Garden Equipment</a>
                                                                        <ul
                                                                                class="megamenu__links megamenu__links--level--1">
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Motor Pumps</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Chainsaws</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Electric Saws</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Brush Cutters</a>
                                                                            </li>
                                                                        </ul>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                            <div class="col-3">
                                                                <ul
                                                                        class="megamenu__links megamenu__links--level--0">
                                                                    <li
                                                                            class="megamenu__item megamenu__item--with-submenu">
                                                                        <a href="${URL}assets/#">Machine Tools</a>
                                                                        <ul
                                                                                class="megamenu__links megamenu__links--level--1">
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Thread Cutting</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Chip Blowers</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Sharpening
                                                                                Machines</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Pipe Cutters</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Slotting
                                                                                machines</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Lathes</a></li>
                                                                        </ul>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                            <div class="col-3">
                                                                <ul
                                                                        class="megamenu__links megamenu__links--level--0">
                                                                    <li
                                                                            class="megamenu__item megamenu__item--with-submenu">
                                                                        <a href="${URL}assets/#">Instruments</a>
                                                                        <ul
                                                                                class="megamenu__links megamenu__links--level--1">
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Welding
                                                                                Equipment</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Power Tools</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Hand Tools</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Measuring Tool</a>
                                                                            </li>
                                                                        </ul>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div><!-- .megamenu / end -->
                                                </div>
                                            </li>
                                            <li class="departments__item"><a href="${URL}assets/#">Hand Tools <svg
                                                    class="departments__link-arrow" width="6px"
                                                    height="9px">
                                                <use
                                                        xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-right-6x9">
                                                </use>
                                            </svg></a>
                                                <div class="departments__megamenu departments__megamenu--lg">
                                                    <!-- .megamenu -->
                                                    <div class="megamenu megamenu--departments"
                                                         style="background-image: url('${URL}assets/images/megamenu/megamenu-2.jpg');">
                                                        <div class="row">
                                                            <div class="col-4">
                                                                <ul
                                                                        class="megamenu__links megamenu__links--level--0">
                                                                    <li
                                                                            class="megamenu__item megamenu__item--with-submenu">
                                                                        <a href="${URL}assets/#">Hand Tools</a>
                                                                        <ul
                                                                                class="megamenu__links megamenu__links--level--1">
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Screwdrivers</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Handsaws</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Knives</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Axes</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Multitools</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Paint Tools</a>
                                                                            </li>
                                                                        </ul>
                                                                    </li>
                                                                    <li
                                                                            class="megamenu__item megamenu__item--with-submenu">
                                                                        <a href="${URL}assets/#">Garden Equipment</a>
                                                                        <ul
                                                                                class="megamenu__links megamenu__links--level--1">
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Motor Pumps</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Chainsaws</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Electric Saws</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Brush Cutters</a>
                                                                            </li>
                                                                        </ul>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                            <div class="col-4">
                                                                <ul
                                                                        class="megamenu__links megamenu__links--level--0">
                                                                    <li
                                                                            class="megamenu__item megamenu__item--with-submenu">
                                                                        <a href="${URL}assets/#">Machine Tools</a>
                                                                        <ul
                                                                                class="megamenu__links megamenu__links--level--1">
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Thread Cutting</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Chip Blowers</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Sharpening
                                                                                Machines</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Pipe Cutters</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Slotting
                                                                                machines</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Lathes</a></li>
                                                                        </ul>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                            <div class="col-4">
                                                                <ul
                                                                        class="megamenu__links megamenu__links--level--0">
                                                                    <li
                                                                            class="megamenu__item megamenu__item--with-submenu">
                                                                        <a href="${URL}assets/#">Instruments</a>
                                                                        <ul
                                                                                class="megamenu__links megamenu__links--level--1">
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Welding
                                                                                Equipment</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Power Tools</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Hand Tools</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Measuring Tool</a>
                                                                            </li>
                                                                        </ul>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div><!-- .megamenu / end -->
                                                </div>
                                            </li>
                                            <li class="departments__item"><a href="${URL}assets/#">Machine Tools <svg
                                                    class="departments__link-arrow" width="6px"
                                                    height="9px">
                                                <use
                                                        xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-right-6x9">
                                                </use>
                                            </svg></a>
                                                <div class="departments__megamenu departments__megamenu--nl">
                                                    <!-- .megamenu -->
                                                    <div class="megamenu megamenu--departments"
                                                         style="background-image: url('${URL}assets/images/megamenu/megamenu-3.jpg');">
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <ul
                                                                        class="megamenu__links megamenu__links--level--0">
                                                                    <li
                                                                            class="megamenu__item megamenu__item--with-submenu">
                                                                        <a href="${URL}assets/#">Hand Tools</a>
                                                                        <ul
                                                                                class="megamenu__links megamenu__links--level--1">
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Screwdrivers</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Handsaws</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Knives</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Axes</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Multitools</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Paint Tools</a>
                                                                            </li>
                                                                        </ul>
                                                                    </li>
                                                                    <li
                                                                            class="megamenu__item megamenu__item--with-submenu">
                                                                        <a href="${URL}assets/#">Garden Equipment</a>
                                                                        <ul
                                                                                class="megamenu__links megamenu__links--level--1">
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Motor Pumps</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Chainsaws</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Electric Saws</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Brush Cutters</a>
                                                                            </li>
                                                                        </ul>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                            <div class="col-6">
                                                                <ul
                                                                        class="megamenu__links megamenu__links--level--0">
                                                                    <li
                                                                            class="megamenu__item megamenu__item--with-submenu">
                                                                        <a href="${URL}assets/#">Instruments</a>
                                                                        <ul
                                                                                class="megamenu__links megamenu__links--level--1">
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Welding
                                                                                Equipment</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Power Tools</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Hand Tools</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Measuring Tool</a>
                                                                            </li>
                                                                        </ul>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div><!-- .megamenu / end -->
                                                </div>
                                            </li>
                                            <li class="departments__item"><a href="${URL}assets/#">Building Supplies <svg
                                                    class="departments__link-arrow" width="6px"
                                                    height="9px">
                                                <use
                                                        xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-right-6x9">
                                                </use>
                                            </svg></a>
                                                <div class="departments__megamenu departments__megamenu--sm">
                                                    <!-- .megamenu -->
                                                    <div class="megamenu megamenu--departments">
                                                        <div class="row">
                                                            <div class="col-12">
                                                                <ul
                                                                        class="megamenu__links megamenu__links--level--0">
                                                                    <li
                                                                            class="megamenu__item megamenu__item--with-submenu">
                                                                        <a href="${URL}assets/#">Hand Tools</a>
                                                                        <ul
                                                                                class="megamenu__links megamenu__links--level--1">
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Screwdrivers</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Handsaws</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Knives</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Axes</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Multitools</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Paint Tools</a>
                                                                            </li>
                                                                        </ul>
                                                                    </li>
                                                                    <li
                                                                            class="megamenu__item megamenu__item--with-submenu">
                                                                        <a href="${URL}assets/#">Garden Equipment</a>
                                                                        <ul
                                                                                class="megamenu__links megamenu__links--level--1">
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Motor Pumps</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Chainsaws</a></li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Electric Saws</a>
                                                                            </li>
                                                                            <li class="megamenu__item"><a
                                                                                    href="${URL}assets/#">Brush Cutters</a>
                                                                            </li>
                                                                        </ul>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div><!-- .megamenu / end -->
                                                </div>
                                            </li>
                                            <li class="departments__item departments__item--menu"><a
                                                    href="${URL}assets/#">Electrical <svg class="departments__link-arrow"
                                                                                          width="6px" height="9px">
                                                <use
                                                        xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-right-6x9">
                                                </use>
                                            </svg></a>
                                                <div class="departments__menu"><!-- .menu -->
                                                    <ul class="menu menu--layout--classic">
                                                        <li><a href="${URL}assets/#">Soldering Equipment <svg
                                                                class="menu__arrow" width="6px"
                                                                height="9px">
                                                            <use
                                                                    xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-right-6x9">
                                                            </use>
                                                        </svg></a>
                                                            <div class="menu__submenu"><!-- .menu -->
                                                                <ul class="menu menu--layout--classic">
                                                                    <li><a href="${URL}assets/#">Soldering Station</a></li>
                                                                    <li><a href="${URL}assets/#">Soldering Dryers</a></li>
                                                                    <li><a href="${URL}assets/#">Gas Soldering Iron</a></li>
                                                                    <li><a href="${URL}assets/#">Electric Soldering Iron</a>
                                                                    </li>
                                                                </ul><!-- .menu / end -->
                                                            </div>
                                                        </li>
                                                        <li><a href="${URL}assets/#">Light Bulbs</a></li>
                                                        <li><a href="${URL}assets/#">Batteries</a></li>
                                                        <li><a href="${URL}assets/#">Light Fixtures</a></li>
                                                        <li><a href="${URL}assets/#">Warm Floor</a></li>
                                                        <li><a href="${URL}assets/#">Generators</a></li>
                                                        <li><a href="${URL}assets/#">UPS</a></li>
                                                    </ul><!-- .menu / end -->
                                                </div>
                                            </li>
                                            <li class="departments__item"><a href="${URL}assets/#">Power Machinery</a></li>
                                            <li class="departments__item"><a href="${URL}assets/#">Measurement</a></li>
                                            <li class="departments__item"><a href="${URL}assets/#">Clothes & PPE</a></li>
                                            <li class="departments__item"><a href="${URL}assets/#">Plumbing</a></li>
                                            <li class="departments__item"><a href="${URL}assets/#">Storage & Organization</a>
                                            </li>
                                            <li class="departments__item"><a href="${URL}assets/#">Welding & Soldering</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div><button class="departments__button"><svg class="departments__button-icon"
                                                                               width="18px" height="14px">
                                <use xlink:href="${URL}assets/images/sprite.svg#menu-18x14"></use>
                            </svg> Shop By Category <svg class="departments__button-arrow" width="9px"
                                                         height="6px">
                                <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-9x6"></use>
                            </svg></button>
                            </div><!-- .departments / end -->
                        </div><!-- .nav-links -->
                        <div class="nav-panel__nav-links nav-links">
                            <ul class="nav-links__list">
                                <li class="nav-links__item nav-links__item--with-submenu"><a
                                        href="${URL}assets/index.html"><span>Home <svg class="nav-links__arrow" width="9px"
                                                                                       height="6px">
                                                        <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-9x6">
                                                        </use>
                                                    </svg></span></a>
                                    <div class="nav-links__menu"><!-- .menu -->
                                        <ul class="menu menu--layout--classic">
                                            <li><a href="${URL}assets/index.html">Home 1</a></li>
                                            <li><a href="${URL}assets/index-2.html">Home 2</a></li>
                                        </ul><!-- .menu / end -->
                                    </div>
                                </li>
                                <li class="nav-links__item nav-links__item--with-submenu"><a
                                        href="${URL}assets/#"><span>Megamenu <svg class="nav-links__arrow" width="9px"
                                                                                  height="6px">
                                                        <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-9x6">
                                                        </use>
                                                    </svg></span></a>
                                    <div class="nav-links__megamenu nav-links__megamenu--size--nl">
                                        <!-- .megamenu -->
                                        <div class="megamenu">
                                            <div class="row">
                                                <div class="col-6">
                                                    <ul class="megamenu__links megamenu__links--level--0">
                                                        <li class="megamenu__item megamenu__item--with-submenu">
                                                            <a href="${URL}assets/#">Power Tools</a>
                                                            <ul
                                                                    class="megamenu__links megamenu__links--level--1">
                                                                <li class="megamenu__item"><a
                                                                        href="${URL}assets/#">Engravers</a></li>
                                                                <li class="megamenu__item"><a
                                                                        href="${URL}assets/#">Wrenches</a></li>
                                                                <li class="megamenu__item"><a href="${URL}assets/#">Wall
                                                                    Chaser</a></li>
                                                                <li class="megamenu__item"><a href="${URL}assets/#">Pneumatic
                                                                    Tools</a></li>
                                                            </ul>
                                                        </li>
                                                        <li class="megamenu__item megamenu__item--with-submenu">
                                                            <a href="${URL}assets/#">Machine Tools</a>
                                                            <ul
                                                                    class="megamenu__links megamenu__links--level--1">
                                                                <li class="megamenu__item"><a href="${URL}assets/#">Thread
                                                                    Cutting</a></li>
                                                                <li class="megamenu__item"><a href="${URL}assets/#">Chip
                                                                    Blowers</a></li>
                                                                <li class="megamenu__item"><a
                                                                        href="${URL}assets/#">Sharpening Machines</a></li>
                                                                <li class="megamenu__item"><a href="${URL}assets/#">Pipe
                                                                    Cutters</a></li>
                                                                <li class="megamenu__item"><a href="${URL}assets/#">Slotting
                                                                    machines</a></li>
                                                                <li class="megamenu__item"><a
                                                                        href="${URL}assets/#">Lathes</a></li>
                                                            </ul>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="col-6">
                                                    <ul class="megamenu__links megamenu__links--level--0">
                                                        <li class="megamenu__item megamenu__item--with-submenu">
                                                            <a href="${URL}assets/#">Hand Tools</a>
                                                            <ul
                                                                    class="megamenu__links megamenu__links--level--1">
                                                                <li class="megamenu__item"><a
                                                                        href="${URL}assets/#">Screwdrivers</a></li>
                                                                <li class="megamenu__item"><a
                                                                        href="${URL}assets/#">Handsaws</a></li>
                                                                <li class="megamenu__item"><a
                                                                        href="${URL}assets/#">Knives</a></li>
                                                                <li class="megamenu__item"><a href="${URL}assets/#">Axes</a>
                                                                </li>
                                                                <li class="megamenu__item"><a
                                                                        href="${URL}assets/#">Multitools</a></li>
                                                                <li class="megamenu__item"><a href="${URL}assets/#">Paint
                                                                    Tools</a></li>
                                                            </ul>
                                                        </li>
                                                        <li class="megamenu__item megamenu__item--with-submenu">
                                                            <a href="${URL}assets/#">Garden Equipment</a>
                                                            <ul
                                                                    class="megamenu__links megamenu__links--level--1">
                                                                <li class="megamenu__item"><a href="${URL}assets/#">Motor
                                                                    Pumps</a></li>
                                                                <li class="megamenu__item"><a
                                                                        href="${URL}assets/#">Chainsaws</a></li>
                                                                <li class="megamenu__item"><a href="${URL}assets/#">Electric
                                                                    Saws</a></li>
                                                                <li class="megamenu__item"><a href="${URL}assets/#">Brush
                                                                    Cutters</a></li>
                                                            </ul>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div><!-- .megamenu / end -->
                                    </div>
                                </li>
                                <li class="nav-links__item nav-links__item--with-submenu"><a
                                        href="${URL}assets/shop-grid-3-columns-sidebar.html"><span>Shop <svg
                                        class="nav-links__arrow" width="9px" height="6px">
                                                        <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-9x6">
                                                        </use>
                                                    </svg></span></a>
                                    <div class="nav-links__menu"><!-- .menu -->
                                        <ul class="menu menu--layout--classic">
                                            <li><a href="${URL}assets/shop-grid-3-columns-sidebar.html">Shop Grid <svg
                                                    class="menu__arrow" width="6px" height="9px">
                                                <use
                                                        xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-right-6x9">
                                                </use>
                                            </svg></a>
                                                <div class="menu__submenu"><!-- .menu -->
                                                    <ul class="menu menu--layout--classic">
                                                        <li><a href="${URL}assets/shop-grid-3-columns-sidebar.html">3 Columns
                                                            Sidebar</a></li>
                                                        <li><a href="${URL}assets/shop-grid-4-columns-full.html">4 Columns
                                                            Full</a></li>
                                                        <li><a href="${URL}assets/shop-grid-5-columns-full.html">5 Columns
                                                            Full</a></li>
                                                    </ul><!-- .menu / end -->
                                                </div>
                                            </li>
                                            <li><a href="${URL}assets/shop-list.html">Shop List</a></li>
                                            <li><a href="${URL}assets/shop-right-sidebar.html">Shop Right Sidebar</a></li>
                                            <li><a href="${URL}assets/product.html">Product <svg class="menu__arrow"
                                                                                                 width="6px" height="9px">
                                                <use
                                                        xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-right-6x9">
                                                </use>
                                            </svg></a>
                                                <div class="menu__submenu"><!-- .menu -->
                                                    <ul class="menu menu--layout--classic">
                                                        <li><a href="${URL}assets/product.html">Product</a></li>
                                                        <li><a href="${URL}assets/product-alt.html">Product Alt</a></li>
                                                        <li><a href="${URL}assets/product-sidebar.html">Product Sidebar</a>
                                                        </li>
                                                    </ul><!-- .menu / end -->
                                                </div>
                                            </li>
                                            <li><a href="${URL}assets/cart.html">Cart</a></li>
                                            <li><a href="${URL}assets/checkout.html">Checkout</a></li>
                                            <li><a href="${URL}assets/wishlist.html">Wishlist</a></li>
                                            <li><a href="${URL}assets/compare.html">Compare</a></li>
                                            <li><a href="${URL}assets/account.html">My Account</a></li>
                                            <li><a href="${URL}assets/track-order.html">Track Order</a></li>
                                        </ul><!-- .menu / end -->
                                    </div>
                                </li>
                                <li class="nav-links__item nav-links__item--with-submenu"><a
                                        href="${URL}assets/blog-classic.html"><span>Blog <svg class="nav-links__arrow"
                                                                                              width="9px" height="6px">
                                                        <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-9x6">
                                                        </use>
                                                    </svg></span></a>
                                    <div class="nav-links__menu"><!-- .menu -->
                                        <ul class="menu menu--layout--classic">
                                            <li><a href="${URL}assets/blog-classic.html">Blog Classic</a></li>
                                            <li><a href="${URL}assets/blog-grid.html">Blog Grid</a></li>
                                            <li><a href="${URL}assets/blog-list.html">Blog List</a></li>
                                            <li><a href="${URL}assets/blog-left-sidebar.html">Blog Left Sidebar</a></li>
                                            <li><a href="${URL}assets/post.html">Post Page</a></li>
                                            <li><a href="${URL}assets/post-without-sidebar.html">Post Without Sidebar</a>
                                            </li>
                                        </ul><!-- .menu / end -->
                                    </div>
                                </li>
                                <li class="nav-links__item nav-links__item--with-submenu"><a
                                        href="${URL}assets/#"><span>Pages <svg class="nav-links__arrow" width="9px"
                                                                               height="6px">
                                                        <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-9x6">
                                                        </use>
                                                    </svg></span></a>
                                    <div class="nav-links__menu"><!-- .menu -->
                                        <ul class="menu menu--layout--classic">
                                            <li><a href="${URL}assets/about-us.html">About Us</a></li>
                                            <li><a href="${URL}assets/contact-us.html">Contact Us</a></li>
                                            <li><a href="${URL}assets/contact-us-alt.html">Contact Us Alt</a></li>
                                            <li><a href="${URL}assets/404.html">404</a></li>
                                            <li><a href="${URL}assets/terms-and-conditions.html">Terms And Conditions</a>
                                            </li>
                                            <li><a href="${URL}assets/faq.html">FAQ</a></li>
                                            <li><a href="${URL}assets/components.html">Components</a></li>
                                            <li><a href="${URL}assets/typography.html">Typography</a></li>
                                        </ul><!-- .menu / end -->
                                    </div>
                                </li>
                                <li class="nav-links__item"><a href="${URL}assets/contact-us.html"><span>Contact
                                                    Us</span></a></li>
                                <li class="nav-links__item"><a
                                        href="${URL}assets/https://themeforest.net/user/kos9/portfolio"><span>Buy
                                                    Theme</span></a></li>
                            </ul>
                        </div><!-- .nav-links / end -->
                        <div class="nav-panel__indicators">
                            <div class="indicator"><a href="${URL}assets/wishlist.html" class="indicator__button"><span
                                    class="indicator__area"><svg width="20px" height="20px">
                                                    <use xlink:href="${URL}assets/images/sprite.svg#heart-20"></use>
                                                </svg> <span class="indicator__value">0</span></span></a></div>
                            <div class="indicator indicator--trigger--click"><a href="${URL}assets/cart.html"
                                                                                class="indicator__button"><span class="indicator__area"><svg width="20px"
                                                                                                                                             height="20px">
                                                    <use xlink:href="${URL}assets/images/sprite.svg#cart-20"></use>
                                                </svg> <span class="indicator__value">3</span></span></a>
                                <div class="indicator__dropdown"><!-- .dropcart -->
                                    <div class="dropcart">
                                        <div class="dropcart__products-list">
                                            <div class="dropcart__product">
                                                <div class="dropcart__product-image"><a href="${URL}assets/product.html"><img
                                                        src="images/products/product-1.jpg" alt=""></a>
                                                </div>
                                                <div class="dropcart__product-info">
                                                    <div class="dropcart__product-name"><a
                                                            href="${URL}assets/product.html">Electric Planer Brandix
                                                        KL370090G 300 Watts</a></div>
                                                    <ul class="dropcart__product-options">
                                                        <li>Color: Yellow</li>
                                                        <li>Material: Aluminium</li>
                                                    </ul>
                                                    <div class="dropcart__product-meta"><span
                                                            class="dropcart__product-quantity">2</span> x <span
                                                            class="dropcart__product-price">$699.00</span></div>
                                                </div><button type="button"
                                                              class="dropcart__product-remove btn btn-light btn-sm btn-svg-icon"><svg
                                                    width="10px" height="10px">
                                                <use xlink:href="${URL}assets/images/sprite.svg#cross-10"></use>
                                            </svg></button>
                                            </div>
                                            <div class="dropcart__product">
                                                <div class="dropcart__product-image"><a href="${URL}assets/product.html"><img
                                                        src="images/products/product-2.jpg" alt=""></a>
                                                </div>
                                                <div class="dropcart__product-info">
                                                    <div class="dropcart__product-name"><a
                                                            href="${URL}assets/product.html">Undefined Tool IRadix DPS3000SY
                                                        2700 watts</a></div>
                                                    <div class="dropcart__product-meta"><span
                                                            class="dropcart__product-quantity">1</span> x <span
                                                            class="dropcart__product-price">$849.00</span></div>
                                                </div><button type="button"
                                                              class="dropcart__product-remove btn btn-light btn-sm btn-svg-icon"><svg
                                                    width="10px" height="10px">
                                                <use xlink:href="${URL}assets/images/sprite.svg#cross-10"></use>
                                            </svg></button>
                                            </div>
                                            <div class="dropcart__product">
                                                <div class="dropcart__product-image"><a href="${URL}assets/product.html"><img
                                                        src="images/products/product-5.jpg" alt=""></a>
                                                </div>
                                                <div class="dropcart__product-info">
                                                    <div class="dropcart__product-name"><a
                                                            href="${URL}assets/product.html">Brandix Router Power Tool
                                                        2017ERXPK</a></div>
                                                    <ul class="dropcart__product-options">
                                                        <li>Color: True Red</li>
                                                    </ul>
                                                    <div class="dropcart__product-meta"><span
                                                            class="dropcart__product-quantity">3</span> x <span
                                                            class="dropcart__product-price">$1,210.00</span>
                                                    </div>
                                                </div><button type="button"
                                                              class="dropcart__product-remove btn btn-light btn-sm btn-svg-icon"><svg
                                                    width="10px" height="10px">
                                                <use xlink:href="${URL}assets/images/sprite.svg#cross-10"></use>
                                            </svg></button>
                                            </div>
                                        </div>
                                        <div class="dropcart__totals">
                                            <table>
                                                <tr>
                                                    <th>Subtotal</th>
                                                    <td>$5,877.00</td>
                                                </tr>
                                                <tr>
                                                    <th>Shipping</th>
                                                    <td>$25.00</td>
                                                </tr>
                                                <tr>
                                                    <th>Tax</th>
                                                    <td>$0.00</td>
                                                </tr>
                                                <tr>
                                                    <th>Total</th>
                                                    <td>$5,902.00</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="dropcart__buttons"><a class="btn btn-secondary"
                                                                          href="${URL}assets/cart.html">View Cart</a> <a class="btn btn-primary"
                                                                                                                         href="${URL}assets/checkout.html">Checkout</a></div>
                                    </div><!-- .dropcart / end -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>