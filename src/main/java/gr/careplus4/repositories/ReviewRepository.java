package gr.careplus4.repositories;

import gr.careplus4.entities.Bill;
import gr.careplus4.entities.Review;
import gr.careplus4.entities.User;
import jakarta.validation.constraints.Pattern;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, String> {

    Review findTopByIdContains(String id, Sort sort); // Tìm review cuối cùng theo id
    List<Review> findReviewByUser(User user); // Tìm kiếm theo user
    Page<Review> findReviewByUser(User user, Pageable pageable); // Tìm kiếm theo user và phân trang
    Page<Review> findReviewByUser_NameContaining(String userName, Pageable pageable); // Tìm kiếm theo userName và phân trang

    Review findReviewByUserAndBill(User user, Bill bill);

    Boolean existsByUserAndBill(User user, Bill bill); // Kiểm tra xem review đã tồn tại chưa

    int countReviewsByBill_Id(String billId); // Đếm số lượng review theo billId
    int countReviewsByUser_PhoneNumber(@Pattern(regexp = "^\\d{10}$", message = "Phone number must be 10 digits") String userPhoneNumber); // Đếm số lượng review theo phoneNumber của user
}
