package gr.careplus4.repositories;

import gr.careplus4.entities.Medicine;
import gr.careplus4.entities.Review;
import gr.careplus4.entities.ReviewDetail;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface ReviewDetailRepository extends JpaRepository<ReviewDetail, Long> {
    List<ReviewDetail> findReviewDetailByReview_IdAndMedicine_Id(String reviewId, @Size(max = 7) String medicineId);
    List<ReviewDetail> findReviewDetailsByReview(Review review, Pageable pageable);
    List<ReviewDetail> findReviewDetailsByMedicine(Medicine medicine, Pageable pageable);

    int countReviewDetailsByReview_Id(String reviewId);
    int countReviewDetailsByMedicine_Id(String medicineId);

    int countReviewDetailsByReview_User_PhoneNumber(@Pattern(regexp = "^\\d{10}$",
            message = "Phone number must be 10 digits") String reviewUserPhoneNumber);
    int countReviewDetailsByReview_Bill_Id(String reviewBillId);
}
