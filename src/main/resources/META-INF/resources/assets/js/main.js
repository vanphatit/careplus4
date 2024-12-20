(function ($) {
    "use strict";

    let passiveSupported = false;

    try {
        const options = Object.defineProperty({}, 'passive', {
            get: function() {
                passiveSupported = true;
            }
        });

        window.addEventListener('test', null, options);
    } catch(err) {}


    /*
    // initialize custom numbers
    */
    // $(function () {
    //     $('.input-number').customNumber();
    // });


    /*
    // topbar dropdown
    */
    $(function() {
        $('.topbar-dropdown__btn').on('click', function() {
            $(this).closest('.topbar-dropdown').toggleClass('topbar-dropdown--opened');
        });

        $(document).on('click', function (event) {
            $('.topbar-dropdown')
                .not($(event.target).closest('.topbar-dropdown'))
                .removeClass('topbar-dropdown--opened');
        });
    });


    /*
    // dropcart, drop search
    */
    $(function() {
        $('.indicator--trigger--click .indicator__button').on('click', function(event) {
            event.preventDefault();

            const dropdown = $(this).closest('.indicator');

            if (dropdown.is('.indicator--opened')) {
                dropdown.removeClass('indicator--opened');
            } else {
                dropdown.addClass('indicator--opened');
                dropdown.find('.drop-search__input').focus();
            }
        });

        $('.indicator--trigger--click .drop-search__input').on('keydown', function(event) {
            if (event.which === 27) {
                $(this).closest('.indicator').removeClass('indicator--opened');
            }
        });

        $(document).on('click', function (event) {
            $('.indicator')
                .not($(event.target).closest('.indicator'))
                .removeClass('indicator--opened');
        });
    });


    /*
    // product tabs
    */
    $(function () {
        $('.product-tabs').each(function (i, element) {
            $('.product-tabs__list', element).on('click', '.product-tabs__item', function (event) {
                event.preventDefault();

                const tab = $(this);
                const content = $('.product-tabs__pane' + $(this).attr('href'), element);

                if (content.length) {
                    $('.product-tabs__item').removeClass('product-tabs__item--active');
                    tab.addClass('product-tabs__item--active');

                    $('.product-tabs__pane').removeClass('product-tabs__pane--active');
                    content.addClass('product-tabs__pane--active');
                }
            });

            const currentTab = $('.product-tabs__item--active', element);
            const firstTab = $('.product-tabs__item:first', element);

            if (currentTab.length) {
                currentTab.trigger('click');
            } else {
                firstTab.trigger('click');
            }
        });
    });


    /*
    // megamenu position
    */
    $(function() {
        $('.nav-panel__nav-links .nav-links__item').on('mouseenter', function() {
            const megamenu = $(this).find('.nav-links__megamenu');

            if (megamenu.length) {
                const container = megamenu.offsetParent();
                const containerWidth = container.width();
                const megamenuWidth = megamenu.width();
                const itemPosition = $(this).position().left;
                const megamenuPosition = Math.round(Math.min(itemPosition, containerWidth - megamenuWidth));

                megamenu.css('left', megamenuPosition + 'px');
            }
        });
    });


    /*
    // mobile search
    */
    $(function() {
        const mobileSearch = $('.mobile-header__search');

        if (mobileSearch.length) {
            $('.indicator--mobile-search .indicator__button').on('click', function() {
                if (mobileSearch.is('.mobile-header__search--opened')) {
                    mobileSearch.removeClass('mobile-header__search--opened');
                } else {
                    mobileSearch.addClass('mobile-header__search--opened');
                    mobileSearch.find('input')[0].focus();
                }
            });

            mobileSearch.find('.mobile-header__search-button--close').on('click', function() {
                mobileSearch.removeClass('mobile-header__search--opened');
            });

            document.addEventListener('click', function(event) {
                if (!$(event.target).closest('.indicator--mobile-search, .mobile-header__search').length) {
                    mobileSearch.removeClass('mobile-header__search--opened');
                }
            }, true);
        }
    });


    /*
    // departments, sticky header
    */
    $(function() {
        /*
        // departments
        */
        const CDepartments = function(element) {
            const self = this;

            element.data('departmentsInstance', self);

            this.element = element;
            this.body = this.element.find('.departments__body');
            this.button = this.element.find('.departments__button');
            this.mode = this.element.is('.departments--fixed') ? 'fixed' : 'normal';
            this.fixedBy = $(this.element.data('departments-fixed-by'));
            this.fixedHeight = 0;

            if (this.mode === 'fixed' && this.fixedBy.length) {
                this.fixedHeight = this.fixedBy.offset().top - this.body.offset().top + this.fixedBy.outerHeight();
                this.body.css('height', this.fixedHeight + 'px');
            }

            this.button.on('click', function(event) {
                self.clickOnButton(event);
            });

            $('.departments__links-wrapper', this.element).on('transitionend', function (event) {
                if (event.originalEvent.propertyName === 'height') {
                    $(this).css('height', '');
                    $(this).closest('.departments').removeClass('departments--transition');
                }
            });

            document.addEventListener('click', function(event) {
                self.element.not($(event.target).closest('.departments')).each(function() {
                    if (self.element.is('.departments--opened')) {
                        self.element.data('departmentsInstance').close();
                    }
                });
            }, true);
        };
        CDepartments.prototype.clickOnButton = function(event) {
            event.preventDefault();

            if (this.element.is('.departments--opened')) {
                this.close();
            } else {
                this.open();
            }
        };
        CDepartments.prototype.setMode = function(mode) {
            this.mode = mode;

            if (this.mode === 'normal') {
                this.element.removeClass('departments--fixed');
                this.element.removeClass('departments--opened');
                this.body.css('height', 'auto');
            }
            if (this.mode === 'fixed') {
                this.element.addClass('departments--fixed');
                this.element.addClass('departments--opened');
                this.body.css('height', this.fixedHeight + 'px');
            }
        };
        CDepartments.prototype.close = function() {
            if (this.element.is('.departments--fixed')) {
                return;
            }

            const content = this.element.find('.departments__links-wrapper');
            const startHeight = content.height();

            content.css('height', startHeight + 'px');
            this.element
                .addClass('departments--transition')
                .removeClass('departments--opened');

            content.css('height', '');
        };
        CDepartments.prototype.open = function() {
            const content = this.element.find('.departments__links-wrapper');
            const startHeight = content.height();

            this.element
                .addClass('departments--transition')
                .addClass('departments--opened');

            const endHeight = content.height();

            content.css('height', startHeight + 'px');
            content.css('height', endHeight + 'px');
        };

        const departments = new CDepartments($('.departments'));


        /*
        // sticky header
        */
        const nav = $('.nav-panel--sticky');

        if (nav.length) {
            const departmentsMode = departments.mode;
            const defaultPosition = nav.offset().top;
            let stuck = false;

            window.addEventListener('scroll', function() {
                if (window.pageYOffset > defaultPosition) {
                    if (!stuck) {
                        nav.addClass('nav-panel--stuck');
                        stuck = true;

                        if (departmentsMode === 'fixed') {
                            departments.setMode('normal');
                        }
                    }
                } else {
                    if (stuck) {
                        nav.removeClass('nav-panel--stuck');
                        stuck = false;

                        if (departmentsMode === 'fixed') {
                            departments.setMode('fixed');
                        }
                    }
                }
            }, passiveSupported ? {passive: true} : false);
        }
    });


    /*
    // block slideshow
    */
    $(function() {
        $('.block-slideshow .owl-carousel').owlCarousel({
            items: 1,
            nav: false,
            dots: true,
            loop: true
        });
    });


    /*
    // block brands carousel
    */
    $(function() {
        $('.block-brands__slider .owl-carousel').owlCarousel({
            nav: false,
            dots: false,
            loop: true,
            responsive: {
                1200: {items: 6},
                992: {items: 5},
                768: {items: 4},
                576: {items: 3},
                0: {items: 2}
            }
        });
    });


    /*
    // block posts carousel
    */
    $(function() {
        $('.block-posts').each(function() {
            const layout = $(this).data('layout');
            const options = {
                margin: 30,
                nav: false,
                dots: false,
                loop: true
            };
            const layoutOptions = {
                'grid-nl': {

                    responsive: {
                        992: {items: 3},
                        768: {items: 2},
                        0: {items: 1}
                    }
                },
                'list-sm': {
                    responsive: {
                        992: {items: 2},
                        0: {items: 1}
                    }
                }
            };
            const owl = $('.block-posts__slider .owl-carousel');

            owl.owlCarousel($.extend({}, options, layoutOptions[layout]));

            $(this).find('.block-header__arrow--left').on('click', function() {
                owl.trigger('prev.owl.carousel', [500]);
            });
            $(this).find('.block-header__arrow--right').on('click', function() {
                owl.trigger('next.owl.carousel', [500]);
            });
        });
    });


    /*
    // teammates
    */
    $(function() {
        $('.teammates .owl-carousel').owlCarousel({
            nav: false,
            dots: true,
            responsive: {
                768: {items: 3, margin: 32},
                380: {items: 2, margin: 24},
                0: {items: 1}
            }
        });
    });

    /*
    // quickview
    */
    const quickview = {
        cancelPreviousModal: function() {},
        clickHandler: function() {
            const modal = $('#quickview-modal');
            const button = $(this);
            const doubleClick = button.is('.product-card__quickview--preload');

            quickview.cancelPreviousModal();

            if (doubleClick) {
                return;
            }

            button.addClass('product-card__quickview--preload');

            let xhr = null;
            // timeout ONLY_FOR_DEMO!
            const timeout = setTimeout(function() {
                xhr = $.ajax({
                    url: 'quickview.html',
                    success: function(data) {
                        quickview.cancelPreviousModal = function() {};
                        button.removeClass('product-card__quickview--preload');

                        modal.find('.modal-content').html(data);
                        modal.find('.quickview__close').on('click', function() {
                            modal.modal('hide');
                        });
                        modal.modal('show');
                    }
                });
            }, 1000);

            quickview.cancelPreviousModal = function() {
                button.removeClass('product-card__quickview--preload');

                if (xhr) {
                    xhr.abort();
                }

                // timeout ONLY_FOR_DEMO!
                clearTimeout(timeout);
            };
        }
    };

    $(function () {
        const modal = $('#quickview-modal');

        modal.on('shown.bs.modal', function() {
            modal.find('.product').each(function () {
                const gallery = $(this).find('.product-gallery');

                if (gallery.length > 0) {
                    initProductGallery(gallery[0], $(this).data('layout'));
                }
            });

            $('.input-number', modal).customNumber();
        });

        $('.product-card__quickview').on('click', function() {
            quickview.clickHandler.apply(this, arguments);
        });
    });


    /*
    // products carousel
    */
    $(function() {
        $('.block-products-carousel').each(function() {
            const layout = $(this).data('layout');
            const options = {
                items: 4,
                margin: 14,
                nav: false,
                dots: false,
                loop: true,
                stagePadding: 1
            };
            const layoutOptions = {
                'grid-4': {
                    responsive: {
                        1200: {items: 4, margin: 14},
                        992:  {items: 4, margin: 10},
                        768:  {items: 3, margin: 10},
                        576:  {items: 2, margin: 10},
                        475:  {items: 2, margin: 10},
                        0:    {items: 1}
                    }
                },
                'grid-4-sm': {
                    responsive: {
                        1200: {items: 4, margin: 14},
                        992:  {items: 3, margin: 10},
                        768:  {items: 3, margin: 10},
                        576:  {items: 2, margin: 10},
                        475:  {items: 2, margin: 10},
                        0:    {items: 1}
                    }
                },
                'grid-5': {
                    responsive: {
                        1200: {items: 5, margin: 12},
                        992:  {items: 4, margin: 10},
                        768:  {items: 3, margin: 10},
                        576:  {items: 2, margin: 10},
                        475:  {items: 2, margin: 10},
                        0:    {items: 1}
                    }
                },
                'horizontal': {
                    items: 3,
                    responsive: {
                        1200: {items: 3, margin: 14},
                        992:  {items: 3, margin: 10},
                        768:  {items: 2, margin: 10},
                        576:  {items: 1},
                        475:  {items: 1},
                        0:    {items: 1}
                    }
                },
            };
            const owl = $('.owl-carousel', this);
            let cancelPreviousTabChange = function() {};

            owl.owlCarousel($.extend({}, options, layoutOptions[layout]));

            $(this).find('.block-header__group').on('click', function(event) {
                const block = $(this).closest('.block-products-carousel');

                event.preventDefault();

                if ($(this).is('.block-header__group--active')) {
                    return;
                }

                cancelPreviousTabChange();

                block.addClass('block-products-carousel--loading');
                $(this).closest('.block-header__groups-list').find('.block-header__group--active').removeClass('block-header__group--active');
                $(this).addClass('block-header__group--active');

                // timeout ONLY_FOR_DEMO! you can replace it with an ajax request
                let timer;
                timer = setTimeout(function() {
                    let items = block.find('.owl-carousel .owl-item:not(".cloned") .block-products-carousel__column');

                    /*** this is ONLY_FOR_DEMO! / start */
                    /**/ const itemsArray = items.get();
                    /**/ const newItemsArray = [];
                    /**/
                    /**/ while (itemsArray.length > 0) {
                    /**/     const randomIndex = Math.floor(Math.random() * itemsArray.length);
                    /**/     const randomItem = itemsArray.splice(randomIndex, 1)[0];
                    /**/
                    /**/     newItemsArray.push(randomItem);
                    /**/ }
                    /**/ items = $(newItemsArray);
                    /*** this is ONLY_FOR_DEMO! / end */

                    block.find('.owl-carousel')
                        .trigger('replace.owl.carousel', [items])
                        .trigger('refresh.owl.carousel')
                        .trigger('to.owl.carousel', [0, 0]);

                    $('.product-card__quickview', block).on('click', function() {
                        quickview.clickHandler.apply(this, arguments);
                    });

                    block.removeClass('block-products-carousel--loading');
                }, 1000);
                cancelPreviousTabChange = function() {
                    // timeout ONLY_FOR_DEMO!
                    clearTimeout(timer);
                    cancelPreviousTabChange = function() {};
                };
            });

            $(this).find('.block-header__arrow--left').on('click', function() {
                owl.trigger('prev.owl.carousel', [500]);
            });
            $(this).find('.block-header__arrow--right').on('click', function() {
                owl.trigger('next.owl.carousel', [500]);
            });
        });
    });


    /*
    // product gallery
    */
    const initProductGallery = function(element, layout) {
        layout = layout !== undefined ? layout : 'standard';

        const options = {
            dots: false,
            margin: 10
        };
        const layoutOptions = {
            standard: {
                responsive: {
                    1200: {items: 5},
                    992: {items: 4},
                    768: {items: 3},
                    480: {items: 5},
                    380: {items: 4},
                    0: {items: 3}
                }
            },
            sidebar: {
                responsive: {
                    768: {items: 4},
                    480: {items: 5},
                    380: {items: 4},
                    0: {items: 3}
                }
            },
            columnar: {
                responsive: {
                    768: {items: 4},
                    480: {items: 5},
                    380: {items: 4},
                    0: {items: 3}
                }
            },
            quickview: {
                responsive: {
                    1200: {items: 5},
                    768: {items: 4},
                    480: {items: 5},
                    380: {items: 4},
                    0: {items: 3}
                }
            }
        };

        const gallery = $(element);

        const image = gallery.find('.product-gallery__featured .owl-carousel');
        const carousel = gallery.find('.product-gallery__carousel .owl-carousel');

        image
            .owlCarousel({items: 1, dots: false})
            .on('changed.owl.carousel', syncPosition);

        carousel
            .on('initialized.owl.carousel', function () {
                carousel.find('.product-gallery__carousel-item').eq(0).addClass('product-gallery__carousel-item--active');
            })
            .owlCarousel($.extend({}, options, layoutOptions[layout]));

        carousel.on('click', '.owl-item', function(e){
            e.preventDefault();

            image.data('owl.carousel').to($(this).index(), 300, true);
        });

        function syncPosition (el) {
            let current = el.item.index;

            carousel
                .find('.product-gallery__carousel-item')
                .removeClass('product-gallery__carousel-item--active')
                .eq(current)
                .addClass('product-gallery__carousel-item--active');
            const onscreen = carousel.find('.owl-item.active').length - 1;
            const start = carousel.find('.owl-item.active').first().index();
            const end = carousel.find('.owl-item.active').last().index();

            if (current > end) {
                carousel.data('owl.carousel').to(current, 100, true);
            }
            if (current < start) {
                carousel.data('owl.carousel').to(current - onscreen, 100, true);
            }
        }
    };

    $(function() {
        $('.product').each(function () {
            const gallery = $(this).find('.product-gallery');

            if (gallery.length > 0) {
                initProductGallery(gallery[0], $(this).data('layout'));
            }
        });
    });


    /*
    // Checkout payment methods
    */
    $(function () {
        $('[name="checkout_payment_method"]').on('change', function () {
            const currentItem = $(this).closest('.payment-methods__item');

            $(this).closest('.payment-methods__list').find('.payment-methods__item').each(function (i, element) {
                const links = $(element);
                const linksContent = links.find('.payment-methods__item-container');

                if (element !== currentItem[0]) {
                    const startHeight = linksContent.height();

                    linksContent.css('height', startHeight + 'px');
                    links.removeClass('payment-methods__item--active');

                    linksContent.css('height', '');
                } else {
                    const startHeight = linksContent.height();

                    links.addClass('payment-methods__item--active');

                    const endHeight = linksContent.height();

                    linksContent.css('height', startHeight + 'px');
                    linksContent.css('height', endHeight + 'px');
                }
            });
        });

        $('.payment-methods__item-container').on('transitionend', function (event) {
            if (event.originalEvent.propertyName === 'height') {
                $(this).css('height', '');
            }
        });
    });


    /*
    // collapse
    */
    $(function () {
        $('[data-collapse]').each(function (i, element) {
            const collapse = element;
            const openedClass = $(element).data('collapse-opened-class');

            $('[data-collapse-trigger]', collapse).on('click', function () {
                const item = $(this).closest('[data-collapse-item]');
                const content = item.children('[data-collapse-content]');
                const itemParents = item.parents();

                itemParents.slice(0, itemParents.index(collapse) + 1).filter('[data-collapse-item]').css('height', '');

                if (item.is('.' + openedClass)) {
                    const startHeight = content.height();

                    content.css('height', startHeight + 'px');
                    item.removeClass(openedClass);

                    content.css('height', '');
                } else {
                    const startHeight = content.height();

                    item.addClass(openedClass);

                    const endHeight = content.height();

                    content.css('height', startHeight + 'px');
                    content.css('height', endHeight + 'px');
                }
            });

            $('[data-collapse-content]', collapse).on('transitionend', function (event) {
                if (event.originalEvent.propertyName === 'height') {
                    $(this).css('height', '');
                }
            });
        });
    });


    /*
    // price filter
    */
    $(function () {
        $('.filter-price').each(function (i, element) {
            const min = $(element).data('min');
            const max = $(element).data('max');
            const from = $(element).data('from');
            const to = $(element).data('to');
            const slider = element.querySelector('.filter-price__slider');

            noUiSlider.create(slider, {
                start: [from, to],
                connect: true,
                range: {
                    'min': min,
                    'max': max
                }
            });

            const titleValues = [
                $(element).find('.filter-price__min-value')[0],
                $(element).find('.filter-price__max-value')[0]
            ];

            slider.noUiSlider.on('update', function (values, handle) {
                titleValues[handle].innerHTML = values[handle];
            });
        });
    });


    /*
    // mobilemenu
    */
    $(function () {
        const body = $('body');
        const mobilemenu = $('.mobilemenu');

        if (mobilemenu.length) {
            const open = function() {
                const bodyWidth = body.width();
                body.css('overflow', 'hidden');
                body.css('paddingRight', (body.width() - bodyWidth) + 'px');

                mobilemenu.addClass('mobilemenu--open');
            };
            const close = function() {
                body.css('overflow', 'auto');
                body.css('paddingRight', '');

                mobilemenu.removeClass('mobilemenu--open');
            };


            $('.mobile-header__menu-button').on('click', function() {
                open();
            });
            $('.mobilemenu__backdrop, .mobilemenu__close').on('click', function() {
                close();
            });
        }
    });


    /*
    // tooltips
    */
    $(function () {
        $('[data-toggle="tooltip"]').tooltip({trigger: 'hover'});
    });


    /*
    // layout switcher
    */
    $(function () {
        $('.layout-switcher__button').on('click', function() {
            const layoutSwitcher = $(this).closest('.layout-switcher');
            const productsView = $(this).closest('.products-view');
            const productsList = productsView.find('.products-list');

            layoutSwitcher.find('.layout-switcher__button').removeClass('layout-switcher__button--active');
            $(this).addClass('layout-switcher__button--active');

            productsList.attr('data-layout', $(this).attr('data-layout'));
            productsList.attr('data-with-features', $(this).attr('data-with-features'));
        });
    });

    // document.addEventListener("DOMContentLoaded", function () {
    //     const cartTable = document.querySelector(".cart__table");
    //
    //     function updateRowTotal(row) {
    //         const priceCell = row.querySelector(".cart-table__column--price");
    //         const quantityInput = row.querySelector(".input-number__input");
    //         const totalCell = row.querySelector(".cart-table__column--total");
    //
    //         const unitPrice = parseFloat(priceCell.textContent.trim());
    //         const quantity = parseInt(quantityInput.value);
    //
    //         const rowTotal = unitPrice * quantity;
    //         totalCell.textContent = rowTotal.toFixed(3) + ' đ';
    //
    //         const index = row.dataset.index;
    //         const hiddenInput = document.querySelector(`input[data-index='${index}']`);
    //         if (hiddenInput) {
    //             hiddenInput.value = quantity;
    //         }
    //
    //         updateCartTotal();
    //     }
    //
    //     function updateCartTotal() {
    //         const totalPriceHeader = document.querySelector(".cart__totals-header td");
    //         const totalPriceFooter = document.querySelector(".cart__totals-footer td");
    //         let totalPrice = 0;
    //
    //         cartTable.querySelectorAll(".cart-table__row").forEach(row => {
    //             const totalCell = row.querySelector(".cart-table__column--total");
    //             if (totalCell) {
    //                 const rowTotal = parseFloat(totalCell.textContent.trim());
    //                 if (!isNaN(rowTotal)) {
    //                     totalPrice += rowTotal;
    //                 }
    //             }
    //         });
    //
    //         totalPriceHeader.textContent = totalPrice.toFixed(3) +' đ';
    //         totalPriceFooter.textContent = totalPrice.toFixed(3) + ' đ';
    //     }
    //
    //     cartTable.querySelectorAll(".input-number__input").forEach(input => {
    //         input.addEventListener("input", function () {
    //             const row = input.closest(".cart-table__row");
    //             updateRowTotal(row);
    //         });
    //     });
    //
    //     cartTable.querySelectorAll(".input-number__add, .input-number__sub").forEach(button => {
    //         button.addEventListener("click", function () {
    //             const row = button.closest(".cart-table__row");
    //             const input = row.querySelector(".input-number__input");
    //             const step = parseInt(input.getAttribute("step") || 1);
    //
    //             if (button.classList.contains("input-number__add")) {
    //                 input.value = parseInt(input.value) + step;
    //             } else if (button.classList.contains("input-number__sub")) {
    //                 input.value = Math.max(parseInt(input.value) - step, 1);
    //             }
    //
    //             updateRowTotal(row);
    //         });
    //     });
    // });

    $(document).ready(function () {
        const cartTable = $(".cart__table");

        function updateRowTotal(row) {
            const priceCell = row.find(".cart-table__column--price");
            const quantityInput = row.find(".input-number__input");
            const totalCell = row.find(".cart-table__column--total");

            const rawUnitPrice = priceCell.text().trim().replace(/[^0-9.,]+/g, '');
            const unitPrice = parseFloat(rawUnitPrice.replace(/\./g, '').replace(/,/g, '.'));
            const quantity = parseInt(quantityInput.val()) || 0;

            const rowTotal = unitPrice * quantity;
            totalCell.text(formatCurrency(rowTotal) + ' đ');

            const index = row.data('index');
            const hiddenInput = $(`input[data-index='${index}']`);
            if (hiddenInput.length > 0) {
                hiddenInput.val(quantity);
            }

            updateCartTotal();
        }

        function updateCartTotal() {
            const totalPriceHeader = $(".cart__totals-header td");
            const totalPriceFooter = $(".cart__totals-footer td");
            let totalPrice = 0;

            cartTable.find(".cart-table__row").each(function () {
                const totalCell = $(this).find(".cart-table__column--total");
                if (totalCell.length) {
                    const rawTotalPrice = totalCell.text().trim().replace(/[^0-9.,]+/g, '');
                    const rowTotal = parseFloat(rawTotalPrice.replace(/\./g, '').replace(/,/g, '.'));
                    if (!isNaN(rowTotal)) {
                        totalPrice += rowTotal;
                    }
                }
            });

            totalPriceHeader.text(formatCurrency(totalPrice) + ' đ');
            totalPriceFooter.text(formatCurrency(totalPrice) + ' đ');
        }

        cartTable.find(".input-number__input").on("input", function () {
            const row = $(this).closest(".cart-table__row");
            updateRowTotal(row);
        });

        cartTable.find(".input-number__add, .input-number__sub").on("click", function () {
            const row = $(this).closest(".cart-table__row");
            const input = row.find(".input-number__input");
            const stockInput = row.find(".input-stock__input");
            const maxQuantity = parseInt(stockInput.val());
            const step = parseInt(input.attr("step") || 1);

            if ($(this).hasClass("input-number__add")) {
                input.val(Math.min(parseInt(input.val()) + step, maxQuantity));
            } else if ($(this).hasClass("input-number__sub")) {
                input.val(Math.max(parseInt(input.val()) - step, 1));
            }

            updateRowTotal(row);
        });
    });


    function formatCurrency(value) {
        // Use the 'vi-VN' locale to format the number according to Vietnamese currency format
        // and 'VND' as the currency type for Vietnamese đồng
        const formatter = new Intl.NumberFormat('vi-VN', {
            style: 'decimal',
            minimumFractionDigits: 0, // No decimal part for whole numbers
        });

        let formatted = formatter.format(value);
        // Replace dots with commas for thousands separator
        // formatted = formatted.replace(/\./g, ',');
        return formatted;
    }

    $(document).ready(function() {
        $("select[name='province']").change(function() {
            let selectedProvince = $(this).val();
            $.ajax({
                url: `http://localhost:8080/v1/api/shipping_method/getMethod?Address=${selectedProvince}`,
                type: 'GET',
                success: function(response) {
                    if (response.status) {
                        // Lấy giá trị thành tiền hiện tại
                        let totalPriceText = document.querySelector("#total-price").textContent.trim();
                        let totalPriceValue = Number(totalPriceText.replace(/[^0-9]/g, ''));

                        // Lấy phí ship hiện tại
                        let currentShippingCostText = $('#shipping-cost').text().trim();
                        let currentShippingCost = Number(currentShippingCostText.replace(/[^0-9]/g, '')) || 0;

                        let shippingFee = parseFloat(response.data.price);  // Phí ship mới từ API
                        $('#shipping-cost').text(formatCurrency(response.data.price) + ' đ');

                        // Kiểm tra nếu phí ship hiện tại không phải 0
                        if (currentShippingCost === 0) {
                            // Tính tổng với phí ship mới
                            let totalWithShipping = totalPriceValue + shippingFee;
                            $('#shipping-fee').val(response.data.price);
                            document.querySelector("#total-price").textContent = formatCurrency(totalWithShipping) + " đ";
                        } else if (currentShippingCost === shippingFee) {
                            // Nếu phí ship hiện tại và phí ship mới giống nhau, không thay đổi tổng
                            $('#shipping-fee').val(response.data.price);
                            document.querySelector("#total-price").textContent = formatCurrency(totalPriceValue) + " đ";
                        } else {
                            // Nếu phí ship hiện tại khác phí ship mới, tính lại tổng
                            let totalWithShipping = totalPriceValue - currentShippingCost + shippingFee;
                            $('#shipping-fee').val(response.data.price);
                            document.querySelector("#total-price").textContent = formatCurrency(totalWithShipping) + " đ";
                        }
                        Swal.fire({
                            title: '🎉Thông báo!🎉',
                            text: 'Đã cập nhật phí giao hàng.',
                            icon: 'success',
                            background: '#0077b6',
                            color: '#ffffff',
                            confirmButtonColor: '#27ae60',
                            confirmButtonText: 'OK'
                        });
                    } else {
                        // Trường hợp không tìm thấy phương thức vận chuyển
                        $('#shipping-cost').text("Không tìm thấy phương thức vận chuyển");
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error:", error);
                    alert("Có lỗi xảy ra khi tính phí ship.");
                }
            });
        });
    });

})(jQuery);