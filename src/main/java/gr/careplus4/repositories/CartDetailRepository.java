package gr.careplus4.repositories;

import gr.careplus4.entities.Cart;
import gr.careplus4.entities.CartDetail;
import gr.careplus4.entities.Medicine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    CartDetail findByCartAndMedicine(Cart cart, Medicine medicine);

    List<CartDetail> findAllByCart(Optional<Cart> cart);

    void deleteAllByCart(Cart cart);

    Boolean existsByMedicine_Id(String medicineId);
}
