package gr.careplus4.services.impl;

import gr.careplus4.entities.*;
import gr.careplus4.models.RevenueRecordModel;
import gr.careplus4.repositories.*;
import gr.careplus4.services.GeneratedId;
import gr.careplus4.services.IBillService;
import gr.careplus4.services.specification.BillSpecification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class BillServiceImpl implements IBillService {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CartDetailRepository cartDetailRepository;

    @Autowired
    private BillRepository billRepository;

    @Autowired
    private BillDetailRepository billDetailRepository;

    @Autowired
    private UserServiceImpl userService;

    @Autowired
    private EventServiceImpl eventService;

    @Autowired
    private MedicineRepository medicineRepository;

    @Autowired
    private ImportRepository importRepository;

    @Autowired
    private MedicineCopyImpl medicineCopy;

    @Override
    public Page<Bill> fetchAllBills(Pageable pageable) {
        return billRepository.findAll(pageable);
    }

    @Override
    public Page<Bill> fetchBillsByUser(User user, Pageable pageable) {
        return this.billRepository.findAllBillsByUser(user, pageable);
    }

    @Override
    public Page<Bill> fetchProductsWithSpec(Pageable page, String status) {

        Specification<Bill> combinedSpec = Specification.where(null);

        if (status != null) {
            Specification<Bill> currentSpecs = BillSpecification.statusEquals(status);
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        return this.billRepository.findAll(combinedSpec, page);
    }

    @Override
    public int getNumberOfPage(int pageSize) {
        int totalBills = (int) billRepository.count();
        int countPage = (int) (totalBills / pageSize);
        if (totalBills % pageSize != 0) {
            countPage++;
        }
        return countPage;
    }

    @Override
    public int getNumberOfPageByUser(int pageSize, User user) {
        int totalBills = (int) billRepository.findBillsByUser(user).stream().count();
        int countPage = (int) (totalBills / pageSize);
        if (totalBills % pageSize != 0) {
            countPage++;
        }
        return countPage;
    }

    @Override
    public void deleteBill(Bill bill) {
        List<Long> idDetails = new ArrayList<>();
        for(BillDetail billDetail : bill.getBilDetails()) {
            idDetails.add(billDetail.getId());
        }

        for(Long id : idDetails) {
            billDetailRepository.deleteById(id);
        }

        billRepository.delete(bill);
    }

    @Override
    public void saveBill(Bill bill) {
        String id = bill.getId();
        Bill updateBill = billRepository.findById(id).get();
        if (bill.getStatus().equals("CANCELED") || bill.getStatus().equals("RETURNED")) {
            for (BillDetail billDetail : updateBill.getBilDetails()) {
                // update stock
                Optional<Medicine> medicine = this.medicineRepository.findById(billDetail.getMedicine().getId());
                int quantity = medicine.get().getStockQuantity() + billDetail.getQuantity();
                medicine.get().setStockQuantity(quantity);
                this.medicineRepository.save(medicine.get());
            }
        }
        updateBill.setStatus(bill.getStatus());
        Date date = new Date();
        updateBill.setUpdateDate(date);
        billRepository.save(updateBill);
    }

    @Override
    public Optional<Bill> findById(String id) {
        return billRepository.findById(id);
    }


    @Override
    public void handlePlaceOrder(String receiverName, String receiverAddress,
                                 String phone, int usedPoint, String eventCode, boolean accumulate, float shipping) {

        Optional<Cart> cart = this.cartRepository.findByUser_PhoneNumber(phone);
        Optional<User> user = this.userService.findByPhoneNumber(phone);
        Optional<Event> event = this.eventService.findById(eventCode);
        if (cart.isPresent()) {
            List<CartDetail> cartDetails = cart.get().getCartDetails();

            if (cartDetails != null) {
                // create bill
                List<Bill> bills = billRepository.findAll();
                String preBillId;
                if (!bills.isEmpty()) {
                    preBillId = bills.get(bills.size() - 1).getId();
                } else {
                    preBillId = "B000000";
                }

                float totalPrice = getTotalPrice(usedPoint, cartDetails, event, user);

                // Cộng tiền ship nếu có
                if(shipping > 0) {
                    totalPrice += shipping;
                }

                Date date = new Date();
                Bill order = new Bill();
                order.setId(GeneratedId.getGeneratedId(preBillId));
                order.setUser(user.get());
                order.setDate(date);
                order.setName(receiverName);
                order.setAddress(receiverAddress);
                order.setMethod("COD");
                order.setStatus("AWAIT");
                order.setPointUsed(usedPoint);
                if (event.isPresent()) {
                    order.setEvent(event.get());
                }
                order.setTotalAmount(BigDecimal.valueOf(totalPrice));

                order = this.billRepository.save(order);

                // create billDetail
                for (CartDetail cd : cartDetails) {
                    BillDetail orderDetail = new BillDetail();
                    orderDetail.setBill(order);
                    orderDetail.setMedicine(cd.getMedicine());
                    orderDetail.setUnitCost(cd.getUnitCost());
                    orderDetail.setQuantity(cd.getQuantity());
                    orderDetail.setSubTotal(cd.getSubTotal());
                    this.billDetailRepository.save(orderDetail);

                    // copy from ord -> medicine copy
                    this.medicineCopy.copyMedicineFromBillDetails(cd.getMedicine(), orderDetail);
                }

                BigDecimal sum = order.getTotalAmount();

                // accumulate point
                if (accumulate) {
                    int newPoint = (int) sum.floatValue() / 1000;
                    user.get().setPointEarned(user.get().getPointEarned() + newPoint);
                    this.userService.save(user.get());
                }

                // update stock
                for (CartDetail cd : cartDetails) {
                    Optional<Medicine> medicine = this.medicineRepository.findById(cd.getMedicine().getId());
                    int quantity = medicine.get().getStockQuantity() - cd.getQuantity();
                    medicine.get().setStockQuantity(quantity);
                    this.medicineRepository.save(medicine.get());
                }

                // delete cart_detail and cart
                for (CartDetail cd : cartDetails) {
                    this.cartDetailRepository.deleteById(cd.getId());
                }
                this.cartRepository.deleteById(cart.get().getId());
            }
        }

    }

    private float getTotalPrice(int usedPoint, List<CartDetail> cartDetails, Optional<Event> event, Optional<User> user) {
        float totalPrice = 0;
        float discount = 0;

        if (!cartDetails.isEmpty()) {
            for (CartDetail cd : cartDetails) {
                totalPrice += cd.getSubTotal().floatValue();
            }

            if (usedPoint > 0) {
                // (Số điểm sử dụng / 10) × 1.000
                discount += (float) (usedPoint * 1000) / 10;
                if (discount > (totalPrice * 0.3)) {
                    discount = (float) (totalPrice * 0.3);
                }
                // Cập nhật ngay lại số điểm mà người dùng đã sử dụng
                user.get().setPointEarned(0);
                this.userService.save(user.get());
            }

            if (event.isPresent() && event.get().getDiscount().intValue() != 0) {
                discount += totalPrice * event.get().getDiscount().floatValue() / 100;
            }

            totalPrice -= discount;
        }
        return totalPrice;
    }

    @Override
    public List<Bill> findBillsByUserAndDateBetween(User user, Date startDate, Date endDate) {
        List<Bill> bills = billRepository.findBillsByUser(user);
        List<Bill> result = new ArrayList<>();
        for (Bill bill : bills) {
            if (bill.getDate().after(startDate) && bill.getDate().before(endDate)) {
                result.add(bill);
            }
        }
        return result;
    }

    @Override
    public Page<Bill> findByIdContaining(String id, Pageable pageable) {
        return this.billRepository.findByIdContaining(id, pageable);
    }

    @Override
    public List<Bill> findBillsByDate(Date date) {
        return billRepository.findBillsByDate(date);
    }

    @Override
    public List<Bill> findBillsByDateBetween(Date startDate, Date endDate) {
        return billRepository.findBillsByDateBetween(startDate, endDate);
    }

    @Override
    public List<Bill> findBillsForWeek() {
        LocalDate today = LocalDate.now();
        LocalDate startOfWeek = today.with(DayOfWeek.MONDAY);
        LocalDate endOfWeek = today.with(DayOfWeek.SUNDAY);

        return billRepository.findBillsByDateBetween(java.sql.Date.valueOf(startOfWeek), java.sql.Date.valueOf(endOfWeek));
    }

    @Override
    public Page<Bill> findAll(Pageable pageable) {
        return this.billRepository.findAll(pageable);
    }

    @Override
    public BigDecimal getRevenueToday() {
        LocalDate today = LocalDate.now();
        Date startDate = java.sql.Date.valueOf(today);

        List<Bill> bills = billRepository.findBillsByDate(startDate);

        if (bills.isEmpty()) {
            return new BigDecimal(0);
        }

        BigDecimal revenue = new BigDecimal(0);
        for (Bill bill : bills) {
            revenue = revenue.add(bill.getTotalAmount());
        }
        return revenue;
    }

    @Override
    public BigDecimal getRevenueForWeek() {
        LocalDate today = LocalDate.now();
        LocalDate startDate = today.with(DayOfWeek.MONDAY);
        LocalDate endDate = today.with(DayOfWeek.SUNDAY);

        List<Bill> bills = billRepository.findBillsByDateBetween(java.sql.Date.valueOf(startDate), java.sql.Date.valueOf(endDate));

        if (bills.isEmpty()) {
            return new BigDecimal(0);
        }

        BigDecimal revenue = new BigDecimal(0);
        for (Bill bill : bills) {
            revenue = revenue.add(bill.getTotalAmount());
        }

        return revenue;
    }

    @Override
    public BigDecimal getRevenueForMonth() {
        LocalDate today = LocalDate.now();
        LocalDate startDate = today.withDayOfMonth(1);
        LocalDate endDate = today.withDayOfMonth(today.lengthOfMonth());

        List<Bill> bills = billRepository.findBillsByDateBetween(java.sql.Date.valueOf(startDate), java.sql.Date.valueOf(endDate));

        if (bills.isEmpty()) {
            return new BigDecimal(0);
        }

        BigDecimal revenue = new BigDecimal(0);
        for (Bill bill : bills) {
            revenue = revenue.add(bill.getTotalAmount());
        }

        return revenue;
    }

    @Override
    public BigDecimal getRevenueForSeason() {
        LocalDate today = LocalDate.now();
        int month = today.getMonthValue();
        int season = (month - 1) / 3 + 1;

        LocalDate startDate = today.withMonth((season - 1) * 3 + 1).withDayOfMonth(1);
        LocalDate endDate = today.withMonth(season * 3).withDayOfMonth(today.withMonth(season * 3).lengthOfMonth());

        List<Bill> bills = billRepository.findBillsByDateBetween(java.sql.Date.valueOf(startDate), java.sql.Date.valueOf(endDate));

        if (bills.isEmpty()) {
            return new BigDecimal(0);
        }

        BigDecimal revenue = new BigDecimal(0);
        for (Bill bill : bills) {
            revenue = revenue.add(bill.getTotalAmount());
        }

        return revenue;
    }

    @Override
    public BigDecimal getRevenueForPeriod(java.sql.Date startDate, java.sql.Date endDate) {
        List<Bill> bills = billRepository.findBillsByDateBetween(startDate, endDate);

        if (bills.isEmpty()) {
            return new BigDecimal(0);
        }

        BigDecimal revenue = new BigDecimal(0);
        for (Bill bill : bills) {
            revenue = revenue.add(bill.getTotalAmount());
        }

        return revenue;
    }

    @Override
    public BigDecimal getProfitForPeriod(java.sql.Date startDate, java.sql.Date endDate) {
        List<Import> imports = importRepository.findImportByDateBetween(startDate, endDate);

        if (imports.isEmpty()) {
            return getRevenueForPeriod(startDate, endDate);
        }

        BigDecimal profit = getRevenueForPeriod(startDate, endDate);
        for (Import anImport : imports) {
            profit = profit.subtract(anImport.getTotalAmount());
        }

        return profit;
    }

    @Override
    public BigDecimal getRevenueDaily(java.sql.Date date) {
        List<Bill> bills = billRepository.findBillsByDate(date);

        if (bills.isEmpty()) {
            return new BigDecimal(0);
        }

        BigDecimal revenue = new BigDecimal(0);
        for (Bill bill : bills) {
            revenue = revenue.add(bill.getTotalAmount());
        }
        return revenue;
    }

    @Override
    public BigDecimal getDailyProfit(java.sql.Date date) {
        List<Import> imports = importRepository.findImportByDate(date);

        if (imports.isEmpty()) {
            return getRevenueDaily(date);
        }

        BigDecimal profit = getRevenueDaily(date);

        for (Import anImport : imports) {
            profit = profit.subtract(anImport.getTotalAmount());
        }

        return profit;
    }

    @Override
    public List<RevenueRecordModel> getRevenueRecordForWeek() {
        // Lấy ngày hôm nay
        LocalDate today = LocalDate.now();

        // Tìm ngày Thứ Hai của tuần hiện tại
        LocalDate startOfWeek = today.with(DayOfWeek.MONDAY);

        // Tìm ngày Chủ Nhật của tuần hiện tại
        LocalDate endOfWeek = today.with(DayOfWeek.SUNDAY);

        // Khởi tạo danh sách để chứa kết quả
        List<RevenueRecordModel> revenueRecords = new ArrayList<>();

        // Lặp qua từng ngày từ Thứ Hai đến Chủ Nhật
        for (LocalDate date = startOfWeek; !date.isAfter(endOfWeek); date = date.plusDays(1)) {
            // Chuyển LocalDate sang java.sql.Date
            java.sql.Date sqlDate = java.sql.Date.valueOf(date);

            // Tạo một bản ghi doanh thu
            RevenueRecordModel record = new RevenueRecordModel(
                    sqlDate,
                    getRevenueDaily(sqlDate),   // Hàm tính doanh thu hàng ngày
                    getDailyProfit(sqlDate)     // Hàm tính lợi nhuận hàng ngày
            );

            // Thêm bản ghi vào danh sách
            revenueRecords.add(record);
        }

        return revenueRecords;
    }

    @Override
    public List<RevenueRecordModel> getRevenueRecordForMonth() {
        // Lấy ngày hôm nay
        LocalDate today = LocalDate.now();

        // Tìm ngày đầu tiên của tháng hiện tại
        LocalDate startOfMonth = today.withDayOfMonth(1);

        // Tìm ngày cuối cùng của tháng hiện tại
        LocalDate endOfMonth = today.withDayOfMonth(today.lengthOfMonth());

        // Khởi tạo danh sách để chứa kết quả
        List<RevenueRecordModel> revenueRecords = new ArrayList<>();

        // Lặp qua từng ngày từ ngày đầu tiên đến ngày cuối cùng của tháng
        for (LocalDate date = startOfMonth; !date.isAfter(endOfMonth); date = date.plusDays(1)) {
            // Chuyển LocalDate sang java.sql.Date
            java.sql.Date sqlDate = java.sql.Date.valueOf(date);

            // Tạo một bản ghi doanh thu
            RevenueRecordModel record = new RevenueRecordModel(
                    sqlDate,
                    getRevenueDaily(sqlDate),   // Hàm tính doanh thu hàng ngày
                    getDailyProfit(sqlDate)     // Hàm tính lợi nhuận hàng ngày
            );

            // Thêm bản ghi vào danh sách
            revenueRecords.add(record);

        }

        return revenueRecords;
    }

    @Override
    public List<RevenueRecordModel> getRevenueRecordForSeason() {
        // Lấy ngày hôm nay
        LocalDate today = LocalDate.now();

        // Tính mùa hiện tại
        int month = today.getMonthValue();
        int season = (month - 1) / 3 + 1;

        // Tìm ngày đầu tiên của mùa hiện tại
        LocalDate startOfSeason = today.withMonth((season - 1) * 3 + 1).withDayOfMonth(1);

        // Tìm ngày cuối cùng của mùa hiện tại
        LocalDate endOfSeason = today.withMonth(season * 3).withDayOfMonth(today.withMonth(season * 3).lengthOfMonth());

        // Khởi tạo danh sách để chứa kết quả
        List<RevenueRecordModel> revenueRecords = new ArrayList<>();

        // Nhóm dữ liệu theo tuần
        LocalDate startOfWeek = startOfSeason;
        while (!startOfWeek.isAfter(endOfSeason)) {
            // Ngày cuối tuần (Chủ nhật)
            LocalDate endOfWeek = startOfWeek.plusDays(6);
            if (endOfWeek.isAfter(endOfSeason)) {
                endOfWeek = endOfSeason; // Giới hạn trong mùa
            }

            // Tính tổng doanh thu và lợi nhuận trong tuần
            java.sql.Date sqlStartOfWeek = java.sql.Date.valueOf(startOfWeek);
            java.sql.Date sqlEndOfWeek = java.sql.Date.valueOf(endOfWeek);

            BigDecimal weeklyRevenue = getRevenueForPeriod(sqlStartOfWeek, sqlEndOfWeek); // Hàm lấy doanh thu trong tuần
            BigDecimal weeklyProfit = getProfitForPeriod(sqlStartOfWeek, sqlEndOfWeek);   // Hàm lấy lợi nhuận trong tuần

            // Tạo một bản ghi doanh thu
            RevenueRecordModel record = new RevenueRecordModel(
                    java.sql.Date.valueOf(startOfWeek), // Tuần bắt đầu
                    weeklyRevenue,
                    weeklyProfit
            );

            // Thêm bản ghi vào danh sách
            revenueRecords.add(record);

            // Chuyển sang tuần tiếp theo
            startOfWeek = startOfWeek.plusWeeks(1);
        }

        return revenueRecords;
    }

    @Override
    public int countBillIsStatusAwaiting() {
        List<Bill> bills = billRepository.findBillsByStatus("AWAIT");
        return bills.size();
    }

    @Override
    public int countBillIsStatusShipping() {
        List<Bill> bills = billRepository.findBillsByStatus("SHIPPING");
        return bills.size();
    }

    @Override
    public List<Bill> findALl() {
        return billRepository.findAll();
    }

    @Override
    public Page<Bill> findBillsByStatus(String status, Pageable pageable) {
        return billRepository.findBillsByStatus(status, pageable);
    }

    @Override
    public int countAllStatus(String status) {
        if (status.isEmpty()) {
            return (int) billRepository.count();
        }

        List<Bill> bills = billRepository.findBillsByStatus(status);
        return bills.size();
    }
}
