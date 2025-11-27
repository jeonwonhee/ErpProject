package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.Commute;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CommuteMapper {

    // 출근 등록
    void insertCommuteIn(@Param("memberNo") int memberNo,
                         @Param("status") String status);

    // 오늘 이미 출근 했는지 확인
    int checkTodayCommute(@Param("memberNo") int memberNo);

    // 가장 최근 출근 기록 조회 (퇴근 처리 대상)
    Commute selectLatestCommute(@Param("memberNo") int memberNo);

    //  퇴근 처리 (상태 OUT으로 변경)
    int updateCommuteOut(@Param("commuteNo") int commuteNo);
}