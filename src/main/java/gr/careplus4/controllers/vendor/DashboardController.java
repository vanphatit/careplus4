package gr.careplus4.controllers.vendor;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import gr.careplus4.entities.Bill;
import gr.careplus4.models.RevenueRecordModel;
import gr.careplus4.models.TransactionHistoryModel;
import gr.careplus4.services.PackageService;
import gr.careplus4.services.impl.BillServiceImpl;
import gr.careplus4.services.impl.StatisticsServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.Date;

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
                            @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
                            @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize,
                            @RequestParam(value = "status", required = false, defaultValue = "") String status,
                            HttpServletRequest request
    ) throws JsonProcessingException {

        int totalUser = statisticsService.getTotalUsertWithRoleUser();
        int totalStockQuantity = statisticsService.getTotalStockQuantity();

        List<Map<String, Object>> top3BestSellerForLast7Days = statisticsService.getTop3BestSellerForLast7Days();
        BigDecimal revenueToday = statisticsService.getRevenueToday();

        int totalStatusAwaiting = statisticsService.getTotalBillIsStatusAwaiting();
        int totalStatusShipping = statisticsService.getTotalBillIsStatusShipping();

        List<RevenueRecordModel> revenueRecordForWeek = statisticsService.getRevenueRecordForWeek();
        List<RevenueRecordModel> revenueRecordForMonth = statisticsService.getRevenueRecordForMonth();
        List<RevenueRecordModel> revenueRecordForSeason = statisticsService.getRevenueRecordForSeason();

        try {
            List<TransactionHistoryModel> transactionHistory = packageService.findAllTransactionHistory();

            for (TransactionHistoryModel transaction : transactionHistory) {
                Optional<Bill> bill = billService.findById(transaction.getIdBill());
                if (bill.isPresent()) {
                    bill.get().setStatus(transaction.getStatus());
                    bill.get().setUpdateDate(transaction.getDeliveryDate());
                    billService.saveBill(bill.get());
                }
            }

            currentPage = Math.max(currentPage, 1);
            Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("date").descending());

            Page<Bill> bills = billService.findAll(pageable);
            int totalShippingStatus = billService.countAllStatus(status);

            if (!status.isEmpty()) {
                bills = billService.findBillsByStatus(status, pageable);
            }

            int totalPages = bills.getTotalPages();
            if (totalPages > 0) {
                List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                        .boxed()
                        .collect(Collectors.toList());
                model.addAttribute("pageNumbers", pageNumbers);
            }

            Page<TransactionHistoryModel> transactionHistoryPage = bills.map(bill -> {
                TransactionHistoryModel transaction = new TransactionHistoryModel();
                transaction.setIdBill(bill.getId());
                transaction.setUserPhone(bill.getUser().getPhoneNumber());
                transaction.setReceiverName(bill.getName());
                BigDecimal totalAmount = bill.getTotalAmount();
                transaction.setTotalAmount(totalAmount);
                transaction.setDate(bill.getDate());
                transaction.setDeliveryDate(bill.getUpdateDate());
                transaction.setStatus(bill.getStatus());
                return transaction;
            });

            List<TransactionHistoryModel> transactionHistoryList = transactionHistoryPage.getContent();

            model.addAttribute("transactionHistory", transactionHistoryList);
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("status", status);
            model.addAttribute("totalShippingStatus", totalShippingStatus);
        } catch (Exception e) {
            model.addAttribute(("error"), "Lấy dữ liệu thất bại: " + e.getMessage());
        }

        model.addAttribute("totalUser", totalUser);
        model.addAttribute("totalStockQuantity", totalStockQuantity);
        model.addAttribute("revenueToday", revenueToday);
        model.addAttribute("totalStatusAwaiting", totalStatusAwaiting);
        model.addAttribute("totalStatusShipping", totalStatusShipping);

        ObjectMapper objectMapper = new ObjectMapper();

        // Truyền JSON cho frontend
        model.addAttribute("revenueRecordForWeek", objectMapper.writeValueAsString(revenueRecordForWeek));
        model.addAttribute("revenueRecordForMonth", objectMapper.writeValueAsString(revenueRecordForMonth));
        model.addAttribute("revenueRecordForSeason", objectMapper.writeValueAsString(revenueRecordForSeason));

        model.addAttribute("top3BestSellerForLast7Days", top3BestSellerForLast7Days);

        if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
            return "vendor/dashboard"; // Trả về toàn bộ trang JSP
        }

        return "vendor/dashboard";
    }
}
