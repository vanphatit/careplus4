<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                                <a href="<c:url value='/home' />">Trang chủ</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="<c:url value='/user/cart' />">Giỏ hàng</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">Checkout</li>
                        </ol>
                    </nav>
                </div>
                <div class="page-header__title">
                    <h1>Thanh toán</h1>
                </div>
            </div>
        </div>
        <div class="checkout block">
            <div class="container">
                <div class="row">
                    <!-- Form chỉ cho Billing details -->
                    <form action="/user/place-order" method="post" class="col-12 col-lg-6 col-xl-7">
                        <div class="card mb-lg-0">
                            <div class="card-body">
                                <h3 class="card-title">Thông tin hóa đơn</h3>
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label for="checkout-first-name">Tên người nhận</label>
                                        <input type="text" class="form-control" id="checkout-first-name" name="receiverName" placeholder="Tên người nhận">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="checkout-street-address">Địa chỉ</label>
                                    <input type="text" class="form-control" id="checkout-street-address" name="receiverAddress" placeholder="Số nhà, đường, phường, quận">
                                </div>
                                <div class="form-group">
                                    <label for="checkout-street-address">Tỉnh thành</label>
                                    <select class="form-control" name="province">
                                        <c:forEach var="province" items="${provinces}">
                                            <option value="${province}">${province}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label for="checkout-phone">Số điện thoại</label>
                                        <input type="text" class="form-control" id="checkout-phone" name="receiverPhone" placeholder="Phone">
                                    </div>
                                </div>
                                <div class="form-check">
                                    <div class="form-group col-md-12 d-flex align-items-center">
                                        <input class="form-check-input" type="checkbox" name="accumulate" value="true" id="flexCheckIndeterminate">
                                        <label class="form-check-label" for="flexCheckIndeterminate">
                                            Tích điểm
                                        </label>
                                    </div>
                                </div>
                                <!-- Đảm bảo khi không chọn checkbox, giá trị false được gửi -->
                                <input type="hidden" name="accumulate" value="false">
                                <input hidden type="text" class="form-control" name="eventCode" value="${code}">
                                <input hidden type="text" class="form-control" name="usedPoint" value="${usedPoints}">
                                <input hidden type="text" class="form-control" id="shipping-fee" name="shippingFee" value="0">
                                <button type="submit" class="btn btn-primary btn-xl btn-block">Đặt hàng</button>
                            </div>
                        </div>
                    </form>
                    <!-- Kết thúc form Billing details -->

                    <div class="col-12 col-lg-6 col-xl-5 mt-4 mt-lg-0">
                        <div class="card mb-0">
                            <div class="card-body">
                                <h3 class="card-title">Hóa đơn</h3>
                                <table class="checkout__totals">
                                    <thead class="checkout__totals-header">
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Tổng</th>
                                    </tr>
                                    </thead>
                                    <tbody class="checkout__totals-products">
                                    <c:forEach var="cartItem" items="${cartDetails}">
                                        <tr>
                                            <td>
                                                    ${cartItem.medicine.name} × ${cartItem.quantity} <br/>
                                            </td>
                                            <td> <fmt:formatNumber type="number" value="${cartItem.subTotal}" /> đ
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
                                        <th>Tổng</th>
                                        <td>
                                            <fmt:formatNumber type="number" value="${subPrice}" /> đ
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Giảm giá</th>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty discount}">
                                                    - <fmt:formatNumber type="number" value="${discount}" /> đ
                                                </c:when>
                                                <c:otherwise>
                                                    0 đ
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Shipping</th>
                                        <td id="shipping-cost">0</td>
                                    </tr>
                                    </tbody>
                                    <tfoot class="checkout__totals-footer">
                                    <tr>
                                        <th>Thành tiền</th>
                                        <td id="total-price">
                                            <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                        </td>
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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>
