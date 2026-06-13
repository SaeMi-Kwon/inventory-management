package com.inventory.dto;

import com.inventory.util.DateFormatUtil;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserDTO {

    private Long userId;
    private Long authId;
    private String employeeId;
    private String password;
    private String department;
    private String name;
    private LocalDate birth;
    private String phone;
    private String email;
    private String address;
    private LocalDate hireDate;
    private LocalDate retireDate;
    private String status;
    private String useYn;
    private String remark;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // 권한 JOIN 조회용
    private String authCode;
    private String authName;


    public String getCreatedAtText() {
        return DateFormatUtil.format(createdAt);
    }

    public String getUpdatedAtText() {
        return DateFormatUtil.format(updatedAt);
    }
}
