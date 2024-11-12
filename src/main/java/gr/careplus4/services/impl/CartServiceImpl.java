package gr.careplus4.services.impl;

import gr.careplus4.entities.Cart;
import gr.careplus4.repositories.CartRepository;
import gr.careplus4.services.iCartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class CartServiceImpl implements iCartService {

    @Autowired
    private CartRepository cartRepository;

    @Override
    public Optional<Cart> findById(String id) {
        return cartRepository.findById(id);
    }
}
