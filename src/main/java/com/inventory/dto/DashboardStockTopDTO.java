package com.inventory.dto;

import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class DashboardStockTopDTO {
    private Long stockId;
    private String itemCode;
    private String itemName;
    private String warehouseName;
    private Integer quantity;
    private Integer safetyStock;

}
