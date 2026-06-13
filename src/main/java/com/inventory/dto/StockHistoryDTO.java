package com.inventory.dto;

import com.inventory.util.DateFormatUtil;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class StockHistoryDTO {
    private Long historyId;
    private Long itemId;
    private Long warehouseId;
    private String historyType;
    private Long inboundId;
    private Long outboundId;
    private Integer beforeQuantity;
    private Integer changeQuantity;
    private Integer afterQuantity;
    private Long processUserId;
    private String remark;
    private LocalDateTime createdAt;

    public String getCreatedAtText() {
        return DateFormatUtil.format(createdAt);
    }

}
