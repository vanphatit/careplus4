package gr.careplus4.controllers.admin;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import gr.careplus4.entities.Medicine;
import gr.careplus4.models.RevenueRecordModel;
import gr.careplus4.models.TransactionHistoryModel;
import gr.careplus4.services.PackageService;
import gr.careplus4.services.impl.StatisticsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping({"/admin", "/vendor"})
public class DashboardController {

    @Autowired
    public StatisticsServiceImpl statisticsService;

    @Autowired
    public PackageService packageService;

    @RequestMapping({"/", "/dashboard"})
    public String dashboard(Model model) throws JsonProcessingException {

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
        List<TransactionHistoryModel> transactionHistory = packageService.findAllTransactionHistory();

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

        model.addAttribute("transactionHistory", transactionHistory);

        model.addAttribute("top3BestSellerForLast7Days", top3BestSellerForLast7Days);

        return "admin/dashboard";
    }
}
