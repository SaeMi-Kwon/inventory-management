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
        dashboardDTO.setRecentHistoryList(dashboardMapper.findRecentStockHistories());

        return dashboardDTO;
    }


}
