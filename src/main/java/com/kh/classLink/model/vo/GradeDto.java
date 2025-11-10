package com.kh.classLink.model.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor

public class GradeDto {
    private String lectureName; // 과목명
    private String studentName; // 학생이름
    private Integer grade;      // 점수

}
