package com.inventory.dto;

import com.inventory.util.DateFormatUtil;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
public class OutboundListDTO {
    private Long outboundId;
    private String outboundNo;
    private String outboundType;
    private LocalDate outboundDate;
    private String status;
    private LocalDateTime createdAt;
    private String customerName;
    private String warehouseName;
    private String createdUserName;

    public String getCreatedAtText() {
        return DateFormatUtil.format(createdAt);
    }
}
