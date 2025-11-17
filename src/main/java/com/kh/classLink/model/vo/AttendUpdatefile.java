package com.kh.classLink.model.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class AttendUpdatefile {

    private int attendUpdateFileNo;
    private int attendUpdateNo;
    private String attendUpdateFileName;
    private String attendUpdateFileOriName;
    private String filePath;
    private Date createDate;
    private Date updateDate;

}
