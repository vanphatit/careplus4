package gr.careplus4.services.impl;

import gr.careplus4.entities.Cart;
import gr.careplus4.entities.CartDetail;
import gr.careplus4.repositories.CartDetailRepository;
import gr.careplus4.repositories.CartRepository;
import gr.careplus4.services.iCartDetailService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class CartDetailServiceImpl implements iCartDetailService {
    @Autowired
    private CartDetailRepository cartDetailRepository;

    @Autowired
    private CartRepository cartRepository;

    @Override
    public void handleRemoveCartDetail(long cartDetailId, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(cartDetailId);
        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();

            Cart currentCart = cartDetail.getCart();
            // delete cart-detail
            this.cartDetailRepository.deleteById(cartDetailId);

            // update cart
            if (currentCart.getProductCount() > 1) {
                // update current cart
                int s = currentCart.getProductCount() - 1;
                currentCart.setProductCount(s);
//                session.setAttribute("cartCount", s);
                this.cartRepository.save(currentCart);
            } else {
                // delete cart (sum = 1)
                this.cartRepository.deleteById(currentCart.getId());
//                session.setAttribute("cartCount", 0);
            }
        }
    }
}
