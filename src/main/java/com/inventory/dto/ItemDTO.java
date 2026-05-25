package com.inventory.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ItemDTO {

    private Long itemId;
    private String itemCode;
    private String itemName;
    private String itemType;
    private String category;
    private String spec;
    private String unit;
    private BigDecimal purchasePrice;
    private BigDecimal salePrice;
    private String useYn;
    private String remark;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

}
