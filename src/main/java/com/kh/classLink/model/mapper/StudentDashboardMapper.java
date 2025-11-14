package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.AttendanceStats;
import com.kh.classLink.model.vo.Attend;
import com.kh.classLink.model.vo.LectureDate;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 학생 대시보드 Mapper
 * - 출석 통계, 주간 출석, 일정
 */
@Mapper
public interface StudentDashboardMapper {

    /**
     * 이번 달 출석 통계 조회
     *
     * @param memberNo 학생 번호
     * @return AttendanceStats 객체 (출석/지각/결석 카운트)
     */
    AttendanceStats getMonthlyAttendance(@Param("memberNo") int memberNo);

    /**
     * 주간 출석 기록 조회
     *
     * @param memberNo 학생 번호
     * @param weekOffset 주차 offset (0=이번주, 1=지난주 등)
     * @return 주간 출석 리스트
     */
    List<Attend> getWeeklyAttendance(
            @Param("memberNo") int memberNo,
            @Param("weekOffset") int weekOffset
    );

    /**
     * 오늘 일정 조회
     *
     * @param memberNo 학생 번호
     * @return Today Schedule
     */
    List<LectureDate> getTodaySchedule(@Param("memberNo") int memberNo);

    /**
     * 이전 주차에 출석 데이터가 존재하는지 확인
     *
     * @param memberNo 학생 번호
     * @param weekOffset 현재 주차 offset
     * @return 출석 데이터 수
     */
    int countPrevWeekAttendance(
            @Param("memberNo") int memberNo,
            @Param("weekOffset") int weekOffset
    );
}