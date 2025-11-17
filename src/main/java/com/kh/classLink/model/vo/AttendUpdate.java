package com.kh.classLink.model.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class AttendUpdate {

    private int attendUpdateNo;
    private String attendUpdateContent;
    private Date correctionApplicationDate;
    private String status;
    private String refusal;
    private int approverMemberNo;
    private int attendNo;
    private String attendStatus;
    private Date createDate;
    private Date updateDate;

    private AttendUpdatefile file;
    private int memberNo;
    private String studentName;
    private String approverMemberName;
    private String hasFile;



}
