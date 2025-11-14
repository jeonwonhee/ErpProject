package com.kh.classLink.service;

import com.kh.classLink.model.vo.AttendanceStats;
import com.kh.classLink.model.vo.Attend;
import com.kh.classLink.model.vo.LectureDate;

import java.util.List;

/**
 * 학생 대시보드 서비스
 * - 출석률 조회
 * - 주간 출석 기록 조회
 * - 오늘 일정 조회
 * - 주간 이동 가능 여부 확인
 */
public interface StudentDashboardService {

    /**
     * 이번달 출석 통계 조회 (출석/지각/결석)
     *
     * @param memberNo 학생 번호
     * @return AttendanceStats (이번달 출석 통계)
     */
    AttendanceStats getMonthlyAttendance(int memberNo);

    /**
     * 주간 출석 기록 조회
     * (weekOffset 값에 따라 이번 주 / 지난 주 / 지지난 주 조회 가능)
     *
     * @param memberNo 학생 번호
     * @param weekOffset 주차 이동 값
     *                   0 = 이번 주
     *                  -1 = 지난 주
     *                  -2 = 지지난 주
     * @return 해당 주차의 출석 기록 목록
     */
    List<Attend> getWeeklyAttendance(int memberNo, int weekOffset);

    /**
     * 오늘 일정 조회
     *
     * @param memberNo 학생 번호
     * @return 오늘 일정 리스트
     */
    List<LectureDate> getTodaySchedule(int memberNo);

    /**
     * 이전 주 이동 가능 여부 확인
     * (이전 주차에 출석 데이터가 존재하면 true)
     *
     * @param memberNo 학생 번호
     * @param weekOffset 현재 주차 offset
     * @return 이전 주 데이터 존재 여부
     */
    boolean hasPrevWeek(int memberNo, int weekOffset);
}
