package gr.careplus4.controllers.bill;

import gr.careplus4.entities.Bill;
import gr.careplus4.entities.User;
import gr.careplus4.services.impl.BillServiceImpl;
import gr.careplus4.services.security.JwtCookies;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@RequestMapping("/user")
@Controller
public class BillController {
    @Autowired
    BillServiceImpl billService = new BillServiceImpl();

    @Autowired
    private JwtCookies jwtCookies;

    @PostMapping("/place-order")
    public String handlePlaceOrder(HttpServletRequest request,@RequestParam("receiverName") String receiverName,
                                   @RequestParam("receiverAddress") String receiverAddress,
                                   @RequestParam("usedPoint") int usedPoint,
                                   @RequestParam("eventCode") String eventCode,
                                   @RequestParam("accumulate") boolean accumulate
                                   ) {
        String phone = jwtCookies.getUserPhoneFromJwt(request);

        this.billService.handlePlaceOrder(receiverName, receiverAddress, phone, usedPoint,
                eventCode, accumulate);

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
        int numberPages = this.billService.getNumberOfPageByUser(pageSize, user);
        model.addAttribute("bills", bills);
        model.addAttribute("pageNo", numberPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("id", phone);

        return "user/cart/order-history";
    }
}
