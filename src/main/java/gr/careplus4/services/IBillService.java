package gr.careplus4.services;

import gr.careplus4.entities.Bill;
import gr.careplus4.entities.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Date;
import java.util.List;
import java.util.Optional;

public interface IBillService {
    Page<Bill> fetchAllBills(Pageable pageable);
    int getNumberOfPage(int pageSize);
    void deleteBill(Bill bill);
    void saveBill(Bill bill);
    Optional<Bill> findById(String id);
    void handlePlaceOrder(HttpSession session, String receiverName,String receiverAddress, String receiverPhone, int usedPoint, String eventCode, boolean accumulate);
    List<Bill> findBillsByUserAndDateBetween(User user, Date startDate, Date endDate);
}
