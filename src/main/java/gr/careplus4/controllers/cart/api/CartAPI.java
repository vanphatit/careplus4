package gr.careplus4.controllers.cart.api;

import gr.careplus4.models.CartConfirmModel;
import gr.careplus4.models.CartDetailModel;
import gr.careplus4.models.CartModel;
import gr.careplus4.models.Response;
import gr.careplus4.services.impl.CartServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("v1/api/cart")
public class CartAPI {
    @Autowired
    CartServiceImpl cartService;

    @GetMapping("/getCart")
    public ResponseEntity<?> getCartByPhoneNumber(@RequestParam("phoneNumber") String phoneNumber) {
        Optional<CartModel> cart = cartService.findByUser_PhoneNumber(phoneNumber);
        if (cart.isPresent()) {
            return new ResponseEntity<Response>(new Response(true,
                    "Thành công", cart.get()), HttpStatus.OK);
        } else {
            return new ResponseEntity<Response>(new Response(false,
                    "Thất bại", null), HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("/add-product-to-cart/{id}")
    public ResponseEntity<?> addProductToCart(@PathVariable String id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);

//        if (session == null) {
//            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
//                    .body("Session not found, please log in.");
//        }
//
//        String phone = (String) session.getAttribute("phone");
//        if (phone == null) {
//            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
//                    .body("User not logged in.");
//        }

        String phone = "0902345671"; // Tam thoi de cung

        try {
            this.cartService.handleAddProductToCart(phone, id, session);
            return ResponseEntity.ok("Thêm sản phẩm vào giỏ hàng thành công.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Lỗi khi thêm sản phẩm vào giỏ hàng.");
        }
    }

    @GetMapping("/getCartDetails")
    public ResponseEntity<?> getCartDetails() {
        String phone = "0902345671"; // Tam
        List<CartDetailModel> cartDetails = cartService.getCartDetails(phone);
        if (!cartDetails.isEmpty()) {
            return new ResponseEntity<Response>(new Response(true,
                    "Thành công", cartDetails), HttpStatus.OK);
        } else {
            return new ResponseEntity<Response>(new Response(false,
                    "Thất bại", null), HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete-cart-product/{id}")
    public ResponseEntity<String> deleteCartProduct(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
//        if (session == null) {
//            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Session not found. Please log in.");
//        }

        try {
            long cartDetailId = id;
            cartService.handleRemoveCartDetail(cartDetailId, session);
            return ResponseEntity.ok("Sản phẩm đã được xóa khỏi giỏ hàng.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Lỗi: " + e.getMessage());
        }
    }

    @PutMapping("/confirm-checkout")
    public ResponseEntity<String> confirmCheckout(@RequestBody CartConfirmModel cart) {
        if (cart == null || cart.getCartDetails().isEmpty()) {
            return ResponseEntity.badRequest().body("Giỏ hàng không tồn tại.");
        }

        // Cập nhật giỏ hàng trước khi thanh toán
        this.cartService.handleUpdateCartBeforeCheckout(cart);
        return ResponseEntity.ok("Đã cập nhật thành công.");
    }

}
