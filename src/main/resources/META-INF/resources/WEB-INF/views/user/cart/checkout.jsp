<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="jakarta.tags.core" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--    <body>--%>
<%--        <div class="site">--%>
<%--            <div class="site__body">--%>
<%--                <div class="page-header">--%>
<%--                    <div class="page-header__container container">--%>
<%--                        <div class="page-header__breadcrumb">--%>
<%--                            <nav aria-label="breadcrumb">--%>
<%--                                <ol class="breadcrumb">--%>
<%--                                    <li class="breadcrumb-item">--%>
<%--                                        <a href="<c:url value='/index.html' />">Home</a>--%>
<%--                                        <svg class="breadcrumb-arrow" width="6px" height="9px">--%>
<%--                                            <use xlink:href="<c:url value='/images/sprite.svg#arrow-rounded-right-6x9' />"></use>--%>
<%--                                        </svg>--%>
<%--                                    </li>--%>
<%--                                    <li class="breadcrumb-item">--%>
<%--                                        <a href="#">Breadcrumb</a>--%>
<%--                                        <svg class="breadcrumb-arrow" width="6px" height="9px">--%>
<%--                                            <use xlink:href="<c:url value='/images/sprite.svg#arrow-rounded-right-6x9' />"></use>--%>
<%--                                        </svg>--%>
<%--                                    </li>--%>
<%--                                    <li class="breadcrumb-item active" aria-current="page">Checkout</li>--%>
<%--                                </ol>--%>
<%--                            </nav>--%>
<%--                        </div>--%>
<%--                        <div class="page-header__title">--%>
<%--                            <h1>Checkout</h1>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="checkout block">--%>
<%--                    <div class="container">--%>
<%--                        <div class="row">--%>
<%--                            <div class="col-12 col-lg-6 col-xl-7">--%>
<%--                                <div class="card mb-lg-0">--%>
<%--                                    <div class="card-body">--%>
<%--                                        <h3 class="card-title">Billing details</h3>--%>
<%--                                        <div class="form-row">--%>
<%--                                            <div class="form-group col-md-12">--%>
<%--                                                <label for="checkout-first-name">Receiver Name</label>--%>
<%--                                                <input type="text" class="form-control" id="checkout-first-name" placeholder="Receiver Name">--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                        <div class="form-group">--%>
<%--                                            <label for="checkout-street-address">Address</label>--%>
<%--                                            <input type="text" class="form-control" id="checkout-street-address" placeholder="Address">--%>
<%--                                        </div>--%>
<%--                                        <div class="form-row">--%>
<%--                                            <div class="form-group col-md-12">--%>
<%--                                                <label for="checkout-phone">Phone</label>--%>
<%--                                                <input type="text" class="form-control" id="checkout-phone" placeholder="Phone">--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                    <div class="card-divider"></div>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                            <div class="col-12 col-lg-6 col-xl-5 mt-4 mt-lg-0">--%>
<%--                                <div class="card mb-0">--%>
<%--                                    <div class="card-body">--%>
<%--                                        <h3 class="card-title">Your Order</h3>--%>
<%--                                        <table class="checkout__totals">--%>
<%--                                            <thead class="checkout__totals-header">--%>
<%--                                            <tr>--%>
<%--                                                <th>Product</th>--%>
<%--                                                <th>Total</th>--%>
<%--                                            </tr>--%>
<%--                                            </thead>--%>
<%--                                            <tbody class="checkout__totals-products">--%>
<%--                                            <c:forEach var="cartItem" items="${cartDetails}">--%>
<%--                                                <tr>--%>
<%--                                                    <td>--%>
<%--                                                        ${cartItem.medicine.name} × ${cartItem.quantity} <br/>--%>
<%--                                                    </td>--%>
<%--                                                    <td>${cartItem.subTotal}--%>
<%--                                                        <c:choose>--%>
<%--                                                            <c:when test="${percentageDiscount != 0}">--%>
<%--                                                                <br/>--%>
<%--                                                                -${percentageDiscount}%--%>
<%--                                                            </c:when>--%>
<%--                                                        </c:choose>--%>
<%--                                                    </td>--%>
<%--                                                </tr>--%>
<%--                                            </c:forEach>--%>
<%--                                            </tbody>--%>
<%--                                            <tbody class="checkout__totals-subtotals">--%>
<%--                                                <tr>--%>
<%--                                                    <th>Subtotal</th>--%>
<%--                                                    <td>${subPrice}</td>--%>
<%--                                                </tr>--%>
<%--                                                <tr>--%>
<%--                                                    <th>Discount</th>--%>
<%--                                                    <td>--%>
<%--                                                        <c:choose>--%>
<%--                                                            <c:when test="${not empty discount}">--%>
<%--                                                                - ${discount}--%>
<%--                                                            </c:when>--%>
<%--                                                            <c:otherwise>--%>
<%--                                                                0--%>
<%--                                                            </c:otherwise>--%>
<%--                                                        </c:choose>--%>
<%--                                                    </td>--%>
<%--                                                </tr>--%>
<%--                                                <tr>--%>
<%--                                                    <th>Shipping</th>--%>
<%--                                                    <td>0</td>--%>
<%--                                                </tr>--%>
<%--                                            </tbody>--%>
<%--                                            <tfoot class="checkout__totals-footer">--%>
<%--                                            <tr>--%>
<%--                                                <th>Total</th>--%>
<%--                                                <td>${totalPrice}</td>--%>
<%--                                            </tr>--%>
<%--                                            </tfoot>--%>
<%--                                        </table>--%>
<%--                                        <button type="submit" class="btn btn-primary btn-xl btn-block">Place Order</button>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </body>--%>
<%--</html>--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<body>
<div class="site">
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
                            <li class="breadcrumb-item active" aria-current="page">Checkout</li>
                        </ol>
                    </nav>
                </div>
                <div class="page-header__title">
                    <h1>Checkout</h1>
                </div>
            </div>
        </div>
        <div class="checkout block">
            <div class="container">
                <div class="row">
                    <!-- Form chỉ cho Billing details -->
                    <form action="/place-order" method="post" class="col-12 col-lg-6 col-xl-7">
                        <div class="card mb-lg-0">
                            <div class="card-body">
                                <h3 class="card-title">Billing details</h3>
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label for="checkout-first-name">Receiver Name</label>
                                        <input type="text" class="form-control" id="checkout-first-name" name="receiverName" placeholder="Receiver Name">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="checkout-street-address">Address</label>
                                    <input type="text" class="form-control" id="checkout-street-address" name="receiverAddress" placeholder="Address">
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label for="checkout-phone">Phone</label>
                                        <input type="text" class="form-control" id="checkout-phone" name="receiverPhone" placeholder="Phone">
                                    </div>
                                </div>
                                <div class="form-check">
                                    <div class="form-group col-md-12 d-flex align-items-center">
                                        <input class="form-check-input" type="checkbox" name="accumulate" value="true" id="flexCheckIndeterminate">
                                        <label class="form-check-label" for="flexCheckIndeterminate">
                                            Accumulate Points
                                        </label>
                                    </div>
                                </div>
                                <!-- Đảm bảo khi không chọn checkbox, giá trị false được gửi -->
                                <input type="hidden" name="accumulate" value="false">
                                <input hidden type="text" class="form-control" name="eventCode" value="${code}">
                                <input hidden type="text" class="form-control" name="usedPoint" value="${usedPoints}">
                                <button type="submit" class="btn btn-primary btn-xl btn-block">Submit</button>
                            </div>
                        </div>
                    </form>
                    <!-- Kết thúc form Billing details -->

                    <div class="col-12 col-lg-6 col-xl-5 mt-4 mt-lg-0">
                        <div class="card mb-0">
                            <div class="card-body">
                                <h3 class="card-title">Your Order</h3>
                                <table class="checkout__totals">
                                    <thead class="checkout__totals-header">
                                    <tr>
                                        <th>Product</th>
                                        <th>Total</th>
                                    </tr>
                                    </thead>
                                    <tbody class="checkout__totals-products">
                                    <c:forEach var="cartItem" items="${cartDetails}">
                                        <tr>
                                            <td>
                                                    ${cartItem.medicine.name} × ${cartItem.quantity} <br/>
                                            </td>
                                            <td>${cartItem.subTotal}
                                                <c:choose>
                                                    <c:when test="${percentageDiscount != 0}">
                                                        <br/>
                                                        -${percentageDiscount}%
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                    <tbody class="checkout__totals-subtotals">
                                    <tr>
                                        <th>Subtotal</th>
                                        <td>${subPrice}</td>
                                    </tr>
                                    <tr>
                                        <th>Discount</th>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty discount}">
                                                    - ${discount}
                                                </c:when>
                                                <c:otherwise>
                                                    0
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Shipping</th>
                                        <td>0</td>
                                    </tr>
                                    </tbody>
                                    <tfoot class="checkout__totals-footer">
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
            </div>
        </div>
    </div>
</div>
</body>
</html>
