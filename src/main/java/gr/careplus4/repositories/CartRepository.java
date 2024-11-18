package gr.careplus4.repositories;

import gr.careplus4.entities.Cart;
import gr.careplus4.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CartRepository extends JpaRepository<Cart, String> {
    Optional<Cart> findByUser_PhoneNumber(String phoneNumber);
    Cart findByUser(User user);
}
