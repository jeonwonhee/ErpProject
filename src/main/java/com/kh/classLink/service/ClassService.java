package com.kh.classLink.service;

import com.kh.classLink.model.vo.Class;
import com.kh.classLink.model.vo.ClassLecture;
import com.kh.classLink.model.vo.Lecture;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface ClassService {

    String selectClassNameByClassNo(int classNo);

    //수강반 리스트 가져오기
    List<Class> selectClassList();

    //강사가 담당하고 있는 수강반 조회
    List<Class> selectClassByLecture( int memberNo, int lectureNo);

    //수강반에 소속된 학생 목록 조회
    List<Class> selectStudentsByClassNo(int classNo);
    /**
     * 반 정보 전체 조회
     * @return
     */
    ArrayList<Class> selectClassList(int classNo);

    /**
     * 수업 정보 조회
     * @return
     */
    Map<String,Object> selectLecture();

    /**
     * 반 및 반별 수업 배정 등록
     * @param classInfo
     * @param classLecture
     * @return
     */
    int insertClass(Class classInfo, ClassLecture classLecture);

    /**
     * 반 정보 및 배정 수업 정보 조회
     * @param classNo
     * @return
     */
    Map<String,Object> selectClassInfoByClassNo(int classNo);

    /**
     * 반 정보 수정
     * @param classInfo
     * @param classLecture
     * @return
     */
    int updateClass(Class classInfo, ClassLecture classLecture);

}
