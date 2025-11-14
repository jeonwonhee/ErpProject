package com.kh.classLink.model.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface LectureMapper {

    int selectLectureNoByMemberNo(@Param("memberNo") int memberNo);
}
