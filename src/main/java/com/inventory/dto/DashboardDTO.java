package com.inventory.dto;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
public class DashboardDTO {
    private int totalItemCount;  //품목 수
    private int totalWarehouseCount;  //창고 수
    private int lowStockCount;  //재고부족 품목 수
    private int todayInboundCount;  //오늘 입고 건수
    private int todayOutboundCount;  //오늘 출고 건수
    private BigDecimal thisMonthSalesAmount; //이번달 매출액

    private List<StockHistoryListDTO> recentHistoryList;  //최근 재고이력 5건

    private List<DashboardStockTopDTO> lowStockTopList;
    private List<DashboardStockTopDTO> stockQuantityTopList;
    private List<DashboardSalesTopDTO> salesTopList;

    private List<DashboardChartDTO> monthlyInOutList;
    private List<DashboardChartDTO> monthlySalesList;


}
