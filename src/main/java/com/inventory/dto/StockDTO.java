package com.inventory.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class StockDTO {

    private Long stockId;
    private Long itemId;
    private Long warehouseId;
    private Integer quantity;
    private Integer safetyStock;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

}
