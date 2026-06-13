package com.inventory.mapper;

import com.inventory.dto.DashboardChartDTO;
import com.inventory.dto.DashboardSalesTopDTO;
import com.inventory.dto.DashboardStockTopDTO;
import com.inventory.dto.StockHistoryListDTO;
import org.apache.ibatis.annotations.Mapper;

import java.math.BigDecimal;
import java.util.List;

@Mapper
public interface DashboardMapper {

    int countTotalItems();

    int countTotalWarehouses();

    int countLowStocks();

    int countTodayInbounds();

    int countTodayOutbounds();

    BigDecimal sumThisMonthSalesAmount();

    List<StockHistoryListDTO> findRecentStockHistories();

    // 재고 부족 TOP5
    List<DashboardStockTopDTO> findLowStockTop5();

    // 재고 수량 TOP5
    List<DashboardStockTopDTO> findStockQuantityTop5();

    // 제품별 매출 TOP5
    List<DashboardSalesTopDTO> findSalesTop5();

    // 월별 입고/출고 건수
    List<DashboardChartDTO> findMonthlyInboundOutboundCounts();

    // 월별 매출액
    List<DashboardChartDTO> findMonthlySalesAmount();
}
