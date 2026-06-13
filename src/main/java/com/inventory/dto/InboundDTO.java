package com.inventory.dto;

import com.inventory.util.DateFormatUtil;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
public class InboundDTO {
    private Long inboundId;
    private String inboundNo;
    private String inboundType;
    private Long customerId;
    private Long warehouseId;
    private LocalDate inboundDate;
    private String status;
    private Long createdUserId;
    private String remark;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private List<InboundDetailDTO> detailList;

    public String getCreatedAtText() {
        return DateFormatUtil.format(createdAt);
    }

    public String getUpdatedAtText() {
        return DateFormatUtil.format(updatedAt);
    }
}
