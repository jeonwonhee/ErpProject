package com.kh.classLink.service;

import com.kh.classLink.model.mapper.AdminDashboardMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 관리자 대시보드 서비스 구현체
 * Mapper에서 가져온 데이터를 가공하여 Controller로 전달
 */
@Service
public class AdminDashboardServiceImpl implements AdminDashboardService {

    private final AdminDashboardMapper mapper;

    public AdminDashboardServiceImpl(AdminDashboardMapper mapper) {
        this.mapper = mapper;
    }

    /** 전체 학생 수 */
    @Override
    public int getTotalStudents() {
        return mapper.getTotalStudents();
    }

    /** 전체 강사 수 */
    @Override
    public int getTotalLectures() {
        return mapper.getTotalLectures();
    }

    /** 학생 평균 출석률 (%) — DB 값(0~1)에 *100 적용 */
    @Override
    public double getStudentAvgRate() {
        return mapper.getStudentAvgRate() * 100;
    }

    /** 강사 평균 출석률 (%) */
    @Override
    public double getLectureAvgRate() {
        return mapper.getLectureAvgRate() * 100;
    }

    /** 오늘 결석자 수 */
    @Override
    public int getTodayAbsents() {
        return mapper.getTodayAbsents();
    }

    /** 요일별 출석률 */
    @Override
    public List<Map<String, Object>> getWeeklyAttendRate() {
        return mapper.getWeeklyAttendRate();
    }

    /** 상담 신청 대기 */
    @Override
    public int getPendingCounselCount() {
        return mapper.getPendingCounselCount();
    }

    /** 휴가 신청 대기 */
    @Override
    public int getPendingVacationCount() {
        return mapper.getPendingVacationCount();
    }

    /** 기자재 렌탈 신청 대기 */
    @Override
    public int getPendingDeviceRentCount() {
        return mapper.getPendingDeviceRentCount();
    }
}