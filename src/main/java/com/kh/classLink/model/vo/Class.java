package com.kh.classLink.model.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Class {
    private int classNo;
    private String className;
    private int memberCount;
    private Date startDate;
    private Date endDate;
}
