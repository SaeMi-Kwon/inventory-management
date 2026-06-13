package com.inventory.service;

import com.inventory.dto.DashboardDTO;
import com.inventory.mapper.DashboardMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class DashboardService {

    private final DashboardMapper dashboardMapper;

    public DashboardDTO getDashboard(){

        DashboardDTO dashboardDTO = new DashboardDTO();

        dashboardDTO.setTotalItemCount(dashboardMapper.countTotalItems());
        dashboardDTO.setTotalWarehouseCount(dashboardMapper.countTotalWarehouses());
        dashboardDTO.setLowStockCount(dashboardMapper.countLowStocks());
        dashboardDTO.setTodayInboundCount(dashboardMapper.countTodayInbounds());
        dashboardDTO.setTodayOutboundCount(dashboardMapper.countTodayOutbounds());
        dashboardDTO.setThisMonthSalesAmount(dashboardMapper.sumThisMonthSalesAmount());

        dashboardDTO.setRecentHistoryList(dashboardMapper.findRecentStockHistories());

        dashboardDTO.setLowStockTopList(dashboardMapper.findLowStockTop5());
        dashboardDTO.setStockQuantityTopList(dashboardMapper.findStockQuantityTop5());
        dashboardDTO.setSalesTopList(dashboardMapper.findSalesTop5());

        dashboardDTO.setMonthlyInOutList(dashboardMapper.findMonthlyInboundOutboundCounts());
        dashboardDTO.setMonthlySalesList(dashboardMapper.findMonthlySalesAmount());




        return dashboardDTO;
    }


}
