package com.kh.classLink.model.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor

public class GradeDto {
    private int gradeNo;          // GRADE_NO
    private int grade;            // GRADE
    private int classLectureNo;   // CLASS_LECTURE_NO
    private int studentNo;        // STUDENT_NO
    private String testName;      // TEST_NAME
    private Date createDate;      // CREATE_DATE

    // 화면 표시용 추가 필드
    private String studentName;   // MEMBER.MEMBER_NAME
    private String lectureName;   // LECTURE.LECTURE_NAME
    private String className;     // CLASS.CLASS_NAME

}

