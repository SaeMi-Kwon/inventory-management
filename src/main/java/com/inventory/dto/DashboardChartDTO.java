package com.inventory.dto;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class DashboardChartDTO {
    private String label;
    private Integer inboundCount;
    private Integer outboundCount;
    private BigDecimal salesAmount;

}
