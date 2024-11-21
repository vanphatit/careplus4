package gr.careplus4.controllers.cart;

import gr.careplus4.entities.Cart;
import gr.careplus4.entities.CartDetail;
import gr.careplus4.entities.User;
import gr.careplus4.services.impl.CartServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Controller
public class CartController {
    @Autowired
    private CartServiceImpl cartService;

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        User currentUser = new User();
        HttpSession session = request.getSession(false);

//        long userId = (Long) session.getAttribute("id");
        currentUser.setPhoneNumber("0902345671");

        Cart cart = this.cartService.findCartByUser(currentUser);

        List<CartDetail> cartDetails = cart.getCartDetails();

        BigDecimal totalPrice = BigDecimal.valueOf(0);

        if (cartDetails != null && !cartDetails.isEmpty()) {
            for (CartDetail cd : cartDetails) {
                totalPrice = totalPrice.add(cd.getSubTotal());
            }
        } else {
            cartDetails = new ArrayList<>();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cart", cart);

        return "/user/cart/cart-show";
    }
}
