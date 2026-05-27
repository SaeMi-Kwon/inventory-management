package com.inventory.dto;

import com.fasterxml.jackson.annotation.JsonAnyGetter;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class OutboundDetailViewDTO {
    private Long outboundDetailId;
    private Long outboundId;
    private Long itemId;
    private String itemCode;
    private String itemName;
    private Integer quantity;
    private BigDecimal unitPrice;
    private BigDecimal totalPrice;
    private String remark;

}
