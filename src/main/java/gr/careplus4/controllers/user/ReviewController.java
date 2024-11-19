package gr.careplus4.controllers.user;

import gr.careplus4.entities.*;
import gr.careplus4.services.impl.*;
import jakarta.persistence.Access;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;
import java.util.List;
import java.util.Optional;
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

    @GetMapping("/vendor/reviews")
    public ModelAndView showReviews(Model model, @RequestParam("page") Optional<Integer> page,
                                    @RequestParam("size") Optional<Integer> size) {
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
        return new ModelAndView("/vendor/reviews-list");
    }

    @GetMapping("/vendor/reviews/{id}")
    public ModelAndView showReviewDetails(@PathVariable("id") String id, Model model) {
        Review review = reviewService.findById(id).get();
        List<ReviewDetail> reviewDetails = reviewDetailService.findReviewDetailsByReview(review, PageRequest.of(0, 5));
        model.addAttribute("review", review);
        model.addAttribute("reviewDetails", reviewDetails);
        return new ModelAndView("/vendor/review-details");
    }

    @GetMapping("/vendor/reviews/{id}/delete")
    public ModelAndView deleteReview(@PathVariable("id") String id) {
        Review review = reviewService.findById(id).get();
        reviewService.delete(review);
        return new ModelAndView("redirect:/vendor/reviews");
    }

    @GetMapping("/user/{id}/reviews")
    public ModelAndView showReviewForm(@PathVariable("id") String id, Model model) {
        // check and list all bill that not in review about 14 days ago
        User user = userServiceImpl.findByPhoneNumber(id).get();
        Date currentDate = new Date(); // current date
        Date date14DaysAgo = new Date(currentDate.getTime() - 14 * 24 * 3600 * 1000); // 14 days ago

        List<Bill> bills14days = billService.findBillsByUserAndDateBettween(user, date14DaysAgo, currentDate);
        List<Bill> billsNotReviewed;
        if(bills14days.size() > 0) {
            billsNotReviewed = bills14days.stream().filter(bill -> !reviewService.existsByUserAndBill(user, bill)).collect(Collectors.toList());
        } else {
            billsNotReviewed = bills14days;
        }

        model.addAttribute("bills", billsNotReviewed);

        return new ModelAndView("/user/reviews");
    }

    @GetMapping("/user/{id}/review/{billId}")
    public ModelAndView reviewForBill(Model model, @PathVariable("id") String id,
                                      @PathVariable("billId") String billId) {
        User user = userServiceImpl.findByPhoneNumber(id).get();
        Bill bill = billService.findById(billId).get();

        if(reviewService.existsByUserAndBill(user, bill)) {
            return new ModelAndView("redirect:/user/" + id + "/reviews");
        }

        List<BillDetail> billDetails = bill.getBilDetails();
        List<Medicine> medicines = billDetails.stream().map(BillDetail::getMedicine).collect(Collectors.toList());

        model.addAttribute("user", user);
        model.addAttribute("bill", bill);
        model.addAttribute("medicines", medicines);

        return new ModelAndView("/user/review-form");

    }

    @PostMapping("/user/{id}/review/{billId}")
    public ModelAndView saveReview(@PathVariable("id") String id, @PathVariable("billId") String billId,
                                   @RequestParam("rating") int rating, @RequestParam("comment") String comment,
                                   @RequestParam("medicineId") List<String> medicineIds) {
        User user = userServiceImpl.findByPhoneNumber(id).get();
        Bill bill = billService.findById(billId).get();
        Review review = new Review();
        review.setUser(user);
        review.setBill(bill);
        reviewService.save(review);

        ReviewDetail reviewDetail;
        for(String medicineId : medicineIds) {
            reviewDetail = new ReviewDetail();
            reviewDetail.setReview(review);
            reviewDetail.setMedicine(medicineService.findById(medicineId).get());
            reviewDetail.setRating(rating);
            reviewDetail.setText(comment);
            reviewDetailService.save(reviewDetail);
        }

        return new ModelAndView("redirect:/user/" + id + "/reviews");
    }

}