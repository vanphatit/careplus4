package gr.careplus4.services;

import gr.careplus4.entities.Bill;
import gr.careplus4.entities.Review;
import gr.careplus4.entities.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.util.List;
import java.util.Optional;

public interface iReviewServices {
    Boolean existsByUserAndBill(User user, Bill bill);

    Review findTopByIdContains(String id, Sort sort);

    List<Review> findAll();

    <S extends Review> S save(S entity);

    List<Review> findReviewByUser(User user);

    Page<Review> findReviewByUser(User user, Pageable pageable);

    Review findReviewByUserAndBill(User user, Bill bill);

    Optional<Review> findById(String s);

    void delete(Review entity);

    Page<Review> findAll(Pageable pageable);

    int countReviewsByBill_Id(String billId);

    int countReviewsByUser_PhoneNumber(String userPhoneNumber);
}
