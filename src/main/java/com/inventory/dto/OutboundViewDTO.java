package com.inventory.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
public class OutboundViewDTO {
    private Long outboundId;
    private String outboundNo;
    private String outboundType;
    private Long warehouseId;
    private LocalDate outboundDate;
    private String status;
    private String remark;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String customerName;
    private String warehouseName;
    private String createdUserName;

    private List<OutboundDetailViewDTO> detailList;

}
