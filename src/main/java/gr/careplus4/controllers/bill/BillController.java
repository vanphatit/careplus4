package gr.careplus4.controllers.bill;

import gr.careplus4.entities.Bill;
import gr.careplus4.entities.User;
import gr.careplus4.services.PackageService;
import gr.careplus4.services.impl.BillServiceImpl;
import gr.careplus4.services.security.JwtCookies;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/user")
@Controller
public class BillController {
    @Autowired
    BillServiceImpl billService = new BillServiceImpl();

    @Autowired
    private JwtCookies jwtCookies;

    @Autowired
    private PackageService packageService;

    @PostMapping("/place-order")
    public String handlePlaceOrder(HttpServletRequest request,@RequestParam("receiverName") String receiverName,
                                   @RequestParam("receiverAddress") String receiverAddress,
                                   @RequestParam("usedPoint") int usedPoint,
                                   @RequestParam("eventCode") String eventCode,
                                   @RequestParam("province") String province,
                                   @RequestParam("shippingFee") String shippingFee,
                                   @RequestParam("accumulate") boolean accumulate) {
        String phone = jwtCookies.getUserPhoneFromJwt(request);

        String address = receiverAddress + ", " + province;

        float shipping = 0;
        if (shippingFee != null) {
            shipping = Float.parseFloat(shippingFee);
        }

        this.billService.handlePlaceOrder(receiverName, address, phone, usedPoint,
                eventCode, accumulate, shipping);

        return "redirect:/user/thanks";
    }

    @GetMapping("/thanks")
    public String getThanksPage(Model model) {
        return "user/thanks";
    }

    @GetMapping("/order-history")
    public String getOrderHistoryPage(Model model, HttpServletRequest request,
                                      @RequestParam(defaultValue = "1") int page) {
        User user = new User();
        String phone = jwtCookies.getUserPhoneFromJwt(request);
        user.setPhoneNumber(phone);

        int pageSize = 3;
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        Page<Bill> billPage = this.billService.fetchBillsByUser(user, pageable);
        List<Bill> bills = billPage.getContent();
        for(Bill bill : bills) {
            if(bill.getStatus().equals("SHIPPING")){
                String status = packageService.checkStatusAPI(bill.getId());
                if(status != null){
                    bill.setStatus(status);
                    billService.saveBill(bill);
                }
            }
        }
        int numberPages = this.billService.getNumberOfPageByUser(pageSize, user);
        model.addAttribute("bills", bills);
        model.addAttribute("pageNo", numberPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("id", phone);

        return "user/cart/order-history";
    }

    @PostMapping("updateStatus")
    public String handleUpdateBillStatus(
            @ModelAttribute("newBill") @Valid Bill bill,
            BindingResult newProductBindingResult) {

        this.billService.saveBill(bill);

        return "redirect:/user/order-history";
    }
}
