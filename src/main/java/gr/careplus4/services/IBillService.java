package gr.careplus4.services;

import gr.careplus4.entities.Bill;
import gr.careplus4.entities.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Date;
import java.util.List;
import java.util.Optional;

public interface IBillService {
    Page<Bill> fetchAllBills(Pageable pageable);
    Page<Bill> fetchBillsByUser(User user, Pageable pageable);
    int getNumberOfPage(int pageSize);
    int getNumberOfPageByUser(int pageSize, User user);
    void deleteBill(Bill bill);
    void saveBill(Bill bill);
    Optional<Bill> findById(String id);
    void handlePlaceOrder(String receiverName,String receiverAddress, String phone, int usedPoint, String eventCode, boolean accumulate);
    List<Bill> findBillsByUserAndDateBetween(User user, Date startDate, Date endDate);
    Page<Bill> findByIdContaining(String id, Pageable pageable);
    Page<Bill> findAll(Pageable pageable);
}
