package com.kh.classLink.service;

import com.kh.classLink.model.vo.Class;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ClassService {

    String selectClassNameByClassNo(int classNo);

    //수강반 리스트 가져오기
    List<Class> selectClassList();

    //강사가 담당하고 있는 수강반 조회
    List<Class> selectClassByLecture( int memberNo, int lectureNo);

    //수강반에 소속된 학생 목록 조회
    List<Class> selectStudentsByClassNo(int classNo);
}
