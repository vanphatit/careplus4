package gr.careplus4.controllers.vendor;

import gr.careplus4.entities.Bill;
import gr.careplus4.services.impl.BillServiceImpl;
import jakarta.validation.Valid;
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

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("/vendor")
public class BillVendorController {
    @Autowired
    private BillServiceImpl billService;

    @GetMapping("/bills")
    public String getBills(Model model, @RequestParam(defaultValue = "1") int page) {
        int pageSize = 5;
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        Page<Bill> billPage = this.billService.fetchAllBills(pageable);
        List<Bill> bills = billPage.getContent();
        int numberPages = this.billService.getNumberOfPage(pageSize);
        model.addAttribute("bills", bills);
        model.addAttribute("pageNo", numberPages);
        model.addAttribute("currentPage", page);

        return "vendor/bill/bill-list";
    }

    @GetMapping("/bill/update/{id}")
    public String getUpdateBillPage(Model model, @PathVariable String id) {
        Optional<Bill> currentBill = this.billService.findById(id);
        model.addAttribute("currentBill", currentBill.get());
        return "vendor/bill/update";
    }

    @PostMapping("/bill/update")
    public String handleUpdateBill(
            @ModelAttribute("newBill") @Valid Bill bill,
            BindingResult newProductBindingResult) {

        this.billService.saveBill(bill);

        return "redirect:/vendor/bill/" + bill.getId();
    }

    @PostMapping("bill/updateStatus")
    public String handleUpdateBillStatus(
            @ModelAttribute("newBill") @Valid Bill bill,
            BindingResult newProductBindingResult) {

        this.billService.saveBill(bill);

        return "redirect:/vendor/bills";
    }

    @GetMapping("/bill/{id}")
    public String getBillDetailPage(Model model, @PathVariable String id) {
        Optional<Bill> bill = this.billService.findById(id);
        model.addAttribute("bill", bill.get());
        return "vendor/bill/detail";
    }

    @GetMapping("/bill/delete/{id}")
    public String getDeleteBillPage(Model model, @PathVariable String id) {
        Optional<Bill> bill = this.billService.findById(id);
        this.billService.deleteBill(bill.get());
        return "redirect:/vendor/bills";
    }

    @RequestMapping("/bill/search")
    public String searchByIdOrProviderId(ModelMap model,
                                         @RequestParam(name = "id", required = false) String id,
                                         @RequestParam(defaultValue = "1") int page){
        int pageSize = 5;

        Pageable pageable = PageRequest.of(page - 1, pageSize, Sort.by("id"));

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

        return "vendor/bill/bill-list";
    }


}
