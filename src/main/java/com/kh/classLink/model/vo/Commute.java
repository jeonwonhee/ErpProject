package com.kh.classLink.model.vo;

import lombok.*;

import java.sql.Date;
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Commute {
    private int commuteNo;
    private String commuteStatus;
    private Date commuteDate;
    private Date createDate;
    private Date updateDate;
    private int memberNo;
}
