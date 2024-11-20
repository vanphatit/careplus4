<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:url value="/" var="URL" />
<!DOCTYPE html>
<html lang="en">
<body>
    <div class="site"><!-- mobile site__header -->
        <div class="site__body">
            <div class="page-header">
                <div class="page-header__container container">
                    <div class="page-header__breadcrumb">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="<c:url value='/index.html' />">Home</a>
                                    <svg class="breadcrumb-arrow" width="6px" height="9px">
                                        <use xlink:href="<c:url value='/images/sprite.svg#arrow-rounded-right-6x9' />"></use>
                                    </svg>
                                </li>
                                <li class="breadcrumb-item">
                                    <a href="#">Breadcrumb</a>
                                    <svg class="breadcrumb-arrow" width="6px" height="9px">
                                        <use xlink:href="<c:url value='/images/sprite.svg#arrow-rounded-right-6x9' />"></use>
                                    </svg>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">Shopping Cart</li>
                            </ol>
                        </nav>
                    </div>
                    <div class="page-header__title">
                        <h1>Shopping Cart</h1>
                    </div>
                </div>
            </div>
            <div class="cart block">
                <div class="container">
                    <table class="cart__table cart-table">
                        <thead class="cart-table__head">
                        <tr class="cart-table__row">
                            <th class="cart-table__column cart-table__column--image">Image</th>
                            <th class="cart-table__column cart-table__column--product">Medicine</th>
                            <th class="cart-table__column cart-table__column--price">Price</th>
                            <th class="cart-table__column cart-table__column--quantity">Quantity</th>
                            <th class="cart-table__column cart-table__column--total">Total</th>
                            <th class="cart-table__column cart-table__column--remove"></th>
                        </tr>
                        </thead>
                        <tbody class="cart-table__body">
                        <c:forEach var="item" items="${cartDetails}">
                            <tr class="cart-table__row">
                                <td class="cart-table__column cart-table__column--image">
    <%--                                <a href="#"><img src="<c:url value='${item.image}' />" alt="" /></a>--%>
                                </td>
                                <td class="cart-table__column cart-table__column--product">
                                    <a href="#" class="cart-table__product-name">${item.medicine.name}</a>
                                </td>
                                <td class="cart-table__column cart-table__column--price" data-title="Price">${item.unitCost}</td>
                                <td class="cart-table__column cart-table__column--quantity" data-title="Quantity">
                                    <div class="input-number">
                                        <input class="form-control input-number__input" type="number" min="1" value="${item.quantity}" />
                                        <div class="input-number__add"></div>
                                        <div class="input-number__sub"></div>
                                    </div>
                                </td>
                                <td class="cart-table__column cart-table__column--total" data-title="Total">${item.subTotal}</td>
                                <td class="cart-table__column cart-table__column--remove">
                                    <form method="post" action="/delete-cart-detail/${item.id}">
                                        <button class="btn btn-md bg-light mt-2">
                                            <i class="fa fa-times text-danger"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="cart__actions">
                        <form class="cart__coupon-form">
                            <label for="input-coupon-code" class="sr-only">Coupon Code</label>
                            <input type="text" class="form-control" id="input-coupon-code" placeholder="Coupon Code" />
                            <button type="submit" class="btn btn-primary">Apply Coupon</button>
                        </form>
                        <div class="cart__buttons">
                            <a href="<c:url value='/index.html' />" class="btn btn-light">Continue Shopping</a>
                            <a href="#" class="btn btn-primary cart__update-button">Update Cart</a>
                        </div>
                    </div>
                    <div class="row justify-content-end pt-5">
                        <div class="col-12 col-md-7 col-lg-6 col-xl-5">
                            <div class="card">
                                <div class="card-body">
                                    <h3 class="card-title">Cart Totals</h3>
                                    <table class="cart__totals">
                                        <thead class="cart__totals-header">
                                        <tr>
                                            <th>Subtotal</th>
                                            <td>${totalPrice}</td>
                                        </tr>
                                        </thead>
    <%--                                    <tbody class="cart__totals-body">--%>
    <%--                                    <tr>--%>
    <%--                                        <th>Shipping</th>--%>
    <%--                                        <td>${shipping} <div class="cart__calc-shipping"><a href="#">Calculate Shipping</a></div></td>--%>
    <%--                                    </tr>--%>
                                        <tfoot class="cart__totals-footer">
                                        <tr>
                                            <th>Total</th>
                                            <td>${totalPrice}</td>
                                        </tr>
                                        </tfoot>
                                    </table>
                                    <a class="btn btn-primary btn-xl btn-block cart__checkout-button" href="<c:url value='/checkout.html' />">Proceed to checkout</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div><!-- site__body / end -->
    </div><!-- site / end -->
</body>
