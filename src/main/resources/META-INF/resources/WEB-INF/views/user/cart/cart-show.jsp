<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
                        <c:forEach var="item" items="${cartDetails}" varStatus="status">
                            <tr class="cart-table__row" data-index="${status.index}">
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
                        <div>
                            <select class="form-control" id="event-select" name="selectedEvent" onchange="updateEventInput(this.value)">
                                <c:forEach var="event" items="${events}">
                                    <option value="${event.id}">${event.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="cart__buttons">
                            <a href="#" class="btn btn-primary cart__update-button">Continue Shopping</a>
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
                                        <tbody class="cart__totals-body">
                                            <tr>
                                                <th>Shipping</th>
                                                <td>0</td>
                                            </tr>
                                        </tbody>
                                        <tfoot class="cart__totals-footer">
                                        <tr>
                                            <th>Total</th>
                                            <td>${totalPrice}</td>
                                        </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Handle order to bill -->
                    <form:form action="/confirm-checkout" method="post" id="checkoutForm" modelAttribute="cart">
                        <div style="display: none;">
                            <c:forEach var="cartDetail" items="${cart.cartDetails}" varStatus="status">
                                <div class="mb-3">
                                    <div class="form-group">
                                        <label>Id:</label>
                                        <form:input class="form-control"
                                                    type="text"
                                                    value="${cartDetail.id}"
                                                    path="cartDetails[${status.index}].id"/>
                                    </div>

                                    <div class="form-group">
                                        <label class="cart-table__column cart-table__column--quantity" >Quantity:</label>
                                        <div class="input-number">
                                            <form:input class="form-control input-number__input" type="number" min="1"
                                                        value="${cartDetail.quantity}"
                                                        path="cartDetails[${status.index}].quantity"
                                                        data-index="${status.index}"
                                            />
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <input type="text" name="code" id="event-code-input" />
                        <div class="row justify-content-end">
                            <div class="col-5">
                                <button class="btn btn-primary btn-xl btn-block cart__checkout-button">Proceed to checkout</button>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div>
        </div><!-- site__body / end -->
    </div><!-- site / end -->
    <script>
        function updateEventInput(selectedValue) {
            document.getElementById('event-code-input').value = selectedValue;
        }
    </script>
</body>
