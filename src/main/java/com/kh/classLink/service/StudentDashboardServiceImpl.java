package com.kh.classLink.service;

import com.kh.classLink.model.mapper.StudentDashboardMapper;
import com.kh.classLink.model.vo.AttendanceStats;
import com.kh.classLink.model.vo.Attend;
import com.kh.classLink.model.vo.LectureDate;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 학생 대시보드 서비스 구현체
 * - 출석률 계산
 * - 주간 출석 목록 조회
 * - 오늘 일정 조회
 * - 주간 이동 가능 여부 확인
 */
@Service
public class StudentDashboardServiceImpl implements StudentDashboardService {

    private final StudentDashboardMapper studentDashboardMapper;

    /**
     * Mapper 의존성 주입
     *
     * @param studentDashboardMapper 대시보드 Mapper
     */
    public StudentDashboardServiceImpl(StudentDashboardMapper studentDashboardMapper) {
        this.studentDashboardMapper = studentDashboardMapper;
    }

    /**
     * 이번달 출석 통계 조회
     *
     * @param memberNo 학생 번호
     * @return 출석/지각/결석 카운트 + 출석률
     */
    @Override
    public AttendanceStats getMonthlyAttendance(int memberNo) {
        return studentDashboardMapper.getMonthlyAttendance(memberNo);
    }

    /**
     * 주간 출석 기록 조회
     *
     * @param memberNo 학생 번호
     * @param weekOffset 주차 이동 값
     * @return 해당 주차 출석 기록
     */
    @Override
    public List<Attend> getWeeklyAttendance(int memberNo, int weekOffset) {
        return studentDashboardMapper.getWeeklyAttendance(memberNo, weekOffset);
    }

    /**
     * 오늘 일정 조회
     *
     * @param memberNo 학생 번호
     * @return 일정 리스트
     */
    @Override
    public List<LectureDate> getTodaySchedule(int memberNo) {
        return studentDashboardMapper.getTodaySchedule(memberNo);
    }

    /**
     * 이전 주 데이터 존재 여부 확인
     *
     * @param memberNo 학생 번호
     * @param weekOffset 현재 주 offset
     * @return 이전 주차에 출석 데이터가 있으면 true
     */
    @Override
    public boolean hasPrevWeek(int memberNo, int weekOffset) {
        int count = studentDashboardMapper.countPrevWeekAttendance(memberNo, weekOffset);
        return count > 0;
    }
}
