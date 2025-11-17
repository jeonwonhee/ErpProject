package com.kh.classLink.model.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Attend {
    private int attendNo;
    private String attendStatus;
    private Date attendDate;
    private Date createDate;
    private Date updateDate;
    private int sessionNo;
    private int studentNo;

    private String memberName;
    private String className;
    private int classNo;
}
