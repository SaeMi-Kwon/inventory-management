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
public class CustomerDTO {

    private Long customerId;
    private String customerCode;
    private String customerName;
    private String customerType;
    private String businessNo;
    private String ceoName;
    private String phone;
    private String email;
    private String address;
    private String managerName;
    private String managerPhone;
    private String useYn;
    private String remark;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

}
