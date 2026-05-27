package com.inventory.dto;

import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

@Getter
@Setter
public class OutboundDetailDTO {
    private Long outboundDetailId;
    private Long outboundId;
    private Long itemId;
    private Integer quantity;
    private BigDecimal unitPrice;
    private BigDecimal totalPrice;
    private String remark;

}
