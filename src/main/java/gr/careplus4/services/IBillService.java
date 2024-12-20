package gr.careplus4.services;

import gr.careplus4.entities.Bill;
import gr.careplus4.entities.User;
import gr.careplus4.models.RevenueRecordModel;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.math.BigDecimal;
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

    void handlePlaceOrder(String receiverName,String receiverAddress, String phone, int usedPoint, String eventCode, boolean accumulate, float shipping);

    List<Bill> findBillsByUserAndDateBetween(User user, Date startDate, Date endDate);

    Page<Bill> findByIdContaining(String id, Pageable pageable);

    List<Bill> findBillsByDate(Date date);

    Page<Bill> fetchProductsWithSpec(Pageable page, String status);

    List<Bill> findBillsByUpdateDate(java.sql.Date date);

    List<Bill> findBillsByDateBetween(Date startDate, Date endDate);

    List<Bill> findBillsByUpdateDateBetween(java.sql.Date startDate, java.sql.Date endDate);

    List<Bill> findBillsForWeek();

    Page<Bill> findAll(Pageable pageable);

    BigDecimal getRevenueToday();

    BigDecimal getRevenueForWeek();

    BigDecimal getRevenueForMonth();

    BigDecimal getRevenueForSeason();

    BigDecimal getRevenueForPeriod(java.sql.Date startDate, java.sql.Date endDate);

    BigDecimal getProfitForPeriod(java.sql.Date startDate, java.sql.Date endDate);

    BigDecimal getRevenueDaily(java.sql.Date date);

    BigDecimal getDailyProfit(java.sql.Date date);

    List<RevenueRecordModel> getRevenueRecordForWeek();

    List<RevenueRecordModel> getRevenueRecordForMonth();

    List<RevenueRecordModel> getRevenueRecordForSeason();

    int countBillIsStatusAwaiting();

    int countBillIsStatusShipping();

    List<Bill> findALl();

    Page<Bill> findBillsByStatus(String status, Pageable pageable);

    int countAllStatus(String status);
}
