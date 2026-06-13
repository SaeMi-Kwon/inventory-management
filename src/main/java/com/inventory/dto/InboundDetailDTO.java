package com.inventory.dto;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class InboundDetailDTO {
    private Long inboundDetailId;
    private Long inboundId;
    private Long itemId;
    private Integer quantity;
    private BigDecimal unitPrice;
    private BigDecimal totalPrice;
    private String remark;

    // 화면 표시용
    private String itemCode;
    private String itemName;


}
