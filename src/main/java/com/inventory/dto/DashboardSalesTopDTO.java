package com.inventory.dto;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class DashboardSalesTopDTO {
    private String itemCode;
    private String itemName;
    private Integer salesQuantity;
    private BigDecimal salesAmount;
}
