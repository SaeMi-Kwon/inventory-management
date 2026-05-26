package com.inventory.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
public class InboundViewDTO {
    private Long inboundId;
    private String inboundNo;
    private String inboundType;
    private LocalDate inboundDate;
    private String status;
    private String remark;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Long warehouseId;
    private String customerName;
    private String warehouseName;
    private String createdUserName;

    private List<InboundDetailViewDTO> detailList;

}
