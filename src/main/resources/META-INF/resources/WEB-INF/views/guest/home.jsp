<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:url value="/" var="URL"></c:url>

<div class="site__body"><!-- .block-slideshow -->
    <div class="block-slideshow block-slideshow--layout--with-departments block">
        <div class="container">
            <div class="row">
                <div class="col-12 col-lg-9 offset-lg-3">
                    <div class="block-slideshow__body">
                        <div class="owl-carousel"><a class="block-slideshow__slide" href="#">
                            <div class="block-slideshow__slide-image block-slideshow__slide-image--desktop"
                                 style="background-image: url('${URL}assets/images/slides/slide-1.jpg')"></div>
                            <div class="block-slideshow__slide-image block-slideshow__slide-image--mobile"
                                 style="background-image: url('${URL}assets/images/slides/slide-1-mobile.jpg')"></div>
                            <div class="block-slideshow__slide-content">
                                <div class="block-slideshow__slide-title">Big choice of<br>Plumbing products
                                </div>
                                <div class="block-slideshow__slide-text">Lorem ipsum dolor sit amet,
                                    consectetur adipiscing elit.<br>Etiam pharetra laoreet dui quis
                                    molestie.</div>
                                <div class="block-slideshow__slide-button"><span
                                        class="btn btn-primary btn-lg">Shop Now</span></div>
                            </div>
                        </a><a class="block-slideshow__slide" href="#">
                            <div class="block-slideshow__slide-image block-slideshow__slide-image--desktop"
                                 style="background-image: url('${URL}assets/images/slides/slide-2.jpg')"></div>
                            <div class="block-slideshow__slide-image block-slideshow__slide-image--mobile"
                                 style="background-image: url('${URL}assets/images/slides/slide-2-mobile.jpg')"></div>
                            <div class="block-slideshow__slide-content">
                                <div class="block-slideshow__slide-title">Screwdrivers<br>Professional Tools
                                </div>
                                <div class="block-slideshow__slide-text">Lorem ipsum dolor sit amet,
                                    consectetur adipiscing elit.<br>Etiam pharetra laoreet dui quis
                                    molestie.</div>
                                <div class="block-slideshow__slide-button"><span
                                        class="btn btn-primary btn-lg">Shop Now</span></div>
                            </div>
                        </a><a class="block-slideshow__slide" href="#">
                            <div class="block-slideshow__slide-image block-slideshow__slide-image--desktop"
                                 style="background-image: url('${URL}assets/images/slides/slide-3.jpg')"></div>
                            <div class="block-slideshow__slide-image block-slideshow__slide-image--mobile"
                                 style="background-image: url('${URL}assets/images/slides/slide-3-mobile.jpg')"></div>
                            <div class="block-slideshow__slide-content">
                                <div class="block-slideshow__slide-title">One more<br>Unique header</div>
                                <div class="block-slideshow__slide-text">Lorem ipsum dolor sit amet,
                                    consectetur adipiscing elit.<br>Etiam pharetra laoreet dui quis
                                    molestie.</div>
                                <div class="block-slideshow__slide-button"><span
                                        class="btn btn-primary btn-lg">Shop Now</span></div>
                            </div>
                        </a></div>
                    </div>
                </div>
            </div>
        </div>
    </div><!-- .block-slideshow / end --><!-- .block-features -->
    <div class="block block-features block-features--layout--classic">
        <div class="container">
            <div class="block-features__list">
                <div class="block-features__item">
                    <div class="block-features__icon"><svg width="48px" height="48px">
                        <use xlink:href="images/sprite.svg#fi-free-delivery-48"></use>
                    </svg></div>
                    <div class="block-features__content">
                        <div class="block-features__title">Free Shipping</div>
                        <div class="block-features__subtitle">For orders from $50</div>
                    </div>
                </div>
                <div class="block-features__divider"></div>
                <div class="block-features__item">
                    <div class="block-features__icon"><svg width="48px" height="48px">
                        <use xlink:href="images/sprite.svg#fi-24-hours-48"></use>
                    </svg></div>
                    <div class="block-features__content">
                        <div class="block-features__title">Support 24/7</div>
                        <div class="block-features__subtitle">Call us anytime</div>
                    </div>
                </div>
                <div class="block-features__divider"></div>
                <div class="block-features__item">
                    <div class="block-features__icon"><svg width="48px" height="48px">
                        <use xlink:href="images/sprite.svg#fi-payment-security-48"></use>
                    </svg></div>
                    <div class="block-features__content">
                        <div class="block-features__title">100% Safety</div>
                        <div class="block-features__subtitle">Only secure payments</div>
                    </div>
                </div>
                <div class="block-features__divider"></div>
                <div class="block-features__item">
                    <div class="block-features__icon"><svg width="48px" height="48px">
                        <use xlink:href="images/sprite.svg#fi-tag-48"></use>
                    </svg></div>
                    <div class="block-features__content">
                        <div class="block-features__title">Hot Offers</div>
                        <div class="block-features__subtitle">Discounts up to 90%</div>
                    </div>
                </div>
            </div>
        </div>
    </div><!-- .block-features / end --><!-- .block-products-carousel -->


    <div class="block block-product-columns d-lg-block d-none">
        <div class="container">
            <div class="row">
                <div class="col-4">
                    <div class="block-header">
                        <h3 class="block-header__title">Top Rated Products</h3>
                        <div class="block-header__divider"></div>
                    </div>
                    <div class="block-product-columns__column">
                        <div class="block-product-columns__item">
                            <div class="product-card product-card--layout--horizontal"><button
                                    class="product-card__quickview" type="button"><svg width="16px"
                                                                                       height="16px">
                                <use xlink:href="images/sprite.svg#quickview-16"></use>
                            </svg> <span class="fake-svg-icon"></span></button>
                                <div class="product-card__badges-list">
                                    <div class="product-card__badge product-card__badge--new">New</div>
                                </div>
                                <div class="product-card__image"><a href="product.html"><img
                                        src="images/products/product-1.jpg" alt=""></a></div>
                                <div class="product-card__info">
                                    <div class="product-card__name"><a href="product.html">Electric Planer
                                        Brandix KL370090G 300 Watts</a></div>
                                    <div class="product-card__rating">
                                        <div class="rating">
                                            <div class="rating__body"><svg
                                                    class="rating__star rating__star--active" width="13px"
                                                    height="12px">
                                                <g class="rating__fill">
                                                    <use xlink:href="images/sprite.svg#star-normal"></use>
                                                </g>
                                                <g class="rating__stroke">
                                                    <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                    </use>
                                                </g>
                                            </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star" width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div class="rating__star rating__star--only-edge">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-card__rating-legend">9 Reviews</div>
                                    </div>
                                    <ul class="product-card__features-list">
                                        <li>Speed: 750 RPM</li>
                                        <li>Power Source: Cordless-Electric</li>
                                        <li>Battery Cell Type: Lithium</li>
                                        <li>Voltage: 20 Volts</li>
                                        <li>Battery Capacity: 2 Ah</li>
                                    </ul>
                                </div>
                                <div class="product-card__actions">
                                    <div class="product-card__availability">Availability: <span
                                            class="text-success">In Stock</span></div>
                                    <div class="product-card__prices">$749.00</div>
                                    <div class="product-card__buttons"><button
                                            class="btn btn-primary product-card__addtocart" type="button">Add To
                                        Cart</button> <button
                                            class="btn btn-secondary product-card__addtocart product-card__addtocart--list"
                                            type="button">Add To Cart</button> <button
                                            class="btn btn-light btn-svg-icon btn-svg-icon--fake-svg product-card__wishlist"
                                            type="button"><svg width="16px" height="16px">
                                        <use xlink:href="images/sprite.svg#wishlist-16"></use>
                                    </svg> <span
                                            class="fake-svg-icon fake-svg-icon--wishlist-16"></span></button>
                                        <button
                                                class="btn btn-light btn-svg-icon btn-svg-icon--fake-svg product-card__compare"
                                                type="button"><svg width="16px" height="16px">
                                            <use xlink:href="images/sprite.svg#compare-16"></use>
                                        </svg> <span
                                                class="fake-svg-icon fake-svg-icon--compare-16"></span></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="block-product-columns__item">
                            <div class="product-card product-card--layout--horizontal"><button
                                    class="product-card__quickview" type="button"><svg width="16px"
                                                                                       height="16px">
                                <use xlink:href="images/sprite.svg#quickview-16"></use>
                            </svg> <span class="fake-svg-icon"></span></button>
                                <div class="product-card__badges-list">
                                    <div class="product-card__badge product-card__badge--hot">Hot</div>
                                </div>
                                <div class="product-card__image"><a href="product.html"><img
                                        src="images/products/product-2.jpg" alt=""></a></div>
                                <div class="product-card__info">
                                    <div class="product-card__name"><a href="product.html">Undefined Tool IRadix
                                        DPS3000SY 2700 Watts</a></div>
                                    <div class="product-card__rating">
                                        <div class="rating">
                                            <div class="rating__body"><svg
                                                    class="rating__star rating__star--active" width="13px"
                                                    height="12px">
                                                <g class="rating__fill">
                                                    <use xlink:href="images/sprite.svg#star-normal"></use>
                                                </g>
                                                <g class="rating__stroke">
                                                    <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                    </use>
                                                </g>
                                            </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-card__rating-legend">11 Reviews</div>
                                    </div>
                                    <ul class="product-card__features-list">
                                        <li>Speed: 750 RPM</li>
                                        <li>Power Source: Cordless-Electric</li>
                                        <li>Battery Cell Type: Lithium</li>
                                        <li>Voltage: 20 Volts</li>
                                        <li>Battery Capacity: 2 Ah</li>
                                    </ul>
                                </div>
                                <div class="product-card__actions">
                                    <div class="product-card__availability">Availability: <span
                                            class="text-success">In Stock</span></div>
                                    <div class="product-card__prices">$1,019.00</div>
                                    <div class="product-card__buttons"><button
                                            class="btn btn-primary product-card__addtocart" type="button">Add To
                                        Cart</button> <button
                                            class="btn btn-secondary product-card__addtocart product-card__addtocart--list"
                                            type="button">Add To Cart</button> <button
                                            class="btn btn-light btn-svg-icon btn-svg-icon--fake-svg product-card__wishlist"
                                            type="button"><svg width="16px" height="16px">
                                        <use xlink:href="images/sprite.svg#wishlist-16"></use>
                                    </svg> <span
                                            class="fake-svg-icon fake-svg-icon--wishlist-16"></span></button>
                                        <button
                                                class="btn btn-light btn-svg-icon btn-svg-icon--fake-svg product-card__compare"
                                                type="button"><svg width="16px" height="16px">
                                            <use xlink:href="images/sprite.svg#compare-16"></use>
                                        </svg> <span
                                                class="fake-svg-icon fake-svg-icon--compare-16"></span></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="block-product-columns__item">
                            <div class="product-card product-card--layout--horizontal"><button
                                    class="product-card__quickview" type="button"><svg width="16px"
                                                                                       height="16px">
                                <use xlink:href="images/sprite.svg#quickview-16"></use>
                            </svg> <span class="fake-svg-icon"></span></button>
                                <div class="product-card__image"><a href="product.html"><img
                                        src="images/products/product-3.jpg" alt=""></a></div>
                                <div class="product-card__info">
                                    <div class="product-card__name"><a href="product.html">Drill Screwdriver
                                        Brandix ALX7054 200 Watts</a></div>
                                    <div class="product-card__rating">
                                        <div class="rating">
                                            <div class="rating__body"><svg
                                                    class="rating__star rating__star--active" width="13px"
                                                    height="12px">
                                                <g class="rating__fill">
                                                    <use xlink:href="images/sprite.svg#star-normal"></use>
                                                </g>
                                                <g class="rating__stroke">
                                                    <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                    </use>
                                                </g>
                                            </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star" width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div class="rating__star rating__star--only-edge">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-card__rating-legend">9 Reviews</div>
                                    </div>
                                    <ul class="product-card__features-list">
                                        <li>Speed: 750 RPM</li>
                                        <li>Power Source: Cordless-Electric</li>
                                        <li>Battery Cell Type: Lithium</li>
                                        <li>Voltage: 20 Volts</li>
                                        <li>Battery Capacity: 2 Ah</li>
                                    </ul>
                                </div>
                                <div class="product-card__actions">
                                    <div class="product-card__availability">Availability: <span
                                            class="text-success">In Stock</span></div>
                                    <div class="product-card__prices">$850.00</div>
                                    <div class="product-card__buttons"><button
                                            class="btn btn-primary product-card__addtocart" type="button">Add To
                                        Cart</button> <button
                                            class="btn btn-secondary product-card__addtocart product-card__addtocart--list"
                                            type="button">Add To Cart</button> <button
                                            class="btn btn-light btn-svg-icon btn-svg-icon--fake-svg product-card__wishlist"
                                            type="button"><svg width="16px" height="16px">
                                        <use xlink:href="images/sprite.svg#wishlist-16"></use>
                                    </svg> <span
                                            class="fake-svg-icon fake-svg-icon--wishlist-16"></span></button>
                                        <button
                                                class="btn btn-light btn-svg-icon btn-svg-icon--fake-svg product-card__compare"
                                                type="button"><svg width="16px" height="16px">
                                            <use xlink:href="images/sprite.svg#compare-16"></use>
                                        </svg> <span
                                                class="fake-svg-icon fake-svg-icon--compare-16"></span></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-4">
                    <div class="block-header">
                        <h3 class="block-header__title">Special Offers</h3>
                        <div class="block-header__divider"></div>
                    </div>
                    <div class="block-product-columns__column">
                        <div class="block-product-columns__item">
                            <div class="product-card product-card--layout--horizontal"><button
                                    class="product-card__quickview" type="button"><svg width="16px"
                                                                                       height="16px">
                                <use xlink:href="images/sprite.svg#quickview-16"></use>
                            </svg> <span class="fake-svg-icon"></span></button>
                                <div class="product-card__badges-list">
                                    <div class="product-card__badge product-card__badge--sale">Sale</div>
                                </div>
                                <div class="product-card__image"><a href="product.html"><img
                                        src="images/products/product-4.jpg" alt=""></a></div>
                                <div class="product-card__info">
                                    <div class="product-card__name"><a href="product.html">Drill Series 3
                                        Brandix KSR4590PQS 1500 Watts</a></div>
                                    <div class="product-card__rating">
                                        <div class="rating">
                                            <div class="rating__body"><svg
                                                    class="rating__star rating__star--active" width="13px"
                                                    height="12px">
                                                <g class="rating__fill">
                                                    <use xlink:href="images/sprite.svg#star-normal"></use>
                                                </g>
                                                <g class="rating__stroke">
                                                    <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                    </use>
                                                </g>
                                            </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star" width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div class="rating__star rating__star--only-edge">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star" width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div class="rating__star rating__star--only-edge">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-card__rating-legend">7 Reviews</div>
                                    </div>
                                    <ul class="product-card__features-list">
                                        <li>Speed: 750 RPM</li>
                                        <li>Power Source: Cordless-Electric</li>
                                        <li>Battery Cell Type: Lithium</li>
                                        <li>Voltage: 20 Volts</li>
                                        <li>Battery Capacity: 2 Ah</li>
                                    </ul>
                                </div>
                                <div class="product-card__actions">
                                    <div class="product-card__availability">Availability: <span
                                            class="text-success">In Stock</span></div>
                                    <div class="product-card__prices"><span
                                            class="product-card__new-price">$949.00</span> <span
                                            class="product-card__old-price">$1189.00</span></div>
                                    <div class="product-card__buttons"><button
                                            class="btn btn-primary product-card__addtocart" type="button">Add To
                                        Cart</button> <button
                                            class="btn btn-secondary product-card__addtocart product-card__addtocart--list"
                                            type="button">Add To Cart</button> <button
                                            class="btn btn-light btn-svg-icon btn-svg-icon--fake-svg product-card__wishlist"
                                            type="button"><svg width="16px" height="16px">
                                        <use xlink:href="images/sprite.svg#wishlist-16"></use>
                                    </svg> <span
                                            class="fake-svg-icon fake-svg-icon--wishlist-16"></span></button>
                                        <button
                                                class="btn btn-light btn-svg-icon btn-svg-icon--fake-svg product-card__compare"
                                                type="button"><svg width="16px" height="16px">
                                            <use xlink:href="images/sprite.svg#compare-16"></use>
                                        </svg> <span
                                                class="fake-svg-icon fake-svg-icon--compare-16"></span></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="block-product-columns__item">
                            <div class="product-card product-card--layout--horizontal"><button
                                    class="product-card__quickview" type="button"><svg width="16px"
                                                                                       height="16px">
                                <use xlink:href="images/sprite.svg#quickview-16"></use>
                            </svg> <span class="fake-svg-icon"></span></button>
                                <div class="product-card__image"><a href="product.html"><img
                                        src="images/products/product-5.jpg" alt=""></a></div>
                                <div class="product-card__info">
                                    <div class="product-card__name"><a href="product.html">Brandix Router Power
                                        Tool 2017ERXPK</a></div>
                                    <div class="product-card__rating">
                                        <div class="rating">
                                            <div class="rating__body"><svg
                                                    class="rating__star rating__star--active" width="13px"
                                                    height="12px">
                                                <g class="rating__fill">
                                                    <use xlink:href="images/sprite.svg#star-normal"></use>
                                                </g>
                                                <g class="rating__stroke">
                                                    <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                    </use>
                                                </g>
                                            </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star" width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div class="rating__star rating__star--only-edge">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-card__rating-legend">9 Reviews</div>
                                    </div>
                                    <ul class="product-card__features-list">
                                        <li>Speed: 750 RPM</li>
                                        <li>Power Source: Cordless-Electric</li>
                                        <li>Battery Cell Type: Lithium</li>
                                        <li>Voltage: 20 Volts</li>
                                        <li>Battery Capacity: 2 Ah</li>
                                    </ul>
                                </div>
                                <div class="product-card__actions">
                                    <div class="product-card__availability">Availability: <span
                                            class="text-success">In Stock</span></div>
                                    <div class="product-card__prices">$1,700.00</div>
                                    <div class="product-card__buttons"><button
                                            class="btn btn-primary product-card__addtocart" type="button">Add To
                                        Cart</button> <button
                                            class="btn btn-secondary product-card__addtocart product-card__addtocart--list"
                                            type="button">Add To Cart</button> <button
                                            class="btn btn-light btn-svg-icon btn-svg-icon--fake-svg product-card__wishlist"
                                            type="button"><svg width="16px" height="16px">
                                        <use xlink:href="images/sprite.svg#wishlist-16"></use>
                                    </svg> <span
                                            class="fake-svg-icon fake-svg-icon--wishlist-16"></span></button>
                                        <button
                                                class="btn btn-light btn-svg-icon btn-svg-icon--fake-svg product-card__compare"
                                                type="button"><svg width="16px" height="16px">
                                            <use xlink:href="images/sprite.svg#compare-16"></use>
                                        </svg> <span
                                                class="fake-svg-icon fake-svg-icon--compare-16"></span></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="block-product-columns__item">
                            <div class="product-card product-card--layout--horizontal"><button
                                    class="product-card__quickview" type="button"><svg width="16px"
                                                                                       height="16px">
                                <use xlink:href="images/sprite.svg#quickview-16"></use>
                            </svg> <span class="fake-svg-icon"></span></button>
                                <div class="product-card__image"><a href="product.html"><img
                                        src="images/products/product-6.jpg" alt=""></a></div>
                                <div class="product-card__info">
                                    <div class="product-card__name"><a href="product.html">Brandix Drilling
                                        Machine DM2019KW4 4kW</a></div>
                                    <div class="product-card__rating">
                                        <div class="rating">
                                            <div class="rating__body"><svg
                                                    class="rating__star rating__star--active" width="13px"
                                                    height="12px">
                                                <g class="rating__fill">
                                                    <use xlink:href="images/sprite.svg#star-normal"></use>
                                                </g>
                                                <g class="rating__stroke">
                                                    <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                    </use>
                                                </g>
                                            </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star" width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div class="rating__star rating__star--only-edge">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star" width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div class="rating__star rating__star--only-edge">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-card__rating-legend">7 Reviews</div>
                                    </div>
                                    <ul class="product-card__features-list">
                                        <li>Speed: 750 RPM</li>
                                        <li>Power Source: Cordless-Electric</li>
                                        <li>Battery Cell Type: Lithium</li>
                                        <li>Voltage: 20 Volts</li>
                                        <li>Battery Capacity: 2 Ah</li>
                                    </ul>
                                </div>
                                <div class="product-card__actions">
                                    <div class="product-card__availability">Availability: <span
                                            class="text-success">In Stock</span></div>
                                    <div class="product-card__prices">$3,199.00</div>
                                    <div class="product-card__buttons"><button
                                            class="btn btn-primary product-card__addtocart" type="button">Add To
                                        Cart</button> <button
                                            class="btn btn-secondary product-card__addtocart product-card__addtocart--list"
                                            type="button">Add To Cart</button> <button
                                            class="btn btn-light btn-svg-icon btn-svg-icon--fake-svg product-card__wishlist"
                                            type="button"><svg width="16px" height="16px">
                                        <use xlink:href="images/sprite.svg#wishlist-16"></use>
                                    </svg> <span
                                            class="fake-svg-icon fake-svg-icon--wishlist-16"></span></button>
                                        <button
                                                class="btn btn-light btn-svg-icon btn-svg-icon--fake-svg product-card__compare"
                                                type="button"><svg width="16px" height="16px">
                                            <use xlink:href="images/sprite.svg#compare-16"></use>
                                        </svg> <span
                                                class="fake-svg-icon fake-svg-icon--compare-16"></span></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-4">
                    <div class="block-header">
                        <h3 class="block-header__title">Bestsellers</h3>
                        <div class="block-header__divider"></div>
                    </div>
                    <div class="block-product-columns__column">
                        <div class="block-product-columns__item">
                            <div class="product-card product-card--layout--horizontal"><button
                                    class="product-card__quickview" type="button"><svg width="16px"
                                                                                       height="16px">
                                <use xlink:href="images/sprite.svg#quickview-16"></use>
                            </svg> <span class="fake-svg-icon"></span></button>
                                <div class="product-card__image"><a href="product.html"><img
                                        src="images/products/product-7.jpg" alt=""></a></div>
                                <div class="product-card__info">
                                    <div class="product-card__name"><a href="product.html">Brandix Pliers</a>
                                    </div>
                                    <div class="product-card__rating">
                                        <div class="rating">
                                            <div class="rating__body"><svg
                                                    class="rating__star rating__star--active" width="13px"
                                                    height="12px">
                                                <g class="rating__fill">
                                                    <use xlink:href="images/sprite.svg#star-normal"></use>
                                                </g>
                                                <g class="rating__stroke">
                                                    <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                    </use>
                                                </g>
                                            </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star" width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div class="rating__star rating__star--only-edge">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star" width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div class="rating__star rating__star--only-edge">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star" width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div class="rating__star rating__star--only-edge">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-card__rating-legend">4 Reviews</div>
                                    </div>
                                    <ul class="product-card__features-list">
                                        <li>Speed: 750 RPM</li>
                                        <li>Power Source: Cordless-Electric</li>
                                        <li>Battery Cell Type: Lithium</li>
                                        <li>Voltage: 20 Volts</li>
                                        <li>Battery Capacity: 2 Ah</li>
                                    </ul>
                                </div>
                                <div class="product-card__actions">
                                    <div class="product-card__availability">Availability: <span
                                            class="text-success">In Stock</span></div>
                                    <div class="product-card__prices">$24.00</div>
                                    <div class="product-card__buttons"><button
                                            class="btn btn-primary product-card__addtocart" type="button">Add To
                                        Cart</button> <button
                                            class="btn btn-secondary product-card__addtocart product-card__addtocart--list"
                                            type="button">Add To Cart</button> <button
                                            class="btn btn-light btn-svg-icon btn-svg-icon--fake-svg product-card__wishlist"
                                            type="button"><svg width="16px" height="16px">
                                        <use xlink:href="images/sprite.svg#wishlist-16"></use>
                                    </svg> <span
                                            class="fake-svg-icon fake-svg-icon--wishlist-16"></span></button>
                                        <button
                                                class="btn btn-light btn-svg-icon btn-svg-icon--fake-svg product-card__compare"
                                                type="button"><svg width="16px" height="16px">
                                            <use xlink:href="images/sprite.svg#compare-16"></use>
                                        </svg> <span
                                                class="fake-svg-icon fake-svg-icon--compare-16"></span></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="block-product-columns__item">
                            <div class="product-card product-card--layout--horizontal"><button
                                    class="product-card__quickview" type="button"><svg width="16px"
                                                                                       height="16px">
                                <use xlink:href="images/sprite.svg#quickview-16"></use>
                            </svg> <span class="fake-svg-icon"></span></button>
                                <div class="product-card__image"><a href="product.html"><img
                                        src="images/products/product-8.jpg" alt=""></a></div>
                                <div class="product-card__info">
                                    <div class="product-card__name"><a href="product.html">Water Hose 40cm</a>
                                    </div>
                                    <div class="product-card__rating">
                                        <div class="rating">
                                            <div class="rating__body"><svg
                                                    class="rating__star rating__star--active" width="13px"
                                                    height="12px">
                                                <g class="rating__fill">
                                                    <use xlink:href="images/sprite.svg#star-normal"></use>
                                                </g>
                                                <g class="rating__stroke">
                                                    <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                    </use>
                                                </g>
                                            </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star" width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div class="rating__star rating__star--only-edge">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star" width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div class="rating__star rating__star--only-edge">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star" width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div class="rating__star rating__star--only-edge">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-card__rating-legend">4 Reviews</div>
                                    </div>
                                    <ul class="product-card__features-list">
                                        <li>Speed: 750 RPM</li>
                                        <li>Power Source: Cordless-Electric</li>
                                        <li>Battery Cell Type: Lithium</li>
                                        <li>Voltage: 20 Volts</li>
                                        <li>Battery Capacity: 2 Ah</li>
                                    </ul>
                                </div>
                                <div class="product-card__actions">
                                    <div class="product-card__availability">Availability: <span
                                            class="text-success">In Stock</span></div>
                                    <div class="product-card__prices">$15.00</div>
                                    <div class="product-card__buttons"><button
                                            class="btn btn-primary product-card__addtocart" type="button">Add To
                                        Cart</button> <button
                                            class="btn btn-secondary product-card__addtocart product-card__addtocart--list"
                                            type="button">Add To Cart</button> <button
                                            class="btn btn-light btn-svg-icon btn-svg-icon--fake-svg product-card__wishlist"
                                            type="button"><svg width="16px" height="16px">
                                        <use xlink:href="images/sprite.svg#wishlist-16"></use>
                                    </svg> <span
                                            class="fake-svg-icon fake-svg-icon--wishlist-16"></span></button>
                                        <button
                                                class="btn btn-light btn-svg-icon btn-svg-icon--fake-svg product-card__compare"
                                                type="button"><svg width="16px" height="16px">
                                            <use xlink:href="images/sprite.svg#compare-16"></use>
                                        </svg> <span
                                                class="fake-svg-icon fake-svg-icon--compare-16"></span></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="block-product-columns__item">
                            <div class="product-card product-card--layout--horizontal"><button
                                    class="product-card__quickview" type="button"><svg width="16px"
                                                                                       height="16px">
                                <use xlink:href="images/sprite.svg#quickview-16"></use>
                            </svg> <span class="fake-svg-icon"></span></button>
                                <div class="product-card__image"><a href="product.html"><img
                                        src="images/products/product-9.jpg" alt=""></a></div>
                                <div class="product-card__info">
                                    <div class="product-card__name"><a href="product.html">Spanner Wrench</a>
                                    </div>
                                    <div class="product-card__rating">
                                        <div class="rating">
                                            <div class="rating__body"><svg
                                                    class="rating__star rating__star--active" width="13px"
                                                    height="12px">
                                                <g class="rating__fill">
                                                    <use xlink:href="images/sprite.svg#star-normal"></use>
                                                </g>
                                                <g class="rating__stroke">
                                                    <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                    </use>
                                                </g>
                                            </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star rating__star--active"
                                                           width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div
                                                        class="rating__star rating__star--only-edge rating__star--active">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div><svg class="rating__star" width="13px" height="12px">
                                                    <g class="rating__fill">
                                                        <use xlink:href="images/sprite.svg#star-normal"></use>
                                                    </g>
                                                    <g class="rating__stroke">
                                                        <use xlink:href="images/sprite.svg#star-normal-stroke">
                                                        </use>
                                                    </g>
                                                </svg>
                                                <div class="rating__star rating__star--only-edge">
                                                    <div class="rating__fill">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                    <div class="rating__stroke">
                                                        <div class="fake-svg-icon"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-card__rating-legend">9 Reviews</div>
                                    </div>
                                    <ul class="product-card__features-list">
                                        <li>Speed: 750 RPM</li>
                                        <li>Power Source: Cordless-Electric</li>
                                        <li>Battery Cell Type: Lithium</li>
                                        <li>Voltage: 20 Volts</li>
                                        <li>Battery Capacity: 2 Ah</li>
                                    </ul>
                                </div>
                                <div class="product-card__actions">
                                    <div class="product-card__availability">Availability: <span
                                            class="text-success">In Stock</span></div>
                                    <div class="product-card__prices">$19.00</div>
                                    <div class="product-card__buttons"><button
                                            class="btn btn-primary product-card__addtocart" type="button">Add To
                                        Cart</button> <button
                                            class="btn btn-secondary product-card__addtocart product-card__addtocart--list"
                                            type="button">Add To Cart</button> <button
                                            class="btn btn-light btn-svg-icon btn-svg-icon--fake-svg product-card__wishlist"
                                            type="button"><svg width="16px" height="16px">
                                        <use xlink:href="images/sprite.svg#wishlist-16"></use>
                                    </svg> <span
                                            class="fake-svg-icon fake-svg-icon--wishlist-16"></span></button>
                                        <button
                                                class="btn btn-light btn-svg-icon btn-svg-icon--fake-svg product-card__compare"
                                                type="button"><svg width="16px" height="16px">
                                            <use xlink:href="images/sprite.svg#compare-16"></use>
                                        </svg> <span
                                                class="fake-svg-icon fake-svg-icon--compare-16"></span></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div><!-- .block-product-columns / end -->
</div><!-- site__body / end --><!-- site__footer -->