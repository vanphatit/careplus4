package gr.careplus4.services;

import gr.careplus4.models.CartConfirmModel;
import gr.careplus4.models.CartDetailModel;
import gr.careplus4.models.CartModel;
import jakarta.servlet.http.HttpSession;

import java.util.List;
import java.util.Optional;

public interface iCartService {
    Optional<CartModel> findByUser_PhoneNumber(String phone);
    void handleAddProductToCart(String phone, String medicineId, HttpSession session);
    List<CartDetailModel> getCartDetails(String phone);
    void handleRemoveCartDetail(long cartDetailID, HttpSession session);
    void handleUpdateCartBeforeCheckout(CartConfirmModel cart);
}
