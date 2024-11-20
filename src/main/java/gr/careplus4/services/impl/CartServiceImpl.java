package gr.careplus4.services.impl;

import gr.careplus4.entities.Cart;
import gr.careplus4.entities.CartDetail;
import gr.careplus4.entities.Medicine;
import gr.careplus4.entities.User;
import gr.careplus4.models.CartConfirmModel;
import gr.careplus4.models.CartDetailConfirmModel;
import gr.careplus4.models.CartDetailModel;
import gr.careplus4.models.CartModel;
import gr.careplus4.repositories.CartDetailRepository;
import gr.careplus4.repositories.CartRepository;
import gr.careplus4.repositories.MedicineRepository;
import gr.careplus4.repositories.UserRepository;
import gr.careplus4.services.GeneratedId;
import gr.careplus4.services.iCartService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class CartServiceImpl implements iCartService {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private MedicineRepository medicineRepository;

    @Autowired
    private CartDetailRepository cartDetailRepository;

    @Override
    public Optional<CartModel> findByUser_PhoneNumber(String phone) {
        Optional<Cart> cart = cartRepository.findByUser_PhoneNumber(phone);
        Optional<CartModel> cartModel = Optional.of(new CartModel());
        if (cart.isPresent()) {
            cartModel.get().setId(cart.get().getId());
            cartModel.get().setUserPhoneNumber(phone);
            cartModel.get().setProductCount(cart.get().getProductCount());
        }
        return cartModel;
    }

    @Override
    public Cart findCartByUser(User user) {
        Cart cart = cartRepository.findByUser(user);
        return cart == null ? new Cart() : cart;
    }

    @Override
    public void handleAddProductToCart(String phone, String medicineId, HttpSession session) {
       Optional<User> user = this.userRepository.findByPhoneNumber(phone);
       if (user.isPresent()) {
           // check user đã có Cart chưa ? nếu chưa -> tạo mới
           Optional<Cart> cart;
           if (user.get().getCart() != null && user.get().getCart().getId() != null) {
               cart = this.cartRepository.findById(user.get().getCart().getId());
           } else {
               cart = Optional.empty();
           }

           if (cart.isEmpty()) {
               List<Cart> carts = cartRepository.findAll();
               String preCardId;
               if (carts.size() > 0) {
                   preCardId = carts.get(carts.size() - 1).getId();
               } else {
                   preCardId = "C000000";
               }
               // tạo mới cart
               Cart otherCart = new Cart();
               otherCart.setId(GeneratedId.getGeneratedId(preCardId));
               otherCart.setUser(user.get());
               otherCart.setProductCount(0);
               // Cap nhat lai gio hang cho user
               user.get().setCart(otherCart);
                try {
                    this.userRepository.save(user.get());
                    this.cartRepository.save(otherCart);
                } catch (Exception e) {
                    e.printStackTrace();
                }

               cart = Optional.of(otherCart);
           }
           // tìm medicine by id
           Optional<Medicine> medicineOptional = this.medicineRepository.findById(medicineId);
           if (medicineOptional.isPresent()) {
               Medicine realProduct = medicineOptional.get();
               // check sản phẩm đã từng được thêm vào giỏ hàng trước đây chưa ?
               CartDetail oldDetail = this.cartDetailRepository.findByCartAndMedicine(cart.get(), realProduct);
               if (oldDetail == null) {
                   CartDetail cd = new CartDetail();
                   cd.setCart(cart.get());
                   cd.setMedicine(realProduct);
                   cd.setUnitCost(realProduct.getUnitCost());
                   cd.setQuantity(1);
                   this.cartDetailRepository.save(cd);

                   // update cart (cartCount);
                   int total = cart.get().getProductCount() + 1;
                   cart.get().setProductCount(total);
                   this.cartRepository.save(cart.get());
//                   session.setAttribute("cartCount", total);
               } else {
                   oldDetail.setQuantity(oldDetail.getQuantity() + 1);
                   oldDetail.setSubTotal(oldDetail.getSubTotal().add(realProduct.getUnitCost()));
                   this.cartDetailRepository.save(oldDetail);
               }
           }

       }
    }

    @Override
    public List<CartDetailModel> getCartDetails(String phone) {
        Optional<Cart> cartOptional = cartRepository.findByUser_PhoneNumber(phone);

        if (cartOptional.isPresent()) {
            List<CartDetail> cartDetailList = cartDetailRepository.findAllByCart(cartOptional);

            List<CartDetailModel> cartDetailModelList = new ArrayList<>();
            for (CartDetail cd : cartDetailList) {
                CartDetailModel cartDetailModel = getCartDetailModel(cd);
                cartDetailModelList.add(cartDetailModel);
            }
            return cartDetailModelList;
        }

        return new ArrayList<>();
    }

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
                int cartCount = currentCart.getProductCount() - 1;
                currentCart.setProductCount(cartCount);
//                session.setAttribute("cartCount", cartCount);
                this.cartRepository.save(currentCart);
            } else {
                // delete cart (sum = cartCount)
                this.cartDetailRepository.deleteAllByCart(currentCart);
                this.cartRepository.deleteById(currentCart.getId());
                currentCart.setProductCount(0);
                this.cartRepository.save(currentCart);
//                session.setAttribute("cartCount", 0);
            }
        }
    }


    private CartDetailModel getCartDetailModel(CartDetail cd) {
        CartDetailModel cartDetailModel = new CartDetailModel();
        cartDetailModel.setCartDetailId(cd.getId());
        cartDetailModel.setMedicineId(cd.getMedicine().getId());
        cartDetailModel.setQuantity(cd.getQuantity());
        cartDetailModel.setSubTotal(cd.getSubTotal());
        cartDetailModel.setUnitCost(cd.getUnitCost());
        cartDetailModel.setImage(cd.getMedicine().getImage());
        cartDetailModel.setUnitName(cd.getMedicine().getUnit().getName());
        return cartDetailModel;
    }

    public void handleUpdateCartBeforeCheckout(CartConfirmModel cart) {
        for (CartDetailConfirmModel cd : cart.getCartDetails()) {
            Optional<CartDetail> cdOptional = this.cartDetailRepository.findById(cd.getId());
            if (cdOptional.isPresent()) {
                CartDetail currentCartDetail = cdOptional.get();
                currentCartDetail.setQuantity(cd.getQuantity());
                this.cartDetailRepository.save(currentCartDetail);
            }
        }
    }



}
