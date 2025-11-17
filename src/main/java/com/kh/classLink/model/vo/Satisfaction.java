package com.kh.classLink.model.vo;

import lombok.*;
import java.sql.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Satisfaction {

    private int satisfactionNo;        // 만족도 조사 번호

    private int classRating;           // 수업 만족도 (1~5)
    private int lectureRating;         // 강사 만족도 (1~5)

    private String suggestion;         // 자유 의견

    private Date createDate;           // CREATE_DATE
    private Date endDate;              // END_DATE

    private int classLectureNo;        // CLASS_LECTURE_NO (FK)
    private int studentNo;             // STUDENT_NO (FK)
}

