package gr.careplus4.services;

import gr.careplus4.entities.Cart;

import java.util.Optional;

public interface iCartService {
    Optional<Cart> findById(String id);
}
