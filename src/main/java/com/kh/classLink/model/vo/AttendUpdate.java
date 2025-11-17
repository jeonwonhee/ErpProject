package com.kh.classLink.model.vo;

import lombok.*;

import java.sql.Date;
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class AttendUpdate {

    private int attendUpdateNo;
    private String attendUpdateContent;
    private Date correctionApplicationDate;
    private String status;
    private String refusal;
    private int approverMemberNo;
    private int attendNo;
    private String attendStatus;

    private AttendUpdatefile file;

}
