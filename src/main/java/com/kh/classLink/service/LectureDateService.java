package com.kh.classLink.service;

import com.kh.classLink.model.vo.ClassLecture;
import com.kh.classLink.model.vo.LectureDate;
import com.kh.classLink.model.vo.LectureDateApproval;
import com.kh.classLink.model.vo.LectureDateApprovalList;

import java.util.List;
import java.util.Map;

public interface LectureDateService {
    List<LectureDate> selectLectureDateList(int classLectureNo);
    List<ClassLecture> selectLectureDateByClass(int memberNo);
    int insertLectureDate(LectureDate lectureDate);
    int updateLectureDate(LectureDate lectureDate);
    int deleteLectureDate(int lectureDateNo);
    int updateApprovalStatus(int lectureDateNo, String status, String reason, int approvedBy);
    List<LectureDateApprovalList> selectLectureDateApprovalList();
    LectureDateApprovalList selectLectureDateApprovalDetail(int lectureDateNo);
    int getLectureDateListCount();
    List<LectureDateApprovalList> selectLectureDateListPaged(Map<String, Object> map);
    int getLectureDateCount(int classLectureNo);
    List<LectureDate> selectLectureDatePaged(Map<String, Object> map);


    List<LectureDate> selectLectureDateListStudent(int memberNo);
    String getClassNameByStudent(int memberNo);

}
