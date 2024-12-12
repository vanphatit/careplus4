<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                                    <a href="<c:url value='/home' />">Trang chủ</a>
                                </li>
                                <li class="breadcrumb-item">
                                    Giỏ hàng
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">Giỏ hàng mua sắm</li>
                            </ol>
                        </nav>
                    </div>
                    <div class="page-header__title">
                        <h1>Giỏ hàng mua sắm</h1>
                    </div>
                </div>
            </div>
            <div class="cart block">
                <div class="container">
                    <table class="cart__table cart-table">
                        <thead class="cart-table__head">
                        <tr class="cart-table__row">
                            <th class="cart-table__column cart-table__column--image">Ảnh</th>
                            <th class="cart-table__column cart-table__column--product">Sản phẩm</th>
                            <th class="cart-table__column cart-table__column--price">Giá</th>
                            <th class="cart-table__column cart-table__column--quantity">Số lượng</th>
                            <th class="cart-table__column cart-table__column--total">Tổng</th>
                            <th class="cart-table__column cart-table__column--remove"></th>
                        </tr>
                        </thead>
                        <tbody class="cart-table__body">
                        <c:forEach var="item" items="${cartDetails}" varStatus="status">
                            <tr class="cart-table__row" data-index="${status.index}">
                                <td class="cart-table__column cart-table__column--image">
                                    <img src="${pageContext.request.contextPath}/images/image?fileName=${item.medicine.image}"
                                         alt="${item.medicine.name}"
                                    />
                                </td>
                                <td class="cart-table__column cart-table__column--product">
                                    <a href="/user/medicine/${item.medicine.id}" class="cart-table__product-name">${item.medicine.name}</a>
                                </td>
                                <td class="cart-table__column cart-table__column--price" data-title="Price">
                                    <fmt:formatNumber type="number" value="${item.unitCost}" /> đ
                                </td>
                                <td class="cart-table__column cart-table__column--quantity" data-title="Quantity">
                                    <div class="input-number">
                                        <input class="form-control input-number__input" type="number" min="1" value="${item.quantity}"/>
                                        <input class="form-control input-stock__input" type="number" min="1" value="${item.medicine.stockQuantity}" hidden/>
                                        <div class="input-number__add"></div>
                                        <div class="input-number__sub"></div>
                                    </div>
                                </td>
                                <td class="cart-table__column cart-table__column--total" data-title="Total">
                                    <fmt:formatNumber type="number" value="${item.subTotal}" /> đ
                                </td>
                                <td class="cart-table__column cart-table__column--remove">
                                    <form method="post" action="/user/delete-cart-detail/${item.id}">
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
                            <a href="/user/medicines" class="btn btn-primary cart__update-button">Tiếp tục mua sắm</a>
                        </div>
                    </div>

                    <div class="row justify-content-end pt-5">
                        <div class="col-12 col-md-7 col-lg-6 col-xl-5">
                            <div class="card">
                                <div class="card-body">
                                    <h3 class="card-title">Tạm tính <hr/> </h3>
                                    <table class="cart__totals">
                                        <thead class="cart__totals-header">
                                        <tr>
                                            <th>Tổng</th>
                                            <td><fmt:formatNumber type="number" value="${totalPrice}" /> đ</td>
                                        </tr>
                                        </thead>
                                        <tbody class="cart__totals-body">
                                        </tbody>
                                        <tfoot class="cart__totals-footer">
                                        <tr>
                                            <th>Thành tiền</th>
                                            <td><fmt:formatNumber type="number" value="${totalPrice}" /> đ</td>
                                        </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- Handle order to bill -->
                    <%--@elvariable id="cart" type=""--%>
                    <form:form action="/user/confirm-checkout" method="post" id="checkoutForm" modelAttribute="cart">
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
                        <input hidden type="text" name="code" id="event-code-input" />
                        <input hidden type="text" id="usePointsHidden" name="usedPoint" value="false" />
                        <div class="row justify-content-end pt-2">
                            <div class="col-12 col-md-7 col-lg-6 col-xl-5">
                                <div>
                                    <div class="form-check form-switch ml-2">
                                        <input
                                                class="form-check-input"
                                                type="checkbox"
                                                id="usePointsSwitch"
                                                name="usePoints"
                                                value=${cart.usedPoint}
                                                onchange="updateUsePointsHiddenField(this.checked)"
                                                style="transform: scale(1.5); cursor: pointer;" />
                                        <label
                                                class="form-check-label"
                                                for="usePointsSwitch"
                                                style="font-size: 16px; font-weight: 500; cursor: pointer;">
                                            Sử dụng điểm thưởng
                                        </label>
                                    </div>
                                </div>
                                <button class="btn btn-primary btn-xl btn-block cart__checkout-button">Tiến hành thanh toán</button>
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
        function updateUsePointsHiddenField(isChecked) {
            document.getElementById('usePointsHidden').value = isChecked ? "true" : "false";
        }
    </script>
</body>
