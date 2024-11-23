package gr.careplus4.services.impl;

import gr.careplus4.entities.*;
import gr.careplus4.repositories.*;
import gr.careplus4.services.GeneratedId;
import gr.careplus4.services.IBillService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
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

    @Override
    public Page<Bill> fetchAllBills(Pageable pageable) {
        return billRepository.findAll(pageable);
    }

    @Override
    public int getNumberOfPage(int pageSize) {
        int totalCategories = (int) billRepository.count();
        int countPage = (int) (totalCategories / pageSize);
        if (totalCategories % pageSize != 0) {
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
        updateBill.setStatus(bill.getStatus());
        billRepository.save(updateBill);
    }

    @Override
    public Optional<Bill> findById(String id) {
        return billRepository.findById(id);
    }


    @Override
    public void handlePlaceOrder(HttpSession session, String receiverName, String receiverAddress,
                                 String receiverPhone,  int usedPoint, String eventCode, boolean accumulate) {
        // step 1:
        Optional<Cart> cart = this.cartRepository.findByUser_PhoneNumber(receiverPhone);
        Optional<User> user = this.userService.findByPhoneNumber(receiverPhone);
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
                Bill order = new Bill();
                order.setId(GeneratedId.getGeneratedId(preBillId));
                order.setUser(user.get());
                order.setDate(new Date());
                order.setName(receiverName);
                order.setAddress(receiverAddress);
                order.setMethod("COD");
                order.setStatus("PENDING");
                order.setPointUsed(usedPoint);
                order.setEvent(event.get());
//                order.setTotalAmount(cart.get().getTotalAmount()); Nho note lai khong sau nay conflict

                order = this.billRepository.save(order);

                // create billDetail
                for (CartDetail cd : cartDetails) {
                    BillDetail orderDetail = new BillDetail();
                    orderDetail.setBill(order);
                    orderDetail.setMedicine(cd.getMedicine());
                    orderDetail.setUnitCost(cd.getUnitCost());
                    orderDetail.setQuantity(cd.getQuantity());
                    orderDetail.setSubTotal(cd.getSubTotal()); // gia nay la bao gom khi da giam
                    this.billDetailRepository.save(orderDetail);
                }

                BigDecimal sum = order.getTotalAmount();

                // accumulate point
                if (accumulate) {
                    int newPoint = sum.divide(BigDecimal.valueOf(10)).intValue();
                    user.get().setPointEarned(user.get().getPointEarned() + newPoint);
                    this.userService.save(user.get());
                }

                // step 2: delete cart_detail and cart
                for (CartDetail cd : cartDetails) {
                    this.cartDetailRepository.deleteById(cd.getId());
                }

                this.cartRepository.deleteById(cart.get().getId());

                // step 3 : update session
//                session.setAttribute("cartCount", 0);
            }
        }

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
}
