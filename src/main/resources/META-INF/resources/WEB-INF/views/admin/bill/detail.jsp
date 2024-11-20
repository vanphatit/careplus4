<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<body class="sb-nav-fixed">
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Bill</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/bills">Bills</a></li>
                    <li class="breadcrumb-item active">View details</li>
                </ol>
                <div class="container mt-5">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <div class="d-flex justify-content-between">
                                <h3>Bill detail with id = ${bill.id}</h3>
                            </div>

                            <hr />
                            <div class="card-header">
                                Bill information
                            </div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">ID: ${bill.id}</li>
                                <li class="list-group-item">Receiver: ${bill.name}</li>
                                <li class="list-group-item">Address: ${bill.address}</li>
                                <li class="list-group-item">Create date: ${bill.date}</li>
                                <li class="list-group-item">Method: ${bill.method}</li>
                                <li class="list-group-item">Total: ${bill.totalAmount}</li>
                                <li class="list-group-item">Event Code: ${bill.event.id}</li>
                                <li class="list-group-item">Status: ${bill.status}</li>
                            </ul>
                        </div>
                    </div>
                    <a href="/admin/bills" class="btn btn-info mt-3">Back</a>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
</body>

</html>