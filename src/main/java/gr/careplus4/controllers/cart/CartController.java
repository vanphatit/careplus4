package gr.careplus4.controllers.cart;

import gr.careplus4.entities.Cart;
import gr.careplus4.entities.CartDetail;
import gr.careplus4.entities.Event;
import gr.careplus4.entities.User;
import gr.careplus4.models.EventModel;
import gr.careplus4.services.impl.CartServiceImpl;
import gr.careplus4.services.impl.EventServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class CartController {
    @Autowired
    private CartServiceImpl cartService;

    @Autowired
    private EventServiceImpl eventService;

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        User currentUser = new User();
        HttpSession session = request.getSession(false);

//        long userId = (Long) session.getAttribute("id");
        currentUser.setPhoneNumber("0903456782");

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

        LocalDate localDate = LocalDate.now();

        Date date = Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());

        List<Event> eventList = this.eventService.getActiveEvents(date);

        List<EventModel> events = new ArrayList<>();

        for (Event event : eventList) {
            EventModel eventModel = new EventModel();
            eventModel.setId(event.getId());
            int discount = event.getDiscount().intValue();
            if (discount > 0) {
                eventModel.setName(event.getName() + '-' + discount + '%');
            } else {
                eventModel.setName(event.getName());
            }
            eventModel.setDateStart(event.getDateStart());
            eventModel.setDateEnd(event.getDateEnd());
            eventModel.setDiscount(event.getDiscount());
            events.add(eventModel);
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cart", cart);
        model.addAttribute("events", events);

        return "/user/cart/cart-show";
    }

    @PostMapping("/confirm-checkout")
    public String getCheckOutPage(@ModelAttribute("cart") Cart cart, @RequestParam("code") String code) {
        User currentUser = new User(); // Tam thoi
        currentUser.setPhoneNumber("0903456782");

        Cart currentCart = this.cartService.findCartByUser(currentUser);
        String cartId = currentCart.getId();
        List<CartDetail> cartDetails = cart == null ? new ArrayList<>() : cart.getCartDetails();
        this.cartService.handleUpdateCartBeforeCheckout(cartId, cartDetails, code);
        return "redirect:/checkout";
    }
}
