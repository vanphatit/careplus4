package gr.careplus4.controllers.bill;

import gr.careplus4.services.impl.BillServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class BillController {
    @Autowired
    BillServiceImpl billService = new BillServiceImpl();

    @PostMapping("/place-order")
    public String handlePlaceOrder(HttpServletRequest request,@RequestParam("receiverName") String receiverName,
                                   @RequestParam("receiverAddress") String receiverAddress,
                                   @RequestParam("receiverPhone") String receiverPhone,
                                   @RequestParam("usedPoint") int usedPoint,
                                   @RequestParam("eventCode") String eventCode,
                                   @RequestParam("accumulate") boolean accumulate
                                   ) {

        HttpSession session = request.getSession(false);

        this.billService.handlePlaceOrder(session, receiverName, receiverAddress, receiverPhone, usedPoint,
                eventCode, accumulate);

        return "redirect:/thanks";
    }

    @GetMapping("/thanks")
    public String getThanksPage(Model model) {
        return "user/cart/thanks";
    }
}
