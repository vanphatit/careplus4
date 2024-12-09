package gr.careplus4.services.impl;

import gr.careplus4.entities.Bill;
import gr.careplus4.entities.Review;
import gr.careplus4.entities.User;
import gr.careplus4.repositories.ReviewRepository;
import gr.careplus4.services.GeneratedId;
import gr.careplus4.services.iReviewServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ReviewServiceImpl implements iReviewServices {
    @Autowired
    private ReviewRepository reviewRepository;

    @Override
    public Boolean existsByUserAndBill(User user, Bill bill) {
        return reviewRepository.existsByUserAndBill(user, bill);
    }

    @Override
    public Review findTopByIdContains(String id, Sort sort) {
        return reviewRepository.findTopByIdContains(id, sort);
    }

    @Override
    public List<Review> findAll() {
        return reviewRepository.findAll();
    }

    @Override
    public <S extends Review> S save(S entity) {
        if(entity.getId() == null) {
            String lastId = findTopByIdContains("RE", Sort.by(Sort.Direction.DESC, "id")) != null
                    ? findTopByIdContains("RE", Sort.by(Sort.Direction.DESC, "id")).getId() : "RE00000";
            entity.setId(GeneratedId.getGeneratedId(lastId));
        }
        return reviewRepository.save(entity);
    }

    @Override
    public List<Review> findReviewByUser(User user) {
        return reviewRepository.findReviewByUser(user);
    }

    @Override
    public Page<Review> findReviewByUser(User user, Pageable pageable) {
        return reviewRepository.findReviewByUser(user, pageable);
    }

    @Override
    public Page<Review> findReviewByUser_NameContaining(String userName, Pageable pageable) {
        return reviewRepository.findReviewByUser_NameContaining(userName, pageable);
    }

    @Override
    public Review findReviewByUserAndBill(User user, Bill bill) {
        return reviewRepository.findReviewByUserAndBill(user, bill);
    }

    @Override
    public Optional<Review> findById(String s) {
        return reviewRepository.findById(s);
    }

    @Override
    public void delete(Review entity) {
        reviewRepository.delete(entity);
    }

    @Override
    public Page<Review> findAll(Pageable pageable) {
        return reviewRepository.findAll(pageable);
    }

    @Override
    public int countReviewsByBill_Id(String billId) {
        return reviewRepository.countReviewsByBill_Id(billId);
    }

    @Override
    public int countReviewsByUser_PhoneNumber(String userPhoneNumber) {
        return reviewRepository.countReviewsByUser_PhoneNumber(userPhoneNumber);
    }
}
