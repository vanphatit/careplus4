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
                                <li class="breadcrumb-item active" aria-current="page">Lịch sử mua sắm</li>
                            </ol>
                        </nav>
                    </div>
                    <div class="page-header__title">
                        <h1>Lịch sử mua sắm</h1>
                    </div>
                </div>
            </div>
            <div class="container-fluid py-1">
                <div class="container py-1">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                            <tr>
                                <th scope="col">Sản phẩm</th>
                                <th scope="col">Tên</th>
                                <th scope="col">Giá cả</th>
                                <th scope="col">Số lượng</th>
                                <th scope="col">Thành tiền</th>
                                <th scope="col">Trạng thái</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${empty bills}">
                                <tr>
                                    <td colspan="6">
                                        Không có đơn hàng nào được tạo
                                    </td>
                                </tr>
                            </c:if>
                            <c:forEach var="bill" items="${bills}">
                                <tr>
                                    <td colspan="2">Mã hóa đơn: ${bill.id}</td>
                                    <td colspan="1">
                                        <fmt:formatNumber type="number" value=" ${bill.totalAmount}" /> đ
                                    </td>
                                    <td colspan="2"></td>
                                    <td colspan="1">
                                        <c:choose>
                                            <c:when test="${bill.status == 'COMPLETED'}">
                                                <span class="badge bg-success">COMPLETED</span>
                                                <br />
                                                <a href="/user/review/${bill.id}" class="btn btn-sm btn-primary mt-2">Đánh giá</a>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning">${bill.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <c:forEach var="billDetail" items="${bill.bilDetails}">
                                    <tr>
                                        <th scope="row">
                                            <div class="d-flex align-items-center">
                                                <img src="${pageContext.request.contextPath}/images/image?fileName=${billDetail.medicine.image}"
                                                     class="img-fluid me-5 rounded-circle"
                                                     style="width: 80px; height: 80px;" alt="">
                                            </div>
                                        </th>
                                        <td>
                                            <p class="mb-0 mt-4">
                                                <a href="/user/medicine/${billDetail.medicine.id}" target="_blank">
                                                        ${billDetail.medicine.name}
                                                </a>
                                            </p>
                                        </td>
                                        <td>
                                            <p class="mb-0 mt-4">
                                                <fmt:formatNumber type="number" value="${billDetail.unitCost}" />
                                                đ
                                            </p>
                                        </td>
                                        <td>
                                            <div class="input-group quantity mt-4" style="width: 100px;">
                                                <input type="text"
                                                       class="form-control form-control-sm text-center bbill-0"
                                                       value="${billDetail.quantity}"
                                                       disabled
                                                >
                                            </div>
                                        </td>
                                        <td>
                                            <p class="mb-0 mt-4" data-cart-detail-id="${cartDetail.id}">
                                                <fmt:formatNumber type="number"
                                                                  value="${billDetail.unitCost * billDetail.quantity}" /> đ
                                            </p>
                                        </td>
                                        <td></td>
                                    </tr>
                                </c:forEach>
                            </c:forEach>
                            </tbody>
                        </table>
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="/user/order-history?page=${currentPage-1}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <c:forEach begin="1" end="${pageNo}" var="i">
                                    <c:choose>
                                        <c:when test="${currentPage == i}">
                                            <li class="page-item active">
                                                <a class="page-link" href="/user/order-history?page=${i}">${i}</a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item">
                                                <a class="page-link" href="/user/order-history?page=${i}">${i}</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <li class="page-item ${currentPage == pageNo ? 'disabled' : ''}">
                                    <a class="page-link" href="/user/order-history?page=${currentPage + 1}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                        <span class="sr-only">Next</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div><!-- site__body / end -->
    </div><!-- site / end -->
</body>
