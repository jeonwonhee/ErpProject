package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.ClassStudent;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ClassStudentMapper {

    int insertClassStudent(
            @Param("memberNo") int memberNo,
                            @Param("classNo") int classNo
    );
}
