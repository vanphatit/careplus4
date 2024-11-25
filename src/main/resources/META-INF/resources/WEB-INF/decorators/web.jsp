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

<body><!-- quickview-modal -->
<div id="quickview-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl">
        <div class="modal-content"></div>
    </div>
</div><!-- quickview-modal / end --><!-- mobilemenu -->
<div class="mobilemenu">
    <div class="mobilemenu__backdrop"></div>
    <div class="mobilemenu__body">
        <div class="mobilemenu__header">
            <div class="mobilemenu__title">Menu</div><button type="button" class="mobilemenu__close"><svg
                width="20px" height="20px">
            <use xlink:href="${URL}assets/images/sprite.svg#cross-20"></use>
        </svg></button>
        </div>
        <div class="mobilemenu__content">
            <ul class="mobile-links mobile-links--level--0" data-collapse
                data-collapse-opened-class="mobile-links__item--open">
                <li class="mobile-links__item" data-collapse-item>
                    <div class="mobile-links__item-title">
                        <a href="${URL}assets/index.html" class="mobile-links__item-link">Home</a> <button class="mobile-links__item-toggle"
                            type="button" data-collapse-trigger><svg class="mobile-links__item-arrow" width="12px"
                                                                                                                                                       height="7px">
                        <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-12x7"></use>
                    </svg></button></div>
                    <div class="mobile-links__item-sub-links" data-collapse-content>
                        <ul class="mobile-links mobile-links--level--1">
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/index.html"
                                                                         class="mobile-links__item-link">Home 1</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/index-2.html"
                                                                         class="mobile-links__item-link">Home 2</a></div>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="mobile-links__item" data-collapse-item>
                    <div class="mobile-links__item-title"><a href="${URL}assets/#" class="mobile-links__item-link">Categories</a>
                        <button class="mobile-links__item-toggle" type="button" data-collapse-trigger><svg
                                class="mobile-links__item-arrow" width="12px" height="7px">
                            <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-12x7"></use>
                        </svg></button></div>
                    <div class="mobile-links__item-sub-links" data-collapse-content>
                        <ul class="mobile-links mobile-links--level--1">
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/#"
                                                                         class="mobile-links__item-link">Power Tools</a> <button
                                        class="mobile-links__item-toggle" type="button" data-collapse-trigger><svg
                                        class="mobile-links__item-arrow" width="12px" height="7px">
                                    <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-12x7"></use>
                                </svg></button></div>
                                <div class="mobile-links__item-sub-links" data-collapse-content>
                                    <ul class="mobile-links mobile-links--level--2">
                                        <li class="mobile-links__item" data-collapse-item>
                                            <div class="mobile-links__item-title"><a href="${URL}assets/#"
                                                                                     class="mobile-links__item-link">Engravers</a></div>
                                        </li>
                                        <li class="mobile-links__item" data-collapse-item>
                                            <div class="mobile-links__item-title"><a href="${URL}assets/#"
                                                                                     class="mobile-links__item-link">Wrenches</a></div>
                                        </li>
                                        <li class="mobile-links__item" data-collapse-item>
                                            <div class="mobile-links__item-title"><a href="${URL}assets/#"
                                                                                     class="mobile-links__item-link">Wall Chaser</a></div>
                                        </li>
                                        <li class="mobile-links__item" data-collapse-item>
                                            <div class="mobile-links__item-title"><a href="${URL}assets/#"
                                                                                     class="mobile-links__item-link">Pneumatic Tools</a></div>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/#"
                                                                         class="mobile-links__item-link">Machine Tools</a> <button
                                        class="mobile-links__item-toggle" type="button" data-collapse-trigger><svg
                                        class="mobile-links__item-arrow" width="12px" height="7px">
                                    <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-12x7"></use>
                                </svg></button></div>
                                <div class="mobile-links__item-sub-links" data-collapse-content>
                                    <ul class="mobile-links mobile-links--level--2">
                                        <li class="mobile-links__item" data-collapse-item>
                                            <div class="mobile-links__item-title"><a href="${URL}assets/#"
                                                                                     class="mobile-links__item-link">Thread Cutting</a></div>
                                        </li>
                                        <li class="mobile-links__item" data-collapse-item>
                                            <div class="mobile-links__item-title"><a href="${URL}assets/#"
                                                                                     class="mobile-links__item-link">Chip Blowers</a></div>
                                        </li>
                                        <li class="mobile-links__item" data-collapse-item>
                                            <div class="mobile-links__item-title"><a href="${URL}assets/#"
                                                                                     class="mobile-links__item-link">Sharpening Machines</a></div>
                                        </li>
                                        <li class="mobile-links__item" data-collapse-item>
                                            <div class="mobile-links__item-title"><a href="${URL}assets/#"
                                                                                     class="mobile-links__item-link">Pipe Cutters</a></div>
                                        </li>
                                        <li class="mobile-links__item" data-collapse-item>
                                            <div class="mobile-links__item-title"><a href="${URL}assets/#"
                                                                                     class="mobile-links__item-link">Slotting machines</a></div>
                                        </li>
                                        <li class="mobile-links__item" data-collapse-item>
                                            <div class="mobile-links__item-title"><a href="${URL}assets/#"
                                                                                     class="mobile-links__item-link">Lathes</a></div>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="mobile-links__item" data-collapse-item>
                    <div class="mobile-links__item-title"><a href="${URL}assets/shop-grid-3-columns-sidebar.html"
                                                             class="mobile-links__item-link">Shop</a> <button class="mobile-links__item-toggle"
                                                                                                              type="button" data-collapse-trigger><svg class="mobile-links__item-arrow" width="12px"
                                                                                                                                                       height="7px">
                        <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-12x7"></use>
                    </svg></button></div>
                    <div class="mobile-links__item-sub-links" data-collapse-content>
                        <ul class="mobile-links mobile-links--level--1">
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/shop-grid-3-columns-sidebar.html"
                                                                         class="mobile-links__item-link">Shop Grid</a> <button
                                        class="mobile-links__item-toggle" type="button" data-collapse-trigger><svg
                                        class="mobile-links__item-arrow" width="12px" height="7px">
                                    <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-12x7"></use>
                                </svg></button></div>
                                <div class="mobile-links__item-sub-links" data-collapse-content>
                                    <ul class="mobile-links mobile-links--level--2">
                                        <li class="mobile-links__item" data-collapse-item>
                                            <div class="mobile-links__item-title"><a
                                                    href="${URL}assets/shop-grid-3-columns-sidebar.html"
                                                    class="mobile-links__item-link">3 Columns Sidebar</a></div>
                                        </li>
                                        <li class="mobile-links__item" data-collapse-item>
                                            <div class="mobile-links__item-title"><a
                                                    href="${URL}assets/shop-grid-4-columns-full.html"
                                                    class="mobile-links__item-link">4 Columns Full</a></div>
                                        </li>
                                        <li class="mobile-links__item" data-collapse-item>
                                            <div class="mobile-links__item-title"><a
                                                    href="${URL}assets/shop-grid-5-columns-full.html"
                                                    class="mobile-links__item-link">5 Columns Full</a></div>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/shop-list.html"
                                                                         class="mobile-links__item-link">Shop List</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/shop-right-sidebar.html"
                                                                         class="mobile-links__item-link">Shop Right Sidebar</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/product.html"
                                                                         class="mobile-links__item-link">Product</a> <button
                                        class="mobile-links__item-toggle" type="button" data-collapse-trigger><svg
                                        class="mobile-links__item-arrow" width="12px" height="7px">
                                    <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-12x7"></use>
                                </svg></button></div>
                                <div class="mobile-links__item-sub-links" data-collapse-content>
                                    <ul class="mobile-links mobile-links--level--2">
                                        <li class="mobile-links__item" data-collapse-item>
                                            <div class="mobile-links__item-title"><a href="${URL}assets/product.html"
                                                                                     class="mobile-links__item-link">Product</a></div>
                                        </li>
                                        <li class="mobile-links__item" data-collapse-item>
                                            <div class="mobile-links__item-title"><a href="${URL}assets/product-alt.html"
                                                                                     class="mobile-links__item-link">Product Alt</a></div>
                                        </li>
                                        <li class="mobile-links__item" data-collapse-item>
                                            <div class="mobile-links__item-title"><a href="${URL}assets/product-sidebar.html"
                                                                                     class="mobile-links__item-link">Product Sidebar</a></div>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/cart.html"
                                                                         class="mobile-links__item-link">Cart</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/checkout.html"
                                                                         class="mobile-links__item-link">Checkout</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/wishlist.html"
                                                                         class="mobile-links__item-link">Wishlist</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/compare.html"
                                                                         class="mobile-links__item-link">Compare</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/account.html"
                                                                         class="mobile-links__item-link">My Account</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/track-order.html"
                                                                         class="mobile-links__item-link">Track Order</a></div>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="mobile-links__item" data-collapse-item>
                    <div class="mobile-links__item-title"><a href="${URL}assets/blog-classic.html"
                                                             class="mobile-links__item-link">Blog</a> <button class="mobile-links__item-toggle"
                                                                                                              type="button" data-collapse-trigger><svg class="mobile-links__item-arrow" width="12px"
                                                                                                                                                       height="7px">
                        <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-12x7"></use>
                    </svg></button></div>
                    <div class="mobile-links__item-sub-links" data-collapse-content>
                        <ul class="mobile-links mobile-links--level--1">
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/blog-classic.html"
                                                                         class="mobile-links__item-link">Blog Classic</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/blog-grid.html"
                                                                         class="mobile-links__item-link">Blog Grid</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/blog-list.html"
                                                                         class="mobile-links__item-link">Blog List</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/blog-left-sidebar.html"
                                                                         class="mobile-links__item-link">Blog Left Sidebar</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/post.html"
                                                                         class="mobile-links__item-link">Post Page</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/post-without-sidebar.html"
                                                                         class="mobile-links__item-link">Post Without Sidebar</a></div>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="mobile-links__item" data-collapse-item>
                    <div class="mobile-links__item-title"><a href="${URL}assets/#" class="mobile-links__item-link">Pages</a>
                        <button class="mobile-links__item-toggle" type="button" data-collapse-trigger><svg
                                class="mobile-links__item-arrow" width="12px" height="7px">
                            <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-12x7"></use>
                        </svg></button></div>
                    <div class="mobile-links__item-sub-links" data-collapse-content>
                        <ul class="mobile-links mobile-links--level--1">
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/about-us.html"
                                                                         class="mobile-links__item-link">About Us</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/contact-us.html"
                                                                         class="mobile-links__item-link">Contact Us</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/contact-us-alt.html"
                                                                         class="mobile-links__item-link">Contact Us Alt</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/404.html"
                                                                         class="mobile-links__item-link">404</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/terms-and-conditions.html"
                                                                         class="mobile-links__item-link">Terms And Conditions</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/faq.html"
                                                                         class="mobile-links__item-link">FAQ</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/components.html"
                                                                         class="mobile-links__item-link">Components</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/typography.html"
                                                                         class="mobile-links__item-link">Typography</a></div>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="mobile-links__item" data-collapse-item>
                    <div class="mobile-links__item-title"><a data-collapse-trigger
                                                             class="mobile-links__item-link">Currency</a> <button class="mobile-links__item-toggle"
                                                                                                                  type="button" data-collapse-trigger><svg class="mobile-links__item-arrow" width="12px"
                                                                                                                                                           height="7px">
                        <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-12x7"></use>
                    </svg></button></div>
                    <div class="mobile-links__item-sub-links" data-collapse-content>
                        <ul class="mobile-links mobile-links--level--1">
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/#" class="mobile-links__item-link">€
                                    Euro</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/#" class="mobile-links__item-link">£
                                    Pound Sterling</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/#" class="mobile-links__item-link">$
                                    US Dollar</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/#" class="mobile-links__item-link">₽
                                    Russian Ruble</a></div>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="mobile-links__item" data-collapse-item>
                    <div class="mobile-links__item-title"><a data-collapse-trigger
                                                             class="mobile-links__item-link">Language</a> <button class="mobile-links__item-toggle"
                                                                                                                  type="button" data-collapse-trigger><svg class="mobile-links__item-arrow" width="12px"
                                                                                                                                                           height="7px">
                        <use xlink:href="${URL}assets/images/sprite.svg#arrow-rounded-down-12x7"></use>
                    </svg></button></div>
                    <div class="mobile-links__item-sub-links" data-collapse-content>
                        <ul class="mobile-links mobile-links--level--1">
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/#"
                                                                         class="mobile-links__item-link">English</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/#"
                                                                         class="mobile-links__item-link">French</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/#"
                                                                         class="mobile-links__item-link">German</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/#"
                                                                         class="mobile-links__item-link">Russian</a></div>
                            </li>
                            <li class="mobile-links__item" data-collapse-item>
                                <div class="mobile-links__item-title"><a href="${URL}assets/#"
                                                                         class="mobile-links__item-link">Italian</a></div>
                            </li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div><!-- mobilemenu / end --><!-- site -->
<div class="site"><!-- mobile site__header -->
    <%@include file="/common/user/header-mobile.jsp"%><!-- mobile site__header / end --><!-- desktop site__header -->
    <%@include file="/common/user/header-desktop.jsp"%><!-- desktop site__header / end --><!-- site__body -->

    <!-- BEGIN CONTENT -->
    <div class="site__body">
        <sitemesh:write property='body' />
    </div>
    <!-- END CONTENT -->

    <%@include file="/common/user/footer.jsp"%> <!-- site__footer / end -->
</div><!-- site / end -->
</body>

</html>