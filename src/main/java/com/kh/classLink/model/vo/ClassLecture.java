package com.kh.classLink.model.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Date;

@Getter
@Setter
@ToString
public class ClassLecture {
    private int classLectureNo;
    private int classNo;
    private int lectureNo;
    private String classDesc;
    private Date planStartDate;
    private Date planEndDate;

    private String className;
    private String memberName;
    private int memberNo;
    private String lectureName;

    private String lectureNoList;
    private String classLectureNoList;
}
