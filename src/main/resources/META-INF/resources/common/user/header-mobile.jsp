<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:url value="/" var="URL"></c:url>

<header class="site__header d-lg-none">
    <div class="mobile-header mobile-header--sticky mobile-header--stuck">
        <div class="mobile-header__panel">
            <div class="container">
                <div class="mobile-header__body"><button class="mobile-header__menu-button"><svg width="18px"
                                                                                                 height="14px">
                    <use xlink:href="${URL}assets/images/sprite.svg#menu-18x14"></use>
                </svg></button> <a class="mobile-header__logo" href="${URL}assets/index.html"><svg
                        xmlns="http://www.w3.org/2000/svg" width="120px" height="20px">
                    <path d="M118.5,20h-1.1c-0.6,0-1.2-0.4-1.4-1l-1.5-4h-6.1l-1.5,4c-0.2,0.6-0.8,1-1.4,1h-1.1c-1,0-1.8-1-1.4-2l1.1-3
                                 l1.5-4l3.6-10c0.2-0.6,0.8-1,1.4-1h1.6c0.6,0,1.2,0.4,1.4,1l3.6,10l1.5,4l1.1,3C120.3,19,119.5,20,118.5,20z M111.5,6.6l-1.6,4.4
                                 h3.2L111.5,6.6z M99.5,20h-1.4c-0.4,0-0.7-0.2-0.9-0.5L94,14l-2,3.5v1c0,0.8-0.7,1.5-1.5,1.5h-1c-0.8,0-1.5-0.7-1.5-1.5v-17
                                 C88,0.7,88.7,0,89.5,0h1C91.3,0,92,0.7,92,1.5v8L94,6l3.2-5.5C97.4,0.2,97.7,0,98.1,0h1.4c1.2,0,1.9,1.3,1.3,2.3L96.3,10l4.5,7.8
                                 C101.4,18.8,100.7,20,99.5,20z M80.3,11.8L80,12.3v6.2c0,0.8-0.7,1.5-1.5,1.5h-1c-0.8,0-1.5-0.7-1.5-1.5v-6.2l-0.3-0.5l-5.5-9.5
                                 c-0.6-1,0.2-2.3,1.3-2.3h1.4c0.4,0,0.7,0.2,0.9,0.5L76,4.3l2,3.5l2-3.5l2.2-3.8C82.4,0.2,82.7,0,83.1,0h1.4c1.2,0,1.9,1.3,1.3,2.3
                                 L80.3,11.8z M60,20c-5.5,0-10-4.5-10-10S54.5,0,60,0s10,4.5,10,10S65.5,20,60,20z M60,4c-3.3,0-6,2.7-6,6s2.7,6,6,6s6-2.7,6-6
                                 S63.3,4,60,4z M47.8,17.8c0.6,1-0.2,2.3-1.3,2.3h-2L41,14h-4v4.5c0,0.8-0.7,1.5-1.5,1.5h-1c-0.8,0-1.5-0.7-1.5-1.5v-17
                                 C33,0.7,33.7,0,34.5,0H41c0.3,0,0.7,0,1,0.1c3.4,0.5,6,3.4,6,6.9c0,2.4-1.2,4.5-3.1,5.8L47.8,17.8z M42,4.2C41.7,4.1,41.3,4,41,4h-3
                                 c-0.6,0-1,0.4-1,1v4c0,0.6,0.4,1,1,1h3c0.3,0,0.7-0.1,1-0.2c0.3-0.1,0.6-0.3,0.9-0.5C43.6,8.8,44,7.9,44,7C44,5.7,43.2,4.6,42,4.2z
                                  M29.5,4H25v14.5c0,0.8-0.7,1.5-1.5,1.5h-1c-0.8,0-1.5-0.7-1.5-1.5V4h-4.5C15.7,4,15,3.3,15,2.5v-1C15,0.7,15.7,0,16.5,0h13
                                 C30.3,0,31,0.7,31,1.5v1C31,3.3,30.3,4,29.5,4z M6.5,20c-2.8,0-5.5-1.7-6.4-4c-0.4-1,0.3-2,1.3-2h1c0.5,0,0.9,0.3,1.2,0.7
                                 c0.2,0.3,0.4,0.6,0.8,0.8C4.9,15.8,5.8,16,6.5,16c1.5,0,2.8-0.9,2.8-2c0-0.7-0.5-1.3-1.2-1.6C7.4,12,7,11,7.4,10.3l0.4-0.9
                                 c0.4-0.7,1.2-1,1.8-0.6c0.6,0.3,1.2,0.7,1.6,1.2c1,1.1,1.7,2.5,1.7,4C13,17.3,10.1,20,6.5,20z M11.6,6h-1c-0.5,0-0.9-0.3-1.2-0.7
                                 C9.2,4.9,8.9,4.7,8.6,4.5C8.1,4.2,7.2,4,6.5,4C5,4,3.7,4.9,3.7,6c0,0.7,0.5,1.3,1.2,1.6C5.6,8,6,9,5.6,9.7l-0.4,0.9
                                 c-0.4,0.7-1.2,1-1.8,0.6c-0.6-0.3-1.2-0.7-1.6-1.2C0.6,8.9,0,7.5,0,6c0-3.3,2.9-6,6.5-6c2.8,0,5.5,1.7,6.4,4C13.3,4.9,12.6,6,11.6,6
                                 z"></path>
                </svg></a>
                    <div class="mobile-header__search">
                        <form class="mobile-header__search-form" action="#"><input
                                class="mobile-header__search-input" name="search"
                                placeholder="Search over 10,000 products" aria-label="Site search" type="text"
                                autocomplete="off"> <button
                                class="mobile-header__search-button mobile-header__search-button--submit"
                                type="submit"><svg width="20px" height="20px">
                            <use xlink:href="${URL}assets/images/sprite.svg#search-20"></use>
                        </svg></button> <button
                                class="mobile-header__search-button mobile-header__search-button--close"
                                type="button"><svg width="20px" height="20px">
                            <use xlink:href="${URL}assets/images/sprite.svg#cross-20"></use>
                        </svg></button>
                            <div class="mobile-header__search-body"></div>
                        </form>
                    </div>
                    <div class="mobile-header__indicators">
                        <div class="indicator indicator--mobile-search indicator--mobile d-sm-none"><button
                                class="indicator__button"><span class="indicator__area"><svg width="20px"
                                                                                             height="20px">
                                                <use xlink:href="${URL}assets/images/sprite.svg#search-20"></use>
                                            </svg></span></button></div>
                        <div class="indicator indicator--mobile d-sm-flex d-none"><a href="${URL}assets/wishlist.html"
                                                                                     class="indicator__button"><span class="indicator__area"><svg width="20px"
                                                                                                                                                  height="20px">
                                                <use xlink:href="${URL}assets/images/sprite.svg#heart-20"></use>
                                            </svg> <span class="indicator__value">0</span></span></a></div>
                        <div class="indicator indicator--mobile"><a href="${URL}assets/cart.html"
                                                                    class="indicator__button"><span class="indicator__area"><svg width="20px"
                                                                                                                                 height="20px">
                                                <use xlink:href="${URL}assets/images/sprite.svg#cart-20"></use>
                                            </svg> <span class="indicator__value">3</span></span></a></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>