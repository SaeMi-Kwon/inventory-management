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
public class WarehouseDTO {
    private Long warehouseId;
    private String warehouseCode;
    private String warehouseName;
    private String location;
    private String useYn;
    private String remark;
    private LocalDateTime createdAt;

}
