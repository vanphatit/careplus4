package gr.careplus4.services;

import gr.careplus4.entities.Medicine;
import gr.careplus4.entities.Review;
import gr.careplus4.entities.ReviewDetail;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface iReviewDetailServices {
    List<ReviewDetail> findReviewDetailByReview_IdAndMedicine_Id(String reviewId, String medicineId);

    List<ReviewDetail> findReviewDetailsByReview(Review review);

    List<ReviewDetail> findReviewDetailsByReview(Review review, Pageable pageable);

    List<ReviewDetail> findReviewDetailsByMedicine(Medicine medicine, Pageable pageable);

    int countReviewDetailsByReview_Id(String reviewId);

    int countReviewDetailsByMedicine_Id(String medicineId);

    int countReviewDetailsByReview_User_PhoneNumber(String reviewUserPhoneNumber);

    int countReviewDetailsByReview_Bill_Id(String reviewBillId);

    boolean existsReviewDetailByReviewAndMedicine_Id(Review review, String medicineId);

    <S extends ReviewDetail> S save(S entity);

    void delete(ReviewDetail entity);
}
