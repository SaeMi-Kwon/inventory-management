package com.inventory.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PasswordResetDTO {
    private String employeeId;
    private String currentPassword;
    private String newPassword;
    private String confirmPassword;

}
