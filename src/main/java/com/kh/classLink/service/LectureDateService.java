package com.kh.classLink.service;

import com.kh.classLink.model.vo.LectureDate;
import com.kh.classLink.model.vo.LectureDateApproval;
import com.kh.classLink.model.vo.LectureDateApprovalList;

import java.util.List;

public interface LectureDateService {
    List<LectureDate> selectLectureDateList();
    List<LectureDate> selectLectureDateByClass(int classLectureNo);
    int insertLectureDate(LectureDate lectureDate);
    int updateLectureDate(LectureDate lectureDate);
    int deleteLectureDate(int lectureDateNo);
    int getClassLectureNoByMemberNo(int memberNo);
    int updateApprovalStatus(int lectureDateNo, String status, String reason, int approvedBy);
    List<LectureDateApprovalList> selectLectureDateApprovalList();
    LectureDateApprovalList selectLectureDateApprovalDetail(int lectureDateNo);
}
