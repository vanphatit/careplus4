package gr.careplus4.services;

import gr.careplus4.entities.Medicine;
import gr.careplus4.models.RevenueRecordModel;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public interface iStatisticsService {
    int getTotalUsertWithRoleUser();

    int getTotalStockQuantity();

    BigDecimal getRevenueToday();

    List<Map<String, Object>> getTop3BestSellerForLast7Days();

    BigDecimal getRevenueForWeek();

    BigDecimal getRevenueForMonth();

    BigDecimal getRevenueForSeason();

    List<RevenueRecordModel> getRevenueRecordForWeek();

    List<RevenueRecordModel> getRevenueRecordForMonth();

    List<RevenueRecordModel> getRevenueRecordForSeason();
}
