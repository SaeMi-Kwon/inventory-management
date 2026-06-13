package com.inventory.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class AuthorityDTO {
    private Long authId;
    private String authCode;
    private String authName;
    private String description;
    private String useYn;
    private LocalDateTime createdAt;

}
