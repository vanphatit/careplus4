package gr.careplus4.controllers.admin;

import gr.careplus4.models.PackageModel;
import gr.careplus4.models.Response;
import gr.careplus4.models.TransactionHistoryModel;
import gr.careplus4.services.PackageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("v1/api/packages")
public class getPackages {

    @Autowired
    private PackageService packageService;

    @GetMapping
    public ResponseEntity<Response> getPackages() {

        // Gọi Service để lấy dữ liệu từ `careplus4_shipping`
        PackageService PackageService = new PackageService();
        List<PackageModel> packages = PackageService.findAllFromShippingApi();

        // Chuyển đổi từ PackageModel sang TransactionHistoryModel
        List<TransactionHistoryModel> transactionHistoryModels = packages.stream().map(pkg -> {
            TransactionHistoryModel model = new TransactionHistoryModel();
            model.setIdBill(pkg.getIdBill());                // Mapping ID Bill
            model.setUserPhone(pkg.getUserPhone());          // Mapping Số điện thoại người dùng
            model.setReceiverName(pkg.getReceiverName());    // Mapping Tên người nhận
            model.setTotalAmount(pkg.getTotalAmount());      // Mapping Tổng tiền
            model.setDate(pkg.getDate());                    // Mapping Ngày tạo đơn
            model.setDeliveryDate(pkg.getUpdateDate());    // Mapping Ngày giao hàng
            model.setStatus(pkg.getStatus());                // Mapping Trạng thái
            return model;
        }).collect(Collectors.toList());

        // Tạo Response để trả về
        Response response = new Response(true, "Lấy danh sách thành công", transactionHistoryModels);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
