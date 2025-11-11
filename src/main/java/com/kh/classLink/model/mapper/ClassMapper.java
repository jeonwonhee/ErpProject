package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.Class;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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

}
