package gr.careplus4.services.impl;

import gr.careplus4.entities.Medicine;
import gr.careplus4.entities.Review;
import gr.careplus4.entities.ReviewDetail;
import gr.careplus4.models.ReviewForUserModel;
import gr.careplus4.repositories.ReviewDetailRepository;
import gr.careplus4.services.iReviewDetailServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ReviewDetailServiceImpl implements iReviewDetailServices {

    @Autowired
    private ReviewDetailRepository reviewDetailRepository;

    @Autowired
    private MedicineServicesImpl medicineServicesImpl;

    @Override
    public Page<ReviewForUserModel> findReviewForUserModelByMedicineId(String medicineId, Pageable pageable) {
        // Lấy đối tượng thuốc
        Medicine medicine = medicineServicesImpl.findById(medicineId)
                .orElseThrow(() -> new RuntimeException("Thuốc không tồn tại"));

        // Lấy danh sách ReviewDetail liên quan đến thuốc
        List<ReviewDetail> reviewDetails = reviewDetailRepository.findReviewDetailsByMedicine(medicine);

        // Tính toán chỉ số bắt đầu và kết thúc
        int fromIndex = (int) pageable.getOffset();
        int toIndex = Math.min(fromIndex + pageable.getPageSize(), reviewDetails.size());

        // Kiểm tra nếu fromIndex vượt quá kích thước danh sách
        if (fromIndex >= reviewDetails.size()) {
            return new PageImpl<>(Collections.emptyList(), pageable, reviewDetails.size());
        }

        // Lấy sublist trong phạm vi hợp lệ
        List<ReviewDetail> paginatedList = reviewDetails.subList(fromIndex, toIndex);

        // Chuyển đổi từ ReviewDetail sang ReviewForUserModel
        List<ReviewForUserModel> reviewForUserModels = paginatedList.stream().map(reviewDetail -> {
            ReviewForUserModel reviewForUserModel = new ReviewForUserModel();
            reviewForUserModel.setUserName(reviewDetail.getReview().getUser().getName());
            reviewForUserModel.setDate(reviewDetail.getReview().getDate());
            reviewForUserModel.setRating(reviewDetail.getRating());
            reviewForUserModel.setReview(reviewDetail.getText());
            return reviewForUserModel;
        }).collect(Collectors.toList());

        return new PageImpl<>(reviewForUserModels, pageable, reviewDetails.size());
    }

    @Override
    public List<ReviewDetail> findReviewDetailByReview_IdAndMedicine_Id(String reviewId, String medicineId) {
        return reviewDetailRepository.findReviewDetailByReview_IdAndMedicine_Id(reviewId, medicineId);
    }

    @Override
    public List<ReviewDetail> findReviewDetailsByMedicine(Medicine medicine) {
        return reviewDetailRepository.findReviewDetailsByMedicine(medicine);
    }

    @Override
    public List<ReviewDetail> findReviewDetailsByReview(Review review) {
        return reviewDetailRepository.findReviewDetailsByReview(review);
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
    public boolean existsReviewDetailByReviewAndMedicine_Id(Review review, String medicineId) {
        return reviewDetailRepository.existsReviewDetailByReviewAndMedicine_Id(review, medicineId);
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