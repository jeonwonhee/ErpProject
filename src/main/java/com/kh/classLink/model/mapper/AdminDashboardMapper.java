package com.kh.classLink.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface AdminDashboardMapper {

    // 전체 학생 수
    int getTotalStudents();

    // 전체 강사 수
    int getTotalLectures();

    // 학생 평균 출석률
    double getStudentAvgRate();

    // 강사 평균 출석률
    double getLectureAvgRate();

    // 오늘 결석자 수
    int getTodayAbsents();

    // 요일별 출석률
    List<Map<String, Object>> getWeeklyAttendRate();

    // 상담 신청 대기
    int getPendingCounselCount();

    // 휴가 신청 대기
    int getPendingVacationCount();

    // 기자재 렌탈 신청 대기
    int getPendingDeviceRentCount();
}