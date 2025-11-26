package com.kh.classLink.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.classLink.model.vo.*;
import com.kh.classLink.service.AdminDashboardService;
import com.kh.classLink.service.StudentDashboardService;
import com.kh.classLink.service.TeacherDashboardService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class DashboardController {

    private final StudentDashboardService studentDashboardService;
    private final AdminDashboardService adminDashboardService;
    private final TeacherDashboardService teacherDashboardService;
    private final ObjectMapper objectMapper = new ObjectMapper();

    public DashboardController(StudentDashboardService studentDashboardService,
                               AdminDashboardService adminDashboardService,
                               TeacherDashboardService teacherDashboardService) {
        this.studentDashboardService = studentDashboardService;
        this.adminDashboardService = adminDashboardService;
        this.teacherDashboardService = teacherDashboardService;
    }

    /**
     * 관리자 대시보드 화면
     * @return 관리자 대시보드 페이지
     */
    @GetMapping("/adminDashboard.co")
    public String adminDashboard(Model model) throws JsonProcessingException {

        // 기본 통계
        model.addAttribute("totalStudents", adminDashboardService.getTotalStudents());
        model.addAttribute("totalLectures", adminDashboardService.getTotalLectures());
        model.addAttribute("studentAvgRate", adminDashboardService.getStudentAvgRate());
        model.addAttribute("lectureAvgRate", adminDashboardService.getLectureAvgRate());
        model.addAttribute("todayAbsents", adminDashboardService.getTodayAbsents());

        // 승인 대기 건수
        model.addAttribute("pendingCounsel", adminDashboardService.getPendingCounselCount());
        model.addAttribute("pendingVacation", adminDashboardService.getPendingVacationCount());
        model.addAttribute("pendingDeviceRent", adminDashboardService.getPendingDeviceRentCount());

        // 요일별 출석률(JSON 변환)
        String weeklyJson = objectMapper.writeValueAsString(adminDashboardService.getWeeklyAttendRate());
        model.addAttribute("weeklyJson", weeklyJson);

        return "admin/adminDashboard";
    }

    /**
     * 강사 대시보드 화면
     * @return 강사 대시보드 페이지
     */
    @GetMapping("/lectureDashboard")
    public String lectureDashboard(HttpSession session, Model model) {

        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            session.setAttribute("alertMsg", "로그인이 필요합니다.");
            return "redirect:/login.co";
        }

        int teacherNo = loginMember.getMemberNo();

        // 출석률
        double attendanceRate = teacherDashboardService.getTeacherAttendanceRate(teacherNo);
        model.addAttribute("attendanceRate", attendanceRate);

        // 반별 평균 성적
        List<ClassAvgScore> classAvgScores = teacherDashboardService.getTeacherClassAvgScores(teacherNo);
        model.addAttribute("classAvgScores", classAvgScores);

        // 최근 신청 리스트(옵션)
        List<RecentApplication> recentApplicationList = teacherDashboardService.getRecentApplications(teacherNo);
        model.addAttribute("recentApplicationList", recentApplicationList);

        return "lecture/leDashboard";
    }

    /**
     * 학생 대시보드
     * - 이번달 출석 통계
     * - 해당 주차 출석 상세 내역
     * - 오늘 일정
     * - 주간 이동 제어
     *
     * @param weekOffset 주차 이동 값 (0=이번주, 1=지난주, 2=지지난주…)
     * @param session 로그인 세션
     * @param model JSP로 데이터 전달용
     * @return 학생 대시보드 페이지
     */
    @GetMapping("/stMain.co")
    public String stMain(@RequestParam(defaultValue = "0") int weekOffset,
                         HttpSession session,
                         Model model) {

        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            session.setAttribute("alertMsg", "로그인이 필요합니다.");
            return "redirect:/login.co";
        }

        int memberNo = loginMember.getMemberNo();

        if (weekOffset < 0) {
            weekOffset = 0;
        }

        try {
            AttendanceStats stats = studentDashboardService.getMonthlyAttendance(memberNo);
            if (stats == null) {
                stats = new AttendanceStats(0, 0, 0);
            }
            model.addAttribute("attendanceData", stats);

            List<Attend> weeklyList = studentDashboardService.getWeeklyAttendance(memberNo, weekOffset);
            model.addAttribute("weeklyList", weeklyList);

            List<LectureDate> todaySchedule = studentDashboardService.getTodaySchedule(memberNo);
            model.addAttribute("todaySchedule", todaySchedule);

            model.addAttribute("weekOffset", weekOffset);

            boolean hasPrevWeek = studentDashboardService.hasPrevWeek(memberNo, weekOffset);
            model.addAttribute("hasPrevWeek", hasPrevWeek);

        } catch (Exception e) {
            model.addAttribute("attendanceData", new AttendanceStats(0, 0, 0));
            model.addAttribute("weeklyList", List.of());
            model.addAttribute("todaySchedule", List.of());
        }

        return "student/stMain";
    }
}