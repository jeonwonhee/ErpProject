package com.kh.classLink.model.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class LectureDate {

    private int lectureDateNo;
    private Date startDate;
    private Date endDate;
    private String title;
    private String content;
    private int classLectureNo;
    private String dateType;
    private String status;

}
