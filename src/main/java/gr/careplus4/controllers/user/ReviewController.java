package gr.careplus4.controllers.user;

import gr.careplus4.entities.*;
import gr.careplus4.models.ReviewDetailModel;
import gr.careplus4.services.impl.*;
import gr.careplus4.services.security.JwtCookies;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
public class ReviewController {

    @Autowired
    private ReviewServiceImpl reviewService;

    @Autowired
    private ReviewDetailServiceImpl reviewDetailService;

    @Autowired
    private BillServiceImpl billService;

    @Autowired
    private MedicineServicesImpl medicineService;

    @Autowired
    private UserServiceImpl userServiceImpl;

    @Autowired
    private JwtCookies jwtCookies;

    // Hiển thị danh sách review của vendor
    @GetMapping("/vendor/reviews")
    public ModelAndView showReviews(Model model, @RequestParam("page") Optional<Integer> page,
                                    @Validated @RequestParam("size") Optional<Integer> size) {
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Pageable pageable = (Pageable) PageRequest.of(currentPage - 1, pageSize, Sort.by("date").descending());
        Page<Review> reviews = reviewService.findAll(pageable);

        model.addAttribute("reviewPage", reviews);

        int totalPages = reviews.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages).boxed().collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }
        return new ModelAndView("vendor/review-list");
    }

    // Tìm kiếm review theo tên user
    @PostMapping("/vendor/reviews/search")
    public ModelAndView searchReviews(Model model, @Validated @RequestParam("searchText") String searchText,
                                      @Validated @RequestParam("page") Optional<Integer> page,
                                      @Validated @RequestParam("size") Optional<Integer> size) {
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        if (searchText.isEmpty()) {
            return new ModelAndView("redirect:/vendor/reviews");
        }

        Pageable pageable = (Pageable) PageRequest.of(currentPage - 1, pageSize, Sort.by("date").descending());
        Page<Review> reviews = reviewService.findReviewByUser_NameContaining(searchText, pageable);

        model.addAttribute("reviewPage", reviews);

        int totalPages = reviews.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages).boxed().collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }
        return new ModelAndView("vendor/review-list");
    }

    // Hiển thị chi tiết review của vendor
    @GetMapping("/vendor/reviews/{id}")
    public ModelAndView showReviewDetails(@PathVariable("id") String id, Model model) {

        Review review = reviewService.findById(id).get();
        List<ReviewDetail> reviewDetails = reviewDetailService.findReviewDetailsByReview(review, PageRequest.of(0, 5));
        model.addAttribute("review", review);
        model.addAttribute("reviewDetails", reviewDetails);
        return new ModelAndView("vendor/review-details");
    }

    // Xóa review bởi vendor
    @GetMapping("/vendor/reviews/{id}/delete")
    public ModelAndView deleteReview(@PathVariable("id") String id) {
        Review review = reviewService.findById(id).get();

        List<ReviewDetail> reviewDetails = reviewDetailService.findReviewDetailsByReview(review);
        for (ReviewDetail reviewDetail : reviewDetails) {
            reviewDetailService.delete(reviewDetail);
        }
        reviewService.delete(review);
        return new ModelAndView("redirect:/vendor/reviews");
    }

    // Hiển thị danh sách chưa review của user và chọn bill để review
    @GetMapping("/user/reviewed")
    public ModelAndView showReviewForm(HttpServletRequest request, Model model) {

        String id = jwtCookies.getUserPhoneFromJwt(request);

        // check and list all bill that not in review about 14 days ago
        User user = userServiceImpl.findByPhoneNumber(id).get();
        Date currentDate = new Date(); // current date
        Date date14DaysAgo = new Date(currentDate.getTime() - 14 * 24 * 3600 * 1000); // 14 days ago

        List<Bill> bills14days = billService.findBillsByUserAndDateBetween(user, date14DaysAgo, currentDate);
        List<Bill> billsNotReviewed;
        if (bills14days.size() > 0) {
            billsNotReviewed = bills14days.stream().filter(bill -> !reviewService.existsByUserAndBill(user, bill)).collect(Collectors.toList());
        } else {
            billsNotReviewed = bills14days;
        }

        model.addAttribute("bills", billsNotReviewed);

        return new ModelAndView("user/not-reviewed-list");
    }

    // Hiển thị danh sách review của user
    @GetMapping("/user/reviews")
    public ModelAndView showUserReviews(@RequestParam(defaultValue = "0") int page,
                                        @RequestParam(defaultValue = "5") int size,
                                        HttpServletRequest request,
                                        Model model) {

        String id = jwtCookies.getUserPhoneFromJwt(request);

        User user = userServiceImpl.findByPhoneNumber(id)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));
        System.out.println("User: " + user.getPhoneNumber());

        // Lấy danh sách Review của User với phân trang
        Pageable pageable = PageRequest.of(page, size, Sort.by("date").descending());
        Page<Review> reviewPage = reviewService.findReviewByUser(user, pageable);

        // Map Review -> List<ReviewDetail>
        Map<Review, List<ReviewDetail>> reviewDetailsMap = new HashMap<>();
        for (Review review : reviewPage.getContent()) {
            List<ReviewDetail> details = reviewDetailService.findReviewDetailsByReview(review);
            reviewDetailsMap.put(review, details);
        }

        // Truyền dữ liệu vào model
        model.addAttribute("reviews", reviewPage.getContent());
        model.addAttribute("reviewDetailsMap", reviewDetailsMap);
        model.addAttribute("user", user);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", reviewPage.getTotalPages());
        model.addAttribute("size", size);

        return new ModelAndView("user/review-list");
    }

    // Hiển thị form review của user cho bill đã chọn
    @GetMapping("/user/review/{billId}")
    public ModelAndView reviewForBill(Model model, HttpServletRequest request,
                                      @PathVariable("billId") String billId) {
        String id = jwtCookies.getUserPhoneFromJwt(request);
        User user = userServiceImpl.findByPhoneNumber(id).get();
        Bill bill = billService.findById(billId).get();

        // Kiểm tra xem bill đã được review chưa
        if (reviewService.existsByUserAndBill(user, bill)) {
            return new ModelAndView("user/reviewed");
        }

        // Lấy tất cả chi tiết hóa đơn
        List<BillDetail> billDetails = bill.getBilDetails();

        // Lấy danh sách sản phẩm đã được đánh giá
        Review review = reviewService.findReviewByUserAndBill(user, bill);
        List<ReviewDetail> existingReviews = reviewDetailService.findReviewDetailsByReview(review);
        List<String> reviewedMedicineIds = existingReviews.stream()
                .map(rd -> rd.getMedicine().getId())
                .collect(Collectors.toList());

        // Lọc ra các sản phẩm chưa được đánh giá
        List<Medicine> medicinesNotReviewed = billDetails.stream()
                .map(BillDetail::getMedicine)
                .filter(medicine -> !reviewedMedicineIds.contains(medicine.getId()))
                .collect(Collectors.toList());

        model.addAttribute("user", user);
        model.addAttribute("bill", bill);
        model.addAttribute("medicines", medicinesNotReviewed);

        return new ModelAndView("user/review-form");
    }

    // Lưu review của user cho bill đã chọn
    @PostMapping("/user/review/{billId}")
    public ModelAndView saveReview(HttpServletRequest request,
                                   @PathVariable("billId") String billId,
                                   @ModelAttribute("reviewDetails") ReviewDetailModel model) {
        String id = jwtCookies.getUserPhoneFromJwt(request);
        User user = userServiceImpl.findByPhoneNumber(id).orElseThrow(() -> new IllegalArgumentException("Invalid User"));
        Bill bill = billService.findById(billId).orElseThrow(() -> new IllegalArgumentException("Invalid Bill"));

        Review review;
        if(reviewService.existsByUserAndBill(user, bill)) {
            review = reviewService.findReviewByUserAndBill(user, bill);
        } else {
            review = new Review();
            review.setUser(user);
            review.setBill(bill);
            review.setDate(java.sql.Date.valueOf(LocalDate.now()));
            reviewService.save(review);
        }

        // Kiểm tra nếu sản phẩm đã được đánh giá
        boolean alreadyReviewed = reviewDetailService.existsReviewDetailByReviewAndMedicine_Id(review, model.getMedicineId());
        if (alreadyReviewed) {
            throw new IllegalArgumentException("Product already reviewed!");
        }

        Medicine medicine = medicineService.findById(model.getMedicineId()).orElseThrow(() -> new IllegalArgumentException("Invalid Medicine"));

        // Tạo chi tiết review mới
        ReviewDetail reviewDetail = new ReviewDetail();
        reviewDetail.setReview(review);
        reviewDetail.setMedicine(medicine);
        reviewDetail.setRating(model.getRating());
        reviewDetail.setText(model.getComment());
        reviewDetailService.save(reviewDetail);

        medicineService.updateTotalRatingForMedicine(medicine.getName(), medicine.getManufacturer().getName(), model.getRating());

        return new ModelAndView("redirect:/user/review/" + bill.getId());
    }

    // Xoá review của user cho bill đã chọn
    @GetMapping("/user/review/{billId}/delete")
    public ModelAndView deleteReview(HttpServletRequest request, @PathVariable("billId") String billId) {
        String id = jwtCookies.getUserPhoneFromJwt(request);
        User user = userServiceImpl.findByPhoneNumber(id).get();
        Bill bill = billService.findById(billId).get();
        Review review = reviewService.findReviewByUserAndBill(user, bill);
        List<ReviewDetail> reviewDetail = reviewDetailService.findReviewDetailsByReview(review);
        for (ReviewDetail rd : reviewDetail) {
            reviewDetailService.delete(rd);
        }
        reviewService.delete(review);
        return new ModelAndView("redirect:/user/reviews");
    }
}