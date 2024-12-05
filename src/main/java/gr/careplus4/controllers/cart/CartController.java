package gr.careplus4.controllers.cart;

import gr.careplus4.entities.Cart;
import gr.careplus4.entities.CartDetail;
import gr.careplus4.entities.Event;
import gr.careplus4.entities.User;
import gr.careplus4.models.EventModel;
import gr.careplus4.services.impl.CartServiceImpl;
import gr.careplus4.services.impl.EventServiceImpl;
import gr.careplus4.services.impl.UserServiceImpl;
import gr.careplus4.services.security.JwtCookies;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/user")
public class CartController {
    @Autowired
    private CartServiceImpl cartService;

    @Autowired
    private EventServiceImpl eventService;

    @Autowired
    private UserServiceImpl userService;

    @Autowired
    private JwtCookies jwtCookies;

    @PostMapping("/add-medicine-to-cart/{id}")
    public String addMedicineToCart(@PathVariable String id, @RequestParam("quantity") int quantity, HttpServletRequest request) {

        String phone = jwtCookies.getUserPhoneFromJwt(request);

        this.cartService.handleAddProductToCart(phone, id, quantity);
        return "redirect:/user/medicines";
    }

    @PostMapping("/add-medicine-from-view-detail")
    public String handleAddMedicineFromViewDetail(
            @RequestParam("id") String id,
            @RequestParam("quantity") int quantity,
            HttpServletRequest request) {
        String phone = jwtCookies.getUserPhoneFromJwt(request);

        this.cartService.handleAddProductToCart(phone, id, quantity);
        return "redirect:/user/medicine/" + id;
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        User currentUser = new User();

        String phone = jwtCookies.getUserPhoneFromJwt(request);

        currentUser.setPhoneNumber(phone);

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

        Date date = new Date();

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

        return "user/cart/cart-show";
    }

    @PostMapping("/confirm-checkout")
    public String getCheckOutPage(@ModelAttribute("cart") Cart cart,
                                  @RequestParam("code") String code,
                                  @RequestParam("usedPoint") boolean usedPoint,
                                  HttpServletRequest request) {
        User currentUser = new User();
        String phone = jwtCookies.getUserPhoneFromJwt(request);
        currentUser.setPhoneNumber(phone);

        Cart currentCart = this.cartService.findCartByUser(currentUser);
        String cartId = currentCart.getId();
        List<CartDetail> cartDetails = cart == null ? new ArrayList<>() : cart.getCartDetails();
        this.cartService.handleUpdateCartBeforeCheckout(cartId, cartDetails, code, usedPoint);
        return "redirect:/user/checkout";
    }

    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {

        String phone = jwtCookies.getUserPhoneFromJwt(request);

        Optional<User> currentUser = this.userService.findByPhoneNumber(phone);
        currentUser.get().setPhoneNumber(phone);

        Cart cart = this.cartService.findCartByUser(currentUser.orElse(null));

        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        float totalPrice = 0;
        float subPrice = 0;
        float discount = 0;
        int percentage = 0;
        int usedPoints = 0;

        if (cartDetails != null && !cartDetails.isEmpty()) {
            for (CartDetail cd : cartDetails) {
                subPrice += cd.getSubTotal().floatValue();
            }

            Optional<Event> event = this.eventService.findById(cart.getCouponCode());

            if (cart.getUsedPoint()) {
                usedPoints = currentUser.get().getPointEarned();
                //(Số điểm sử dụng / 10) × 1.000
                discount += (float) (currentUser.get().getPointEarned() * 1000) / 10;
            }

            if (event.isPresent() && event.get().getDiscount().intValue() != 0) {
                percentage = event.get().getDiscount().intValue();
                discount += subPrice * event.get().getDiscount().floatValue() / 100;
            }
            totalPrice = subPrice - discount;

        } else {
            cartDetails = new ArrayList<>();
        }
        model.addAttribute("discount", BigDecimal.valueOf(discount));
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("subPrice", BigDecimal.valueOf(subPrice));
        model.addAttribute("totalPrice", BigDecimal.valueOf(totalPrice));
        model.addAttribute("percentageDiscount", percentage);
        model.addAttribute("usedPoints", usedPoints);
        model.addAttribute("code", cart.getCouponCode());

        return "user/cart/checkout";
    }

}
