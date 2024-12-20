package gr.careplus4.controllers.admin.bill;

import gr.careplus4.entities.Bill;
import gr.careplus4.services.impl.BillServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("/admin")
public class BillManagementController {
    @Autowired
    private BillServiceImpl billService;

    @GetMapping("/bills")
    public String getProductPage(Model model, @RequestParam(value = "status", required = false) String status,
                                 @RequestParam(defaultValue = "1") int page) {

        Pageable pageable = PageRequest.of(page - 1, 5, Sort.by(Sort.Order.desc("date")));

        Page<Bill> prs = this.billService.fetchProductsWithSpec(pageable, status);

        List<Bill> bills = prs.getContent().size() > 0 ? prs.getContent()
                : new ArrayList<Bill>();

        model.addAttribute("bills", bills);
        model.addAttribute("pageNo", prs.getTotalPages());
        model.addAttribute("currentPage", page);

        return "admin/bill/bill-list";
    }

    @GetMapping("/bill/update/{id}")
    public String getUpdateBillPage(Model model, @PathVariable String id) {
        Optional<Bill> currentBill = this.billService.findById(id);
        model.addAttribute("currentBill", currentBill.get());
        return "admin/bill/update";
    }

    @PostMapping("bill/update")
    public String handleUpdateBill(
            @ModelAttribute("newBill") @Valid Bill bill,
            BindingResult newProductBindingResult) {

        this.billService.saveBill(bill);

        return "redirect:/admin/bill/" + bill.getId();
    }

    @PostMapping("bill/updateStatus")
    public String handleUpdateBillStatus(
            @ModelAttribute("newBill") @Valid Bill bill,
            BindingResult newProductBindingResult) {

        this.billService.saveBill(bill);

        return "redirect:/admin/bills";
    }

    @GetMapping("/bill/{id}")
    public String getBillDetailPage(Model model, @PathVariable String id) {
        Optional<Bill> bill = this.billService.findById(id);
        model.addAttribute("bill", bill.get());
        return "admin/bill/detail";
    }

    @GetMapping("/bill/delete/{id}")
    public String getDeleteBillPage(Model model, @PathVariable String id) {
        Optional<Bill> bill = this.billService.findById(id);
        this.billService.deleteBill(bill.get());
        return "redirect:/admin/bills";
    }

    @RequestMapping("/bill/search")
    public String searchByIdOrProviderId(ModelMap model,
                                         @RequestParam(name = "id", required = false) String id,
                                         @RequestParam(defaultValue = "1") int page){
        int pageSize = 5;

        Pageable pageable = PageRequest.of(page - 1, pageSize, Sort.by(Sort.Order.desc("date")));

        Page<Bill> resultPage;
        if (StringUtils.hasText(id)) {
            resultPage = billService.findByIdContaining(id, pageable);
            model.addAttribute("id", id);
        }
        else {
            resultPage = billService.findAll(pageable);
        }

        int totalPages = resultPage.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }

        model.addAttribute("bills", resultPage.getContent());
        model.addAttribute("pageNo", totalPages);
        model.addAttribute("currentPage", page);

        return "admin/bill/bill-list";
    }

    @GetMapping("/bill/today")
    public String getBillToday(Model model) {
        LocalDate localDate = LocalDate.now();
        java.sql.Date date = java.sql.Date.valueOf(localDate);
        List<Bill> bills = this.billService.findBillsByDate(date);
        model.addAttribute("bills", bills);
        return "admin/bill/bill-list";
    }

    @GetMapping("/bill/week")
    public String getBillForWeek(Model model) {
        List<Bill> bills = this.billService.findBillsForWeek();
        model.addAttribute("bills", bills);
        return "admin/bill/bill-list";
    }
}
