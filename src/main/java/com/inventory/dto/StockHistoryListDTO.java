package com.inventory.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class StockHistoryListDTO {
    private Long historyId;
    private String historyType;
    private Long inboundId;
    private Long outboundId;
    private Integer beforeQuantity;
    private Integer changeQuantity;
    private Integer afterQuantity;
    private Long itemId;
    private String itemCode;
    private String itemName;
    private Long warehouseId;
    private String warehouseName;
    private Long processUserId;
    private String processUserName;
    private String remark;
    private LocalDateTime createdAt;

    // 검색용
    private String keyword;
}
