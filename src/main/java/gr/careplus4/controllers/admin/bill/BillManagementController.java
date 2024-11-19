package gr.careplus4.controllers.admin.bill;

import gr.careplus4.entities.Bill;
import gr.careplus4.entities.Category;
import gr.careplus4.models.CategoryModel;
import gr.careplus4.services.impl.BillServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class BillManagementController {
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


}
