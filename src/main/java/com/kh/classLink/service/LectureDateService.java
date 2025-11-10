package com.kh.classLink.service;

import com.kh.classLink.model.vo.LectureDate;

import java.util.List;

public interface LectureDateService {
    List<LectureDate> selectLectureDateList();
    List<LectureDate> selectLectureDateByClass(int classLectureNo);
    int insertLectureDate(LectureDate lectureDate);
    int updateLectureDate(LectureDate lectureDate);
    int deleteLectureDate(int lectureDateNo);
    int getClassLectureNoByMemberNo(int memberNo);
}
