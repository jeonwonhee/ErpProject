package com.kh.classLink.model.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LectureSatisfaction {
    private int classLectureNo;
    private String className;
    private String lectureName;

    private double avgClassRating;
    private double avgLectureRating;

    private int submittedCount;
    private int totalCount;
}
