package com.kh.classLink.model.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CommuteMapper {
    void insertCommuteIn(@Param("memberNo") int memberNo,
                         @Param("status") String status);

    int checkTodayCommute(@Param("memberNo") int memberNo);
}