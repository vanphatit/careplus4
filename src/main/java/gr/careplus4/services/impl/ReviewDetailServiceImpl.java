package gr.careplus4.services.impl;

import gr.careplus4.entities.Medicine;
import gr.careplus4.entities.Review;
import gr.careplus4.entities.ReviewDetail;
import gr.careplus4.repositories.ReviewDetailRepository;
import gr.careplus4.services.iReviewDetailServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewDetailServiceImpl implements iReviewDetailServices {
    @Autowired
    private ReviewDetailRepository reviewDetailRepository;

    @Override
    public List<ReviewDetail> findReviewDetailByReview_IdAndMedicine_Id(String reviewId, String medicineId) {
        return reviewDetailRepository.findReviewDetailByReview_IdAndMedicine_Id(reviewId, medicineId);
    }

    @Override
    public List<ReviewDetail> findReviewDetailsByReview(Review review, Pageable pageable) {
        return reviewDetailRepository.findReviewDetailsByReview(review, pageable);
    }

    @Override
    public List<ReviewDetail> findReviewDetailsByMedicine(Medicine medicine, Pageable pageable) {
        return reviewDetailRepository.findReviewDetailsByMedicine(medicine, pageable);
    }

    @Override
    public int countReviewDetailsByReview_Id(String reviewId) {
        return reviewDetailRepository.countReviewDetailsByReview_Id(reviewId);
    }

    @Override
    public int countReviewDetailsByMedicine_Id(String medicineId) {
        return reviewDetailRepository.countReviewDetailsByMedicine_Id(medicineId);
    }

    @Override
    public int countReviewDetailsByReview_User_PhoneNumber(String reviewUserPhoneNumber) {
        return reviewDetailRepository.countReviewDetailsByReview_User_PhoneNumber(reviewUserPhoneNumber);
    }

    @Override
    public int countReviewDetailsByReview_Bill_Id(String reviewBillId) {
        return reviewDetailRepository.countReviewDetailsByReview_Bill_Id(reviewBillId);
    }

    @Override
    public <S extends ReviewDetail> S save(S entity) {
        return reviewDetailRepository.save(entity);
    }

    @Override
    public void delete(ReviewDetail entity) {
        reviewDetailRepository.delete(entity);
    }
}
