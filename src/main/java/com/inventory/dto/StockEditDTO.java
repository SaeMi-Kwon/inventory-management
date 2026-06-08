package com.inventory.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class StockEditDTO {

    private Long stockId;
    private Long itemId;
    private Long warehouseId;
    private String itemCode;
    private String itemName;
    private String warehouseName;
    private Integer quantity;
    private Integer safetyStock;
    //재고변동이력 비고
    private String adjustRemark;

}
