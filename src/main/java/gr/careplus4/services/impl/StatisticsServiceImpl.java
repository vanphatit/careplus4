package gr.careplus4.services.impl;

import gr.careplus4.models.RevenueRecordModel;
import gr.careplus4.services.iStatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Service
public class StatisticsServiceImpl implements iStatisticsService {
    @Autowired
    private UserServiceImpl userService;

    @Autowired
    private BillServiceImpl billService;

    @Autowired
    private MedicineServicesImpl medicineService;

    @Override
    public int getTotalUsertWithRoleUser() {
        return userService.countUsersWithRoleUserIsActive();
    }

    @Override
    public int getTotalStockQuantity() {
        return medicineService.countAllStockQuantity();
    }

    @Override
    public BigDecimal getRevenueToday() {
        return billService.getRevenueToday();
    }

    @Override
    public List<Map<String, Object>> getTop3BestSellerForLast7Days() {
        return medicineService.findTop3PopularMedicinesLast7Days();
    }

    @Override
    public BigDecimal getRevenueForWeek() {
        return billService.getRevenueForWeek();
    }

    @Override
    public BigDecimal getRevenueForMonth() {
        return billService.getRevenueForMonth();
    }

    @Override
    public BigDecimal getRevenueForSeason() {
        return billService.getRevenueForSeason();
    }

    @Override
    public List<RevenueRecordModel> getRevenueRecordForWeek() {
        return billService.getRevenueRecordForWeek();
    }

    @Override
    public List<RevenueRecordModel> getRevenueRecordForMonth() {
        return billService.getRevenueRecordForMonth();
    }

    @Override
    public List<RevenueRecordModel> getRevenueRecordForSeason() {
        return billService.getRevenueRecordForSeason();
    }

    @Override
    public int getTotalBillIsStatusAwaiting() {
        return billService.countBillIsStatusAwaiting();
    }

    @Override
    public int getTotalBillIsStatusShipping() {
        return billService.countBillIsStatusShipping();
    }

}
