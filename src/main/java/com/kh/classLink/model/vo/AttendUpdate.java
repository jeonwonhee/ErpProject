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
    private int memberNo;
    private String studentName;
    private String approverMemberName;

    private Date createDate;
    private Date updateDate;

    private AttendUpdatefile file;

    private String hasFile;

    private int attendUpdateFileNo;
    private String attendUpdateFileName;
    private String filePath;
    private String attendUpdateFileOriName;




}
