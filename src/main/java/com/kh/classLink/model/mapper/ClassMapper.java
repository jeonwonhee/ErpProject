package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.Class;
import com.kh.classLink.model.vo.ClassLecture;
import com.kh.classLink.model.vo.Lecture;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.List;

@Mapper
public interface ClassMapper {

    //classNo로 className 조회
    String selectClassNameByClassNo(@Param("classNo") int classNo);

    // 전체 수강반 목록 조회
    List<Class> selectClassList();

    //강사가 담당하고 있는 수강반 조회
    List<Class> selectClassByLecture(@Param("memberNo") int memberNo,
                                     @Param("lectureNo") int lectureNo);

    //수강반에 소속된 학생 목록 조회
    List<Class> selectStudentsByClassNo(@Param("classNo") int classNo);


    /**
     * 반 정보 전체 조회
     * @return
     */
    ArrayList<Class> selectClassInfoList(int classNo);

    /**
     * 수업 정보 조회
     * @return
     */
    ArrayList<Lecture> selectLecture();

    /**
     * 반 등록
     * @param classInfo
     * @return
     */
    int insertClass(Class classInfo);

    /**
     * 반별 수업 배정
     * @param classLecture
     * @return
     */
    int insertClassLecture(ClassLecture classLecture);

    /**
     * 배정 수업 정보 조회
     * @param classNo
     * @return
     */
    ArrayList<Lecture> selectClassLectureByClassNo(int classNo);

    /**
     * 반 정보 수정
     * @param classInfo
     * @return
     */
    int updateClass(Class classInfo);

    /**
     * 배정된 수업 삭제
     * @param classNo
     * @return
     */
    int deleteClassLecture(int classNo);

}
