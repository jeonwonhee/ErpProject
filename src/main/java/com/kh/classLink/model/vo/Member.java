package com.kh.classLink.model.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Member {
    private int memberNo;
    private String memberId;
    private String memberName;
    private String memberPassword;
    private Date createDate;
    private Date updateDate;
    private String status;
    private String email;
    private String phone;
    private String address;
    private String role;
    private Date BirthDate;


    private String lectureName;
    private String commuteRate;
    private String commuteMonth;
}
