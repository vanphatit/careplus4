package gr.careplus4.controllers.cart.api;

import gr.careplus4.entities.Cart;
import gr.careplus4.entities.Category;
import gr.careplus4.models.Response;
import gr.careplus4.services.impl.CartServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequestMapping("v1/api/cart")
public class CartAPI {
    @Autowired
    CartServiceImpl cartService;

    @GetMapping("/getCart")
    public ResponseEntity<?> getCartByPhoneNumber(@RequestParam("phoneNumber") String phoneNumber) {
        Optional<Cart> cart = cartService.findById(phoneNumber);
        if (cart.isPresent()) {
            return new ResponseEntity<Response>(new Response(true,
                    "Thành công", cart.get()), HttpStatus.OK);
        } else {
            return new ResponseEntity<Response>(new Response(false,
                    "Thất bại", null), HttpStatus.NOT_FOUND);
        }
    }
}
