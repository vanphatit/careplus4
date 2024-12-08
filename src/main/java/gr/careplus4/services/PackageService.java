package gr.careplus4.services;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import gr.careplus4.models.ApiResponse;
import gr.careplus4.models.PackageModel;
import gr.careplus4.models.TransactionHistoryModel;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class PackageService {

    public List<PackageModel> findAllFromShippingApi() {
        String externalApiUrl = "http://localhost:8080/v1/api/packages";

        RestTemplate restTemplate = new RestTemplate();

        // Ánh xạ JSON phản hồi thành ApiResponse
        ResponseEntity<ApiResponse<List<PackageModel>>> response = restTemplate.exchange(
                externalApiUrl,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<ApiResponse<List<PackageModel>>>() {}
        );

        ApiResponse<List<PackageModel>> apiResponse = response.getBody();

        if (apiResponse != null && apiResponse.isStatus()) {
            return apiResponse.getData();
        } else {
            throw new RuntimeException("Không thể lấy dữ liệu từ API: " + (apiResponse != null ? apiResponse.getMessage() : "Không có phản hồi"));
        }
    }

    // Nếu bạn gọi API từ `careplus4_shipping` để lấy dữ liệu giao dịch
    public List<TransactionHistoryModel> findAllTransactionHistory() {
        // Gọi API từ careplus4_shipping
        List<PackageModel> packages = findAllFromShippingApi();

        // Chuyển đổi từ PackageModel sang TransactionHistoryModel
        return packages.stream().map(pkg -> {
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
    }
}

