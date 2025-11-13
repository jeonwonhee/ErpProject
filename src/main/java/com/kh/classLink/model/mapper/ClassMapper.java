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
}
