package com.kh.classLink.service;

import com.kh.classLink.model.vo.GradeDto;
import com.kh.classLink.model.vo.Lecture;
import java.util.List;

public interface GradeService {

    /**
     * 특정 학생이 수강 중인 강의 목록 조회
     * @param memberNo 학생 고유번호
     * @return 해당 학생의 강의 목록
     */
    List<Lecture> findLecturesByStudent(int memberNo);

    /**
     * 특정 학생의 최근 성적 목록 조회
     * @param memberNo 학생 고유번호
     * @param lectureNo 강의 고유번호
     * @param limit     조회할 성적 개수 제한
     * @return 성적 정보 리스트
     */
    List<GradeDto> findLatestGrades(int memberNo, int lectureNo, int limit);

    // CLASS_LECTURE_NO 조회 (CLASS_NO + LECTURE_NO)
    int findClassLectureNo(int classNo, int lectureNo);

    // 성적 여러 개 저장
    void insertGrades(List<GradeDto> gradeList);

    //학생 성적조회
    List<GradeDto> findGradesByStudentAndLecture(int studentNo, int lectureNo);

    // 성적 수정 검색
    List<GradeDto> searchGradesForEdit(int classNo, String keyword, int lectureNo);

    List<String> findTestNamesByStudent(int memberNo);

    int updateGrade(GradeDto gradeDto);
}


