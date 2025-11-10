package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.LectureDate;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;


import java.util.List;

@Mapper
public interface LectureDateMapper {

    /* 전체 일정 조회 */
    List<LectureDate> selectLectureDateList();

    /* 특정 반(CLASS_LECTURE_NO)의 일정 조회 */
    List<LectureDate> selectLectureDateByClass(int classLectureNo);

    /* 일정 등록 (INSERT) */
    int insertLectureDate(LectureDate lectureDate);

    /* 강사의 담당 반(CLASS_LECTURE_NO) 조회 */
    int selectClassLectureNoByMemberNo(int memberNo);

    /* 일정 수정 (UPDATE) */
    int updateLectureDate(LectureDate lectureDate);

    /* 일정 삭제 (DELETE) */
    int deleteLectureDate(int lectureDateNo);

}
