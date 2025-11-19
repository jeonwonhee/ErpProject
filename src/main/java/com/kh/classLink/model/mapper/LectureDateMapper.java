package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.ClassLecture;
import com.kh.classLink.model.vo.LectureDate;
import com.kh.classLink.model.vo.LectureDateApproval;
import com.kh.classLink.model.vo.LectureDateApprovalList;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;


import java.util.List;
import java.util.Map;

@Mapper
public interface LectureDateMapper {

    /* 전체 일정 조회 */
    List<LectureDate> selectLectureDateList(int classLectureNo);

    /* 강사가 담당하는 반 조회 */
    List<ClassLecture> selectClassLectureList(int memberNo);

    /* 일정 등록 (INSERT) */
    int insertLectureDate(LectureDate lectureDate);

    /* 일정 신청 관리 추가 (INSERT) */
    int insertLectureDateApproval(@Param("lectureDateNo") int lectureDateNo);

    /* 일정 신청 관리 갱신 (UPDATE) */
    int updateApprovalStatus(@Param("lectureDateNo") int lectureDateNo,
                             @Param("status") String status,
                             @Param("reason") String reason,
                             @Param("approvedBy") int approvedBy);

    LectureDateApprovalList selectLectureDateApprovalDetail(int lectureDateNo);

    int getLectureDateListCount();

    List<LectureDateApprovalList> selectLectureDateListPaged(Map<String, Object> map);

    int getLectureDateCount(int classLectureNo);

    List<LectureDate> selectLectureDatePaged(Map<String, Object> map);

    // 학생용 일정 조회
    List<LectureDate> selectLectureDateListStudent(int memberNo);

    // 학생 반 이름 조회
    String selectClassNameByStudent(int memberNo);

    // 일정 중복 조회
    int checkDateOverlap(LectureDate lectureDate);
}
