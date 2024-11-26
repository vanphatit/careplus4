package gr.careplus4.controllers.cart;

import gr.careplus4.entities.Cart;
import gr.careplus4.entities.CartDetail;
import gr.careplus4.entities.Event;
import gr.careplus4.entities.User;
import gr.careplus4.models.EventModel;
import gr.careplus4.services.impl.CartServiceImpl;
import gr.careplus4.services.impl.EventServiceImpl;
import gr.careplus4.services.impl.UserServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
public class CartController {
    @Autowired
    private CartServiceImpl cartService;

    @Autowired
    private EventServiceImpl eventService;

    @Autowired
    private UserServiceImpl userService;

    @GetMapping("/add-medicine-to-cart/{id}")
    public String addMedicineToCart(@PathVariable String id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);

//        String phone = (String) session.getAttribute("phone");
        String phone = "0903456782"; // de test thoi mot goi session

        this.cartService.handleAddProductToCart(phone, id, session);
        return "redirect:/";
    }

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

        return "user/cart/cart-show";
    }

    @PostMapping("/confirm-checkout")
    public String getCheckOutPage(@ModelAttribute("cart") Cart cart, @RequestParam("code") String code, @RequestParam("usedPoint") boolean usedPoint) {
        User currentUser = new User(); // Tam thoi
        currentUser.setPhoneNumber("0903456782");

        Cart currentCart = this.cartService.findCartByUser(currentUser);
        String cartId = currentCart.getId();
        List<CartDetail> cartDetails = cart == null ? new ArrayList<>() : cart.getCartDetails();
        this.cartService.handleUpdateCartBeforeCheckout(cartId, cartDetails, code, usedPoint);
        return "redirect:/checkout";
    }

    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {
//        User currentUser = new User();// null
//        HttpSession session = request.getSession(false);
//        long id = (long) session.getAttribute("id");
//        currentUser.setId(id);

        Optional<User> currentUser = this.userService.findByPhoneNumber("0903456782");

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
                totalPrice = subPrice - discount;
            } else {
                totalPrice = subPrice;
            }
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
