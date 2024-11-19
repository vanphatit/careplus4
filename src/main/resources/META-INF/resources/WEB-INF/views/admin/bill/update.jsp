<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<body class="sb-nav-fixed">
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Update Bill</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/bills">Bills</a></li>
                    <li class="breadcrumb-item active">Update</li>
                </ol>
                <div class="container mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <h3>Update Status</h3>
                            <hr />
                            <form method="POST" action="/admin/bill/update" class="row">
                                <!-- ID -->
                                <div class="mb-3 col-12" >
                                    <label class="form-label">Id:</label>
                                    <input type="text" class="form-control" name="id" value="${currentBill.id}" readonly/>
                                </div>

                                <!-- Status -->
                                <div class="mb-3 col-12">
                                    <label class="form-label">Status:</label>
                                    <select class="form-control" name="status">
                                        <option value="PENDING" ${currentBill.status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                                        <option value="PROCESSING" ${currentBill.status == 'PROCESSING' ? 'selected' : ''}>PROCESSING</option>
                                        <option value="COMPLETED" ${currentBill.status == 'COMPLETED' ? 'selected' : ''}>COMPLETED</option>
                                    </select>
                                </div>

                                <!-- Submit Button -->
                                <div class="col-12">
                                    <button type="submit" class="btn btn-warning">Update Status</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>

</html>
