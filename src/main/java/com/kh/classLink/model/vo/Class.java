package com.kh.classLink.model.vo;


import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Class {
    private int ClassId;
    private String ClassName;
    private int MemberAmount;
    private Date StartTime;
    private Date EndTime;
}
