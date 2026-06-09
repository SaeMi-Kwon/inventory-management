package com.inventory.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class DashboardDTO {
    private int totalItemCount;  //품목 수
    private int totalWarehouseCount;  //창고 수
    private int lowStockCount;  //재고부족 품목 수
    private int todayInboundCount;  //오늘 입고 건수
    private int todayOutboundCount;  //오늘 출고 건수

    private List<StockHistoryListDTO> recentHistoryList;  //최근 재고이력 5건

}
