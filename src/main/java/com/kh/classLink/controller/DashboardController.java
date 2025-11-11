package com.kh.classLink.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.classLink.model.vo.Attend;
import com.kh.classLink.model.vo.AttendanceStats;
import com.kh.classLink.model.vo.LectureDate;
import com.kh.classLink.model.vo.Member;
import com.kh.classLink.service.AdminDashboardService;
import com.kh.classLink.service.StudentDashboardService;
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
    private final ObjectMapper objectMapper = new ObjectMapper();

    public DashboardController(StudentDashboardService studentDashboardService,
                               AdminDashboardService adminDashboardService) {
        this.studentDashboardService = studentDashboardService;
        this.adminDashboardService = adminDashboardService;
    }

    /**
     * 관리자 대시보드 화면
     * @return 관리자 대시보드 페이지
     */
    @GetMapping("/adminDashboard.co")
    public String adminDashboard(Model model) throws JsonProcessingException {

        model.addAttribute("totalStudents", adminDashboardService.getTotalStudents());
        model.addAttribute("totalLectures", adminDashboardService.getTotalLectures());
        model.addAttribute("studentAvgRate", adminDashboardService.getStudentAvgRate());
        model.addAttribute("lectureAvgRate", adminDashboardService.getLectureAvgRate());
        model.addAttribute("todayAbsents", adminDashboardService.getTodayAbsents());


        model.addAttribute("pendingCounsel", adminDashboardService.getPendingCounselCount());
        model.addAttribute("pendingVacation", adminDashboardService.getPendingVacationCount());
        model.addAttribute("pendingDeviceRent", adminDashboardService.getPendingDeviceRentCount());

        // 요일별 출석률 → JSON 변환
        String weeklyJson = objectMapper.writeValueAsString(adminDashboardService.getWeeklyAttendRate());
        model.addAttribute("weeklyJson", weeklyJson);


        return "admin/adminDashboard";
    }

    /**
     * 강사 대시보드 화면
     * @return 강사 대시보드 페이지
     */
    @GetMapping("/lectureDashboard")
    public String lectureDashboard() {
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

        // 로그인 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            session.setAttribute("alertMsg", "로그인이 필요합니다.");
            return "redirect:/login.co";
        }

        int memberNo = loginMember.getMemberNo();
        System.out.println("🔑 로그인 MEMBER_NO: " + memberNo);

        // 미래 주차 이동 방지
        if (weekOffset < 0) {
            weekOffset = 0;
        }

        try {
            // 이번달 출석 통계
            AttendanceStats stats = studentDashboardService.getMonthlyAttendance(memberNo);
            System.out.println("📊 출석 통계: " + stats);

            if (stats == null) {
                stats = new AttendanceStats(0, 0, 0);
                System.out.println("⚠️ 출석 데이터 없음 - 기본값 설정");
            }
            model.addAttribute("attendanceData", stats);

            // 주간 출석 상세
            List<Attend> weeklyList = studentDashboardService.getWeeklyAttendance(memberNo, weekOffset);
            System.out.println("📅 주간 출석: " + weeklyList.size() + "건");
            model.addAttribute("weeklyList", weeklyList);

            // 오늘 일정
            List<LectureDate> todaySchedule = studentDashboardService.getTodaySchedule(memberNo);
            System.out.println("📌 오늘 일정: " + todaySchedule.size() + "건");
            model.addAttribute("todaySchedule", todaySchedule);

            // 주간 이동 관련
            model.addAttribute("weekOffset", weekOffset);
            boolean hasPrevWeek = studentDashboardService.hasPrevWeek(memberNo, weekOffset);
            System.out.println("◀️ 이전주 존재: " + hasPrevWeek);
            model.addAttribute("hasPrevWeek", hasPrevWeek);

        } catch (Exception e) {
            System.err.println("❌ 대시보드 로딩 오류: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("attendanceData", new AttendanceStats(0, 0, 0));
            model.addAttribute("weeklyList", List.of());
            model.addAttribute("todaySchedule", List.of());
        }

        return "student/stMain";
    }
}
