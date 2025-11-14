package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.GradeDto;
import com.kh.classLink.model.vo.Lecture;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface GradeMapper {

    /**
     * 특정 학생이 수강 중인 강의 목록 조회
     * @param memberNo 학생 고유번호
     * @return 학생이 듣는 강의 리스트
     */
    List<Lecture> findLecturesByStudent(@Param("memberNo") int memberNo);

    /**
     * 특정 학생의 최근 성적 목록 조회
     * @param memberNo  회원 고유번호(로그인 학생)
     * @param lectureNo 강의 고유번호
     * @param limit     조회할 개수
     */
    List<GradeDto> findLatestGrades(@Param("memberNo") int memberNo,
                                    @Param("lectureNo") int lectureNo,
                                    @Param("limit") int limit);

    int selectClassLectureNo(@Param("classNo") int classNo,
                             @Param("lectureNo") int lectureNo);

    int insertGrade(GradeDto gradeDto);


}
