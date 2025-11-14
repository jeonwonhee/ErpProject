package com.kh.classLink.service;

import java.util.List;
import java.util.Map;

/**
 * 관리자 대시보드에서 필요한 통계 데이터를 제공하는 서비스 인터페이스
 */
public interface AdminDashboardService {

    /** 전체 학생 수 */
    int getTotalStudents();

    /** 전체 강사 수 */
    int getTotalLectures();

    /** 학생 평균 출석률 (%) */
    double getStudentAvgRate();

    /** 강사 평균 출석률 (%) */
    double getLectureAvgRate();

    /** 오늘 결석자 수 */
    int getTodayAbsents();

    /** 요일별 출석률 */
    List<Map<String, Object>> getWeeklyAttendRate();

    /** 상담 신청 대기 */
    int getPendingCounselCount();

    /** 휴가 신청 대기 */
    int getPendingVacationCount();

    /** 기자재 렌탈 신청 대기 */
    int getPendingDeviceRentCount();
}