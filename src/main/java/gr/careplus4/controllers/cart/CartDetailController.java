package gr.careplus4.controllers.cart;

import gr.careplus4.services.impl.CartDetailServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class CartDetailController {
    @Autowired
    private CartDetailServiceImpl cartDetailService;
    @PostMapping("/delete-cart-detail/{id}")
    public String postMethodName(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        this.cartDetailService.handleRemoveCartDetail(id, session);
        return "redirect:/cart";
    }
}
