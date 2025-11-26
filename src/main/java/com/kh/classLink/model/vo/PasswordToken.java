package com.kh.classLink.model.vo;

import lombok.*;
import oracle.sql.TIMESTAMP;

import java.sql.Date;
import java.time.LocalDateTime;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class PasswordToken {
    private int passwordTokenNo;
    private int memberNo;
    private String token;
    private LocalDateTime endDate;
    private String status;
    private Date createDate;
    private Date updateDate;
}
