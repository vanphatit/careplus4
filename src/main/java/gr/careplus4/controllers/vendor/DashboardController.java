package gr.careplus4.controllers.vendor;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import gr.careplus4.entities.Bill;
import gr.careplus4.models.RevenueRecordModel;
import gr.careplus4.models.TransactionHistoryModel;
import gr.careplus4.services.PackageService;
import gr.careplus4.services.impl.BillServiceImpl;
import gr.careplus4.services.impl.StatisticsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping({"/admin", "/vendor"})
public class DashboardController {

    @Autowired
    public StatisticsServiceImpl statisticsService;

    @Autowired
    public PackageService packageService;

    @Autowired
    public BillServiceImpl billService;

    @RequestMapping({"/", "/dashboard", ""})
    public String dashboard(Model model,
                            RedirectAttributes redirectAttributes
    ) throws JsonProcessingException {

        int totalUser = statisticsService.getTotalUsertWithRoleUser();
        int totalStockQuantity = statisticsService.getTotalStockQuantity();

        List<Map<String, Object>> top3BestSellerForLast7Days = statisticsService.getTop3BestSellerForLast7Days();
        BigDecimal revenueToday = statisticsService.getRevenueToday();
        BigDecimal revenueForWeek = statisticsService.getRevenueForWeek();
        BigDecimal revenueForMonth = statisticsService.getRevenueForMonth();
        BigDecimal revenueForSeason = statisticsService.getRevenueForSeason();

        List<RevenueRecordModel> revenueRecordForWeek = statisticsService.getRevenueRecordForWeek();
        List<RevenueRecordModel> revenueRecordForMonth = statisticsService.getRevenueRecordForMonth();
        List<RevenueRecordModel> revenueRecordForSeason = statisticsService.getRevenueRecordForSeason();

        try {
            List<TransactionHistoryModel> transactionHistory = packageService.findAllTransactionHistory();

            for (TransactionHistoryModel transaction : transactionHistory) {
                Optional<Bill> bill = billService.findById(transaction.getIdBill());
                if (bill.isPresent()) {
                    bill.get().setStatus(transaction.getStatus());
                    billService.saveBill(bill.get());
                }

                if (transaction.getStatus().equals("SHIPPING")) {
                    transaction.setStatus("Đang giao hàng");
                } else if (transaction.getStatus().equals("SHIPPED")) {
                    transaction.setStatus("Đã giao hàng");
                } else if (transaction.getStatus().equals("CANCELED")) {
                    transaction.setStatus("Đã hủy");
                }
            }
            model.addAttribute(("message"), "Lấy dữ liệu thành công");
            model.addAttribute("transactionHistory", transactionHistory);
        } catch (Exception e) {
            model.addAttribute(("error"), "Lấy dữ liệu thất bại");
        }

        model.addAttribute("totalUser", totalUser);
        model.addAttribute("totalStockQuantity", totalStockQuantity);
        model.addAttribute("revenueToday", revenueToday);
        model.addAttribute("revenueForWeek", revenueForWeek);
        model.addAttribute("revenueForMonth", revenueForMonth);
        model.addAttribute("revenueForSeason", revenueForSeason);

        ObjectMapper objectMapper = new ObjectMapper();

        // Truyền JSON cho frontend
        model.addAttribute("revenueRecordForWeek", objectMapper.writeValueAsString(revenueRecordForWeek));
        model.addAttribute("revenueRecordForMonth", objectMapper.writeValueAsString(revenueRecordForMonth));
        model.addAttribute("revenueRecordForSeason", objectMapper.writeValueAsString(revenueRecordForSeason));

        model.addAttribute("top3BestSellerForLast7Days", top3BestSellerForLast7Days);

        return "vendor/dashboard";
    }
}
